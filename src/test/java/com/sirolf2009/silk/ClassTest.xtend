package com.sirolf2009.silk

import org.junit.Test
import org.parboiled.Parboiled

import static extension com.sirolf2009.silk.ParserUtil.*

class ClassTest {
	
	val parser = Parboiled.createParser(SilkParser)
	val mapper = new SilkMapper()
	
	@Test
	def void testClass() {
		val result = '''
		package com.sirolf2009.silk.example
		Object Example
				
			function printMessage (String message)
				println message
			
			function helloWorld ()
				printMessage "Hello World!"
		
			function main (List<String> args)
				val example = new Example
				example.helloWorld
		'''.parse(parser.Class)
		mapper.map(parser, result.parseTreeRoot)
	}
}