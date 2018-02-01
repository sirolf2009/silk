package com.sirolf2009.silk

import org.junit.Test
import org.parboiled.Parboiled

import static extension com.sirolf2009.silk.ParserUtil.parse

class StatementsTest {
	
	val parser = Parboiled.createParser(SilkParser)
	
	@Test
	def void testVariableAssignment() {
		'''val message = "Hello World!"'''.parse(parser.VariableDeclaration)
	}
	
}