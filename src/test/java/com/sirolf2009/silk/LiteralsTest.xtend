package com.sirolf2009.silk

import com.sirolf2009.silk.ast.literal.LiteralInteger
import com.sirolf2009.silk.ast.literal.LiteralString
import com.sirolf2009.silk.ast.literal.LiteralSymbol
import org.junit.Assert
import org.junit.Test
import org.parboiled.Parboiled

import static extension com.sirolf2009.silk.ParserUtil.parse

class LiteralsTest {

	val parser = Parboiled.createParser(SilkParser)

	@Test
	def void testNumber() {
		Assert.assertEquals(new LiteralInteger(0), "0".parse(parser.Number).resultValue)
		Assert.assertEquals(new LiteralInteger(12), "12".parse(parser.Number).resultValue)
	}

	@Test
	def void testString() {
		Assert.assertEquals(new LiteralString("Hello World"), '''"Hello World"'''.parse(parser.LiteralString).resultValue)
	}

	@Test
	def void testSymbol() {
		Assert.assertEquals(new LiteralSymbol(new Symbol("ThisIsASymbol")), '''ThisIsASymbol'''.parse(parser.Symbol).resultValue)
	}

}
