package com.sirolf2009.silk

import com.sirolf2009.silk.ast.BinaryExpression
import com.sirolf2009.silk.ast.Expression
import com.sirolf2009.silk.ast.literal.LiteralInteger
import com.sirolf2009.silk.ast.literal.LiteralString
import com.sirolf2009.silk.ast.literal.LiteralSymbol
import java.util.ArrayList
import java.util.function.Consumer
import org.parboiled.Action
import org.parboiled.BaseParser
import org.parboiled.Context
import org.parboiled.Rule
import org.parboiled.annotations.BuildParseTree
import org.parboiled.annotations.DontLabel
import org.parboiled.annotations.SuppressNode
import org.parboiled.annotations.SuppressSubnodes

@BuildParseTree
class SilkParser extends BaseParser<Object> {

	protected static val printValueStack = new Action<Object>() {
		override run(Context<Object> context) {
			println("Head: " + context.valueStack.peek + " " + context.valueStack.toList)
			return true
		}
	}

	def Rule Class() {
		return Sequence(
			PackageDeclaration,
			EOL,
			Symbol,
			Spacing,
			Symbol,
			EOL,
			INDENT,
			ZeroOrMore(FirstOf(EmptyLine, FunctionDeclaration)),
			DEDENT,
			EOI
		)
	}

	def Rule PackageDeclaration() {
		val packageList = new ArrayList()
		val addToList = new Action<Object>() {
			override run(Context<Object> context) {
				packageList.add(pop)
			}
		}
		return Sequence(Sequence(PACKAGE.suppressNode, Sequence(
			Symbol(),
			addToList,
			ZeroOrMore(
				Sequence(Ch('.'), Symbol(), addToList)
			)
		)), push(packageList))
	}

	def Rule FunctionDeclaration() {
		return Sequence(
			FUNCTION,
			Symbol,
			Spacing,
			Arguments,
			EOL,
			INDENT,
			ZeroOrMore(Statement),
			DEDENT
		)
	}

	def Rule Arguments() {
		val argumentList = new ArrayList()
		val addToList = new Action<Object>() {
			override run(Context<Object> context) {
				val a = pop
				val b = pop
				argumentList.add(b -> a)
			}
		}
		return Sequence(
			Ch('(').suppressNode,
			Optional(
				Sequence(Type, Spacing, Symbol),
				push(pop -> pop),
				ZeroOrMore(Sequence(Ch(',').suppressNode, Spacing, Type, Spacing, Symbol, addToList))
			),
			Ch(')').suppressNode,
			push(argumentList)
		)
	}

	def Rule Statement() {
		return FirstOf(FunctionCall, VariableDeclaration, Expression, Literal)
	}

	def Rule FunctionCall() {
		return FirstOf(RemoteFunctionCall, LocalFunctionCall)
	}

	def Rule LocalFunctionCall() {
		return Sequence(Symbol, ZeroOrMore(Sequence(Spacing, Literal)), EOL)
	}

	def Rule RemoteFunctionCall() {
		return Sequence(Symbol, Ch('.'), LocalFunctionCall)
	}

	def Rule VariableDeclaration() {
		return Sequence(VAL, Symbol, Spacing, EQUALS, Statement)
	}

	def Rule Expression() {
		return FirstOf(Sequence(Literal, TestNot(Sequence(Spacing, Operator))), 
			Sequence(Literal, Spacing, Operator, Spacing, Literal, action[
				val right = valueStack.pop as Expression<?>
				val operator = valueStack.pop as String
				val left = valueStack.pop as Expression<?>
				if(left instanceof Number) {
					
				} else {
					val method = left.type.class.methods.findFirst[name.equals(operator) && parameters.size == 1 && parameters.get(0).type == right.type]
					if(method !== null) {
						valueStack.push(new BinaryExpression() {
							override eval(Scope scope) {
								return method.invoke(left.eval(scope), right.eval(scope))
							}
						})
					} else {
						throw new IllegalArgumentException("")
					}
				}
			]))
	}

	def Rule Operator() {
		return FirstOf(
			PLUS,
			MINUS,
			MULTIPLY,
			DIVIDE
		)
	}

	def Rule EmptyLine() {
		return Sequence(Optional(Spacing), EOL)
	}

	def Rule EOL() {
		return Ch('\n')
	}

	def Rule Type() {
		return FirstOf(TypeName, FullyQualifiedType)
	}

	def Rule FullyQualifiedType() {
		return Sequence(ZeroOrMore(Sequence(Symbol, Ch('.'))), TypeName)
	}

	def Rule TypeName() {
		return Sequence(Symbol, TestNot(Ch('.')), Optional(
			Sequence(
				Ch('<').suppressNode,
				Optional(
					Sequence(Type, Spacing, ZeroOrMore(
						Sequence(Ch(',').suppressNode, Spacing, Symbol)
					))
				),
				Ch('>').suppressNode
			)
		))
	}

	def Rule Literal() {
		return Sequence(FirstOf(Number, LiteralString, Symbol), Spacing)
	}

	@SuppressSubnodes
	def Rule LiteralString() {
		return Sequence(Ch('"'), Sequence(ZeroOrMore(TestNot(AnyOf("\r\n\"\\")), ANY).suppressSubnodes(), action[valueStack.push(new LiteralString(getMatch()))], Ch('"')))
	}

	@SuppressSubnodes
	def Rule Number() {
		return Sequence(OneOrMore(CharRange('0', '9')), action[valueStack.push(new LiteralInteger(Integer.parseInt(it.getMatch())))])
	}

	@SuppressSubnodes
	def Rule Symbol() {
		return Sequence(Sequence(FirstOf(CharRange('a', 'z'), CharRange('A', 'Z')), OneOrMore(FirstOf(CharRange('a', 'z'), CharRange('A', 'Z'), CharRange('0', '9')))).suppressNode, action[valueStack.push(new LiteralSymbol(new Symbol(it.match)))])
	}

	@SuppressNode
	def Rule Spacing() {
		return ZeroOrMore(Ch(' '))
	}

	public final Rule PACKAGE = Terminal("package")
	public final Rule FUNCTION = Terminal("function")
	public final Rule VAL = Terminal("val")
	public final Rule EQUALS = Terminal("=")
	public final Rule PLUS = Terminal("+")
	public final Rule MINUS = Terminal("-")
	public final Rule MULTIPLY = Terminal("*")
	public final Rule DIVIDE = Terminal("/")

	@SuppressNode
	@DontLabel
	def Rule Terminal(String string) {
		return Sequence(string, Spacing()).label('\'' + string + '\'');
	}
	
	def static action(Consumer<Context<Object>> action) {
		return new Action<Object>() {
			override run(Context<Object> context) {
				action.accept(context)
				return true
			}
		}
	}

	def static Action<Object> popAction(int down) {
		return new Action<Object>() {
			override run(Context<Object> context) {
				println("Popped: " + context.valueStack.pop(down))
				return true
			}
		}
	}

}
