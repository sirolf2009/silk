package com.sirolf2009.silk.ast

import java.lang.reflect.ParameterizedType
import java.lang.reflect.Type

interface BinaryExpression<A, B, C> extends Expression<C> {
	
	def Type getLeftType() {
		return (class.genericSuperclass as ParameterizedType).actualTypeArguments.get(0)
	}
	
	def Type getRightType() {
		return (class.genericSuperclass as ParameterizedType).actualTypeArguments.get(1)
	}
	
	override Type getType() {
		return (class.genericSuperclass as ParameterizedType).actualTypeArguments.get(2)
	}
	
}