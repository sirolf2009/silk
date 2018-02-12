package com.sirolf2009.silk.ast

import java.util.List
import org.eclipse.xtend.lib.annotations.Data

@Data class SilkObject {
	
	val List<String> packageLocation
	val List<FunctionDeclaration> functions
	
}