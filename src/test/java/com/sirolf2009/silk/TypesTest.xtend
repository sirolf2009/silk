package com.sirolf2009.silk

import org.junit.Test
import org.parboiled.Parboiled

import static extension com.sirolf2009.silk.ParserUtil.*

class TypesTest {
	
	val parser = Parboiled.createParser(SilkParser)
	
	@Test
	def void testPackage() {
		'''
		package com.sirolf2009.silk
		'''.parse(parser.PackageDeclaration)
	}
	
	@Test
	def void testTypeName() {
		assertWrapsType(parser.TypeName, '''Object'''.parse(parser.Type))
		assertWrapsType(parser.TypeName, '''List<String>'''.parse(parser.Type))
		assertWrapsType(parser.TypeName, '''Map<String, Integer>'''.parse(parser.Type))
	}
	
	@Test
	def void testFullyQualifiedType() {
		assertWrapsType(parser.FullyQualifiedType, '''com.sirolf2009.silk.TypesTest'''.parse(parser.Type))
	}
	
}