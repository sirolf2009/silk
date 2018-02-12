package com.sirolf2009.silk

import org.junit.Test
import org.parboiled.Parboiled

import static extension com.sirolf2009.silk.ParserUtil.parse
import com.sirolf2009.silk.ast.BinaryExpression
import org.junit.Assert
import com.sirolf2009.silk.ast.operator.OperatorPlus
import com.sirolf2009.silk.ast.literal.LiteralInteger
import com.sirolf2009.silk.ast.operator.OperatorPlusInteger

class ExpressionsTest {

	val parser = Parboiled.createParser(SilkParser)

	@Test
	def void testAddition() {
		Assert.assertEquals(new OperatorPlus(), "+".parse(parser.Operator).valueStack.pop)
		val simpleAddition = "1 + 2".parse(parser.Expression)
		Assert.assertEquals(new BinaryExpression<Integer, Integer, Integer>(new LiteralInteger(1), new OperatorPlusInteger(), new LiteralInteger(2)), simpleAddition.valueStack.pop())
	}

}