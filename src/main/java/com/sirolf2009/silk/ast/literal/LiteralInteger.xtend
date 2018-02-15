package com.sirolf2009.silk.ast.literal

import com.sirolf2009.silk.Scope
import com.sirolf2009.silk.ast.BinaryExpression
import org.eclipse.xtend.lib.annotations.Data

@Data class LiteralInteger extends LiteralNumber<Integer> {
	
	val Integer data
	
	override eval(Scope scope) {
		return data
	}
	
	def +(LiteralInteger other) {
		return new BinaryExpression<Integer, Integer, Integer>() {
			override eval(Scope scope) {
				return data + other.data
			}
			
		}
	}
	
}