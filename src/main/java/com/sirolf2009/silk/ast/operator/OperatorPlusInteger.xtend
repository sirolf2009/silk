package com.sirolf2009.silk.ast.operator

import com.sirolf2009.silk.Scope
import org.eclipse.xtend.lib.annotations.Data

@Data class OperatorPlusInteger implements BinaryOperator<Integer, Integer, Integer> {

	override eval(Scope scope, Integer left, Integer right) {
		return left + right
	}

}
