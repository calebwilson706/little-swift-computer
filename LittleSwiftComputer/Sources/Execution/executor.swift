//
//  executor.swift
//  LittleSwiftComputer
//
//  Created by Caleb Wilson on 31/03/2021.
//

import Foundation

class Executor : ObservableObject {
    
    @Published var accumulator : Int = 0
    @Published var indexOfCurrentInstruction : Int = 0
    @Published var registers = [String : RegisterData]()
    
    func execute(_ assembledCode : PreparedAndAssembledCode) {
        self.accumulator = 0
        self.indexOfCurrentInstruction = 0
        fillRegistersWithInitialValues(variables: assembledCode.initializedVariables)
        runAssembledCode(assembledCode: assembledCode)
    }
    
    func runAssembledCode(assembledCode : PreparedAndAssembledCode) {
        let codeLines = assembledCode.mainCodeBlock.lines
        
        while indexOfCurrentInstruction < codeLines.count {
            let currentInstruction = codeLines[indexOfCurrentInstruction]
            
            switch currentInstruction.theOperator {
            case .add:
                accumulator += getValueFromRegister(identifier: currentInstruction.theOperand)
            case .subtract:
                accumulator -= getValueFromRegister(identifier: currentInstruction.theOperand)
            case .store:
                registers[currentInstruction.theOperand!] = RegisterData(
                    indexForDisplay: registers[currentInstruction.theOperand!]?.indexForDisplay ?? registers.count,
                    value: accumulator
                )
            case .load:
                accumulator = getValueFromRegister(identifier: currentInstruction.theOperand)
            case .output:
                print(accumulator)
                //do something else here
            case .halt:
                return
            case .branch_always:
                self.indexOfCurrentInstruction = getNextIndexFromBranch(condition: true, placeholder: currentInstruction.theOperand, placeholderDictionary: assembledCode.mainCodeBlock.placeholdersForBranches)
            case .branch_if_zero:
                self.indexOfCurrentInstruction = getNextIndexFromBranch(condition: (accumulator == 0), placeholder: currentInstruction.theOperand, placeholderDictionary: assembledCode.mainCodeBlock.placeholdersForBranches)
            case .branch_if_positive:
                self.indexOfCurrentInstruction = getNextIndexFromBranch(condition: (accumulator > 0), placeholder: currentInstruction.theOperand, placeholderDictionary: assembledCode.mainCodeBlock.placeholdersForBranches)
            }
            
            if currentInstruction.theOperator.requiresIncrementation() {
                indexOfCurrentInstruction += 1
            }
        }
        
    }
    
    private func fillRegistersWithInitialValues(variables : [DeclaredVariable]) {
        Array(variables.enumerated()).forEach { index, element in
            registers[element.identifier] = RegisterData(indexForDisplay: index, value: element.initialValue)
        }
    }
    
    private func getValueFromRegister(identifier : String?) -> Int {
        registers[identifier ?? ""]?.value ?? 0
    }
    
    private func getIndexOfPlaceholder(placeholder : String?, placeholderDictionary : [String : Int]) -> Int {
        guard let stringToFind = placeholder else {
            return self.indexOfCurrentInstruction + 1
        }
        guard let indexOfPlaceholder = placeholderDictionary[stringToFind] else  {
            return self.indexOfCurrentInstruction + 1
        }
        return indexOfPlaceholder
    }
    
    private func getNextIndexFromBranch(condition : Bool, placeholder : String?, placeholderDictionary : [String : Int]) -> Int {
        condition ? getIndexOfPlaceholder(placeholder: placeholder, placeholderDictionary: placeholderDictionary) : self.indexOfCurrentInstruction + 1
    }
}
