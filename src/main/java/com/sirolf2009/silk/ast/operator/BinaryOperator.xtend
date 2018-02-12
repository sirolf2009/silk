package com.sirolf2009.silk.ast.operator

import com.sirolf2009.silk.Scope

interface BinaryOperator<A,B, C> {
	
	//TODO at compile time, we won't know A, B or C. Maybe make it a higher order function that is supposed to return an operator (or error) based on A and B?
	
	def C eval(Scope scope, A a, B b)
	
}