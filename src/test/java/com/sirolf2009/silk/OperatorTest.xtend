package com.sirolf2009.silk

import org.parboiled.Parboiled
import org.junit.Test

import static extension com.sirolf2009.silk.ParserUtil.parse

class OperatorTest {
	
	val parser = Parboiled.createParser(SilkParser)
	
	@Test
	def void testOperators() {
		'''
		+
		'''.parse(parser.Operator)
	}
	
	@Test
	def void testBinaryExpressions() {
		'''
		5 + 5
		'''.parse(parser.Expression)
	}
}