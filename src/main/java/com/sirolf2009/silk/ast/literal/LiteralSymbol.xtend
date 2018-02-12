package com.sirolf2009.silk.ast.literal

import com.sirolf2009.silk.Scope
import com.sirolf2009.silk.Symbol
import com.sirolf2009.silk.ast.Expression
import org.eclipse.xtend.lib.annotations.Data

@Data class LiteralSymbol implements Expression<Symbol> {
	
	val Symbol data
	
	override eval(Scope scope) {
		return data
	}
	
}