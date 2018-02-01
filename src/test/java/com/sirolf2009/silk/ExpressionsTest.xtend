package com.sirolf2009.silk

import org.junit.Test
import org.parboiled.Parboiled

import static extension com.sirolf2009.silk.ParserUtil.parse

class ExpressionsTest {

	val parser = Parboiled.createParser(SilkParser)

	@Test
	def void testAddition() {
		println("+".parse(parser.Operator))
		println("1 + 2".parse(parser.Expression))
	}

}