/*
 * generated by Xtext 2.10.0
 */
package org.example.expressions.generator

import com.google.inject.Inject
import org.eclipse.emf.ecore.resource.Resource
import org.eclipse.xtext.generator.AbstractGenerator
import org.eclipse.xtext.generator.IFileSystemAccess2
import org.eclipse.xtext.generator.IGeneratorContext
import org.example.expressions.expressions.ExpressionsModel
import org.example.expressions.interpreter.ExpressionsInterpreter

import static extension org.eclipse.xtext.nodemodel.util.NodeModelUtils.*

/**
 * Generates code from your model files on save.
 * 
 * See https://www.eclipse.org/Xtext/documentation/303_runtime_concepts.html#code-generation
 */
class ExpressionsGenerator extends AbstractGenerator {

	@Inject extension ExpressionsInterpreter

	override void doGenerate(Resource resource, IFileSystemAccess2 fsa, IGeneratorContext context) {
		resource.allContents.toIterable.filter(ExpressionsModel).forEach [
			fsa.generateFile
				('''«resource.URI.lastSegment».evaluated''',
					interpretExpressions)
		]
	}

	def interpretExpressions(ExpressionsModel model) {
		model.elements.map [
			'''«getNode.getTokenText» ~> «interpret»'''
		].join("\n")
	}
}