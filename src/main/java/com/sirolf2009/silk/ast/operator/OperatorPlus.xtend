package com.sirolf2009.silk.ast.operator

import com.sirolf2009.silk.Scope
import com.sirolf2009.silk.ast.literal.LiteralNumber
import org.eclipse.xtend.lib.annotations.Data

@Data class OperatorPlus implements BinaryOperator<Object, Object, Object> {
	
	override eval(Scope scope, Object left, Object right) {
		if(left instanceof Number && right instanceof Number) {
			return add(left as Number, right as Number)
		} else if(left instanceof LiteralNumber<?> && right instanceof LiteralNumber<?>) {
			return add((left as LiteralNumber<?>).eval(scope), (right as LiteralNumber<?>).eval(scope))
		}
	}

	def Number add(Number left, Number right) {
		if(left instanceof Double || right instanceof Double) {
			return left.doubleValue() + right.doubleValue()
		} else if(left instanceof Float || right instanceof Float) {
			return left.floatValue() + right.floatValue()
		} else if(left instanceof Long || right instanceof Long) {
			return left.longValue() + right.longValue()
		} else if(left instanceof Integer || right instanceof Integer) {
			return left.intValue() + right.intValue()
		} else if(left instanceof Short || right instanceof Short) {
			return (left.shortValue() + right.shortValue()).shortValue
		} else if(left instanceof Byte || right instanceof Byte) {
			return (left.byteValue() + right.byteValue()).byteValue
		} else {
			throw new UnsupportedOperationException()
		}
	}

}
