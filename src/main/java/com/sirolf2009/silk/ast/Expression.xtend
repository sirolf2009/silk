package com.sirolf2009.silk.ast

import com.sirolf2009.silk.Scope

interface Expression<T> {
	
	def T eval(Scope scope)
	
}