package com.sirolf2009.silk

import org.parboiled.Node
import java.util.List

class SilkMapper {
	
	val traverser = new SilkTreeTraverser()
	val SilkParser parser
	
	new(SilkParser parser) {
		this.parser = parser
	}
	
	def map(Node<Object> node) {
		switch(node.matcher) {
			case parser.Class: return mapClass(node)
		}
	}
	
	def mapClass(Node<Object> node) {
		val package = node.children.findFirst[matcher == parser.PackageDeclaration].mapPackage
		println(node.children)
	}
	
	def mapPackage(Node<Object> node) {
		return node.value as List<String>
	}
	
}