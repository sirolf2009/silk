package com.sirolf2009.silk

import org.parboiled.Node

class SilkMapper {
	
	val traverser = new SilkTreeTraverser()
	
	def map(SilkParser parser, Node<Object> node) {
		switch(node.matcher) {
			case parser.Class: return mapClass(parser, node)
		}
	}
	
	def mapClass(SilkParser parser, Node<Object> node) {
		println(node.children.findFirst[matcher == parser.PackageDeclaration].children.get(0).children.get(0).value)
	}
	
}