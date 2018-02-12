package com.sirolf2009.silk.ast.literal

import com.sirolf2009.silk.Scope
import org.eclipse.xtend.lib.annotations.Data

@Data class LiteralByte extends LiteralNumber<Byte> {
	
	val Byte data
	
	override eval(Scope scope) {
		return data
	}
	
}