package com.sirolf2009.silk.ast.literal

import com.sirolf2009.silk.Scope
import org.eclipse.xtend.lib.annotations.Data

@Data class LiteralShort extends LiteralNumber<Short> {
	
	val Short data
	
	override eval(Scope scope) {
		return data
	}
	
}