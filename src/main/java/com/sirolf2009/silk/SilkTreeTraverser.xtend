package com.sirolf2009.silk

import com.google.common.collect.TreeTraverser
import org.parboiled.Node

class SilkTreeTraverser extends TreeTraverser<Node<Object>> {
	
	override children(Node<Object> root) {
		return root.children
	}
	
}