package com.sirolf2009.silk

import org.junit.Assert
import org.parboiled.Rule
import org.parboiled.buffers.IndentDedentInputBuffer
import org.parboiled.errors.InvalidInputError
import org.parboiled.parserunners.ReportingParseRunner
import org.parboiled.support.ParseTreeUtils
import org.parboiled.support.ParsingResult

class ParserUtil {

	def static parse(CharSequence input, Rule rule) {
		val result = new ReportingParseRunner(rule).run(new IndentDedentInputBuffer(input.toString().trim().toCharArray, 2, ";", true))
		println(ParseTreeUtils.printNodeTree(result))
		println("Result: "+result.resultValue.toString)
		result.parseErrors.forEach [
			val position = result.inputBuffer.getPosition(startIndex)
			if(it instanceof InvalidInputError) {
				failedMatchers.forEach [
					System.err.println("Expected: " + element.matcher)
				]
			}
			System.err.println(result.inputBuffer.extract(startIndex, endIndex))
			System.err.println(position.line + " " + startIndex + ":" + endIndex)
			System.err.println(result.inputBuffer.extractLine(position.line).replace("\t", " "))
			(0 ..< position.column - 1).forEach[System.err.print("-")]
			(startIndex ..< endIndex).forEach[System.err.print("^")]
			System.err.println()
		]
		if(result.parseErrors.size() > 0) {
			throw new RuntimeException()
		}
		return result
	}

	def static assertWrapsType(Rule expected, ParsingResult<?> result) {
		Assert.assertEquals(expected, result.parseTreeRoot.children.get(0).matcher)
	}

}
