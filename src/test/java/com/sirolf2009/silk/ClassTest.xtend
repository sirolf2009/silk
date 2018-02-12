package com.sirolf2009.silk

import org.junit.Test
import org.parboiled.Parboiled

import static extension com.sirolf2009.silk.ParserUtil.*
import org.junit.Assert

class ClassTest {
	
	val parser = Parboiled.createParser(SilkParser)
	val mapper = new SilkMapper(parser)
	
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
		mapper.map(result.parseTreeRoot)
	}
	
	@Test
	def void testPackage() {
		val result = '''
		package com.sirolf2009.silk.example
		'''.parse(parser.PackageDeclaration)
		Assert.assertEquals(#[#["com", "sirolf2009", "silk", "example"]], result.valueStack.toList)
	}
	
}