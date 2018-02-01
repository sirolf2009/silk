package com.sirolf2009.silk

import org.parboiled.BaseParser
import org.parboiled.Rule
import org.parboiled.annotations.BuildParseTree
import org.parboiled.annotations.DontLabel
import org.parboiled.annotations.SuppressNode
import org.parboiled.annotations.SuppressSubnodes
import org.parboiled.Action
import org.parboiled.Context

@BuildParseTree
class SilkParser extends BaseParser<Object> {

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
		return Sequence(
			Ch('(').suppressNode,
			Optional(
				Sequence(Type, Spacing, Symbol),
				ZeroOrMore(Sequence(Ch(',').suppressNode, Spacing, Type, Spacing, Symbol))
			),
			Ch(')').suppressNode
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
		return FirstOf(
		Sequence(Literal, TestNot(Sequence(Spacing, Operator))),
		Sequence(Literal, Spacing, Operator, Spacing, Literal))
	}

	def Rule Operator() {
		return FirstOf(PLUS, MINUS, MULTIPLY, DIVIDE)
	}

	def Rule EmptyLine() {
		return Sequence(Optional(Spacing), EOL)
	}

	def Rule EOL() {
		return Ch('\n')
	}

	def Rule PackageDeclaration() {
		return Sequence(PACKAGE.suppressNode, Sequence(Symbol(), ZeroOrMore(Sequence(Ch('.'), Symbol())).suppressNode))
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
		return Sequence(Ch('"'), Sequence(ZeroOrMore(TestNot(AnyOf("\r\n\"\\")), ANY).suppressSubnodes(), push(0, match)), Ch('"'))
	}

	@SuppressSubnodes
	def Rule Number() {
		return OneOrMore(CharRange('0', '9'), push(Integer.parseInt(match)))
	}

	@SuppressSubnodes
	def Rule Symbol() {
		return Sequence(FirstOf(CharRange('a', 'z'), CharRange('A', 'Z')), OneOrMore(FirstOf(CharRange('a', 'z'), CharRange('A', 'Z'), CharRange('0', '9'))), push(match))
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

}
