package com.sirolf2009.silk

import org.junit.Test
import org.parboiled.Parboiled

import static extension com.sirolf2009.silk.ParserUtil.parse

class FunctionsTest {
	
	val parser = Parboiled.createParser(SilkParser)
	
	@Test
	def void testSimpleFunction() {
		'''
		function helloWorld ()
			println "Hello"
			println "Hello World"
		'''.parse(parser.FunctionDeclaration)
		'''
		function helloWorld (String message)
			println message
		'''.parse(parser.FunctionDeclaration)
		'''
		pure function main (List<String> args)
			println "Hello World"
		'''.parse(parser.FunctionDeclaration)
	}
	
	@Test
	def void testArguments() {
		'''()'''.parse(parser.Arguments)
		'''(String message)'''.parse(parser.Arguments)
		'''(String message2, int count)'''.parse(parser.Arguments)
	}
	
}