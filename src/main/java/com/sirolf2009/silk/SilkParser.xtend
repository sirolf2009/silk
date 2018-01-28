package com.sirolf2009.silk

import org.parboiled.BaseParser
import org.parboiled.Parboiled
import org.parboiled.Rule
import org.parboiled.annotations.BuildParseTree
import org.parboiled.buffers.IndentDedentInputBuffer
import org.parboiled.parserunners.ReportingParseRunner
import org.parboiled.support.ParseTreeUtils
import java.util.Arrays

@BuildParseTree
class SilkParser extends BaseParser<Object> {
	
	def static void main(String[] args) {
		val parser = Parboiled.createParser(SilkParser)
		val input = '''
		package com.sirolf2009.silk.example
		Object Example
		
			function helloWorld ()
				println "Hello World!"
		
			pure function main (List<String> args)
				val example = new Example
				example.helloWorld()
		'''
		println(Arrays.toString(input.trim().toCharArray))
		val result = new ReportingParseRunner(parser.Class).run(new IndentDedentInputBuffer(input.trim().toCharArray, 2, ";", true))
		result.parseErrors.forEach[
			println(it.endIndex)
		]
		println(ParseTreeUtils.printNodeTree(result))
		println(result.matched)
	}
	
	def Rule Class() {
		return Sequence(
			Package, EOL,
			Word, Spacing, Word, EOL,
			ZeroOrMore(
				
			)
		)
	}
	
    def Rule EOL() {
    	return Ch('\n')
    }

    def Rule Package() {
        return Sequence(String('package'), Spacing(), Word(), ZeroOrMore(Sequence(Ch('.'), Word())))
    }
    
    def Rule Spacing() {
    	return ZeroOrMore(Ch(' '))
    }

    def Rule Number() {
        return OneOrMore(CharRange('0', '9'))
    }
    
    def Rule Word() {
    	return Sequence(FirstOf(CharRange('a', 'z'), CharRange('A', 'Z')), OneOrMore(FirstOf(CharRange('a', 'z'), CharRange('A', 'Z'), CharRange('0', '9'))))
    }
	
}