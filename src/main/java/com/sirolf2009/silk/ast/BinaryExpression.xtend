package com.sirolf2009.silk.ast

import org.eclipse.xtend.lib.annotations.Data
import com.sirolf2009.silk.Scope
import com.sirolf2009.silk.ast.operator.BinaryOperator

@Data class BinaryExpression<A, B, C> implements Expression<C> {
	
	val Expression<A> left
	val BinaryOperator<A, B, C> operator
	val Expression<B> right
	
	override eval(Scope scope) {
		return operator.eval(scope, left.eval(scope), right.eval(scope))
	}
	
}