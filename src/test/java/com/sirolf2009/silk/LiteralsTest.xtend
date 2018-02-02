package com.sirolf2009.silk

import org.junit.Assert
import org.junit.Test
import org.parboiled.Parboiled

import static extension com.sirolf2009.silk.ParserUtil.parse

class LiteralsTest {

	val parser = Parboiled.createParser(SilkParser)

	@Test
	def void testNumber() {
		Assert.assertEquals(0, "0".parse(parser.Number).resultValue)
	}

	@Test
	def void testString() {
		Assert.assertEquals("Hello World", '''"Hello World"'''.parse(parser.LiteralString).resultValue)
	}

	@Test
	def void testSymbol() {
		Assert.assertEquals("ThisIsASymbol", '''ThisIsASymbol'''.parse(parser.Symbol).resultValue)
	}

}
