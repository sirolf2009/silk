package com.sirolf2009.silk.ast

import com.sirolf2009.silk.Scope
import java.lang.reflect.ParameterizedType
import java.lang.reflect.Type

interface Expression<T> {
	
	def T eval(Scope scope)
	
	def Type getType() {
		return (class.genericSuperclass as ParameterizedType).actualTypeArguments.get(0)
	}
	
}