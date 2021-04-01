//
//  variable-declaration-parsing.swift
//  LittleSwiftComputer
//
//  Created by Caleb Wilson on 31/03/2021.
//

import Foundation

class DeclarationParser {
    
    func getDeclaredVariables(declarationString : String) throws -> [DeclaredVariable] {
        var declaredVariables = [DeclaredVariable]()
        let lines = declarationString.convertToEnumeratedArrayOfLines().filter { $0.element != "" }
       
        try lines.forEach { index, declaration in
            do {
                let newInstruction = try parseDeclarationLine(declaration: declaration, index: index)
                declaredVariables.append(newInstruction)
            } catch {
                throw error
            }
        }
        
        return declaredVariables
    }
    
    private func parseDeclarationLine(declaration : String, index : Int) throws -> DeclaredVariable {
        let parts = declaration.splitBySpacesAndRemoveBlanks()
        
        guard let indexOfKeyword = parts.firstIndex(of : "dat") else {
            throw DeclarationErrors.keywordMissing(at: index)
        }
        
        guard indexOfKeyword == 0 else {
            throw DeclarationErrors.invalidOrder(at: index)
        }
        
        guard let identifier = parts[safe: 1] else {
            throw DeclarationErrors.invalidIdentifier(at: index)
        }
        
        guard (identifier.allSatisfy { $0.isLetter }) else {
            throw DeclarationErrors.invalidIdentifier(at: index)
        }
        
        let initialValue = Int(parts.last ?? "") ?? 0
        
        return DeclaredVariable(initialValue: initialValue, identifier: identifier)
    }
 }
