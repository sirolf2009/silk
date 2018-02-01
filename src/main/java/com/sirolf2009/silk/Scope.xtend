package com.sirolf2009.silk

import java.util.HashMap
import java.util.Map
import java.util.Optional
import org.eclipse.xtend.lib.annotations.FinalFieldsConstructor

@FinalFieldsConstructor class Scope {
	
	val Optional<Scope> parent
	val Map<String, Object> variables = new HashMap()
	
	def Optional<Object> getVariable(String name) {
		if(variables.containsKey(name)) {
			return Optional.of(variables.get(name))
		}
		if(parent.present) {
			return parent.get().getVariable(name)
		}
		return Optional.empty()
	}
	
	def createSubContext() {
		return new Scope(Optional.of(this))
	}
	
}