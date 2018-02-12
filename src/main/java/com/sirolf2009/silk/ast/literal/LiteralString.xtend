package com.sirolf2009.silk.ast.literal

import com.sirolf2009.silk.Scope
import com.sirolf2009.silk.ast.Expression
import org.eclipse.xtend.lib.annotations.Data

@Data class LiteralString implements Expression<String> {
	
	val String data
	
	override eval(Scope scope) {
		return data
	}
	
}