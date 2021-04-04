//
//  execution.swift
//  LittleSwiftComputer
//
//  Created by Caleb Wilson on 03/04/2021.
//

import Foundation

extension ExecutionController {
    func execute(_ assembledCode : PreparedAndAssembledCode) {
        resetProgram()
        self.assembledCodeSource = assembledCode
        
        fillRegistersWithInitialValues(variables: assembledCode.initializedVariables)
        startTimer()
    }
    
    
    @objc func runLineOfAssembledCode() {
        let assembledCode = self.assembledCodeSource!
        let codeLines = assembledCode.mainCodeBlock.lines
        
        guard let currentInstruction = codeLines[safe : indexOfCurrentInstruction] else {
            timer.invalidate()
            return
        }
        
        do {
            switch currentInstruction.theOperator {
            case .add:
                accumulator += try getValueFromRegister(identifier: currentInstruction.theOperand)
            case .subtract:
                accumulator -= try getValueFromRegister(identifier: currentInstruction.theOperand)
            case .store:
                registers[currentInstruction.theOperand!] = RegisterData(
                    indexForDisplay: registers[currentInstruction.theOperand!]?.indexForDisplay ?? registers.count,
                    value: accumulator
                )
            case .load:
                accumulator = try getValueFromRegister(identifier: currentInstruction.theOperand)
            case .output:
                self.outputs.append(accumulator)
            case .halt:
                indexOfCurrentInstruction = codeLines.count
                return
            case .branch_always:
                self.indexOfCurrentInstruction = try getNextIndexFromBranch(condition: true, placeholder: currentInstruction.theOperand, placeholderDictionary: assembledCode.mainCodeBlock.placeholdersForBranches)
            case .branch_if_zero:
                self.indexOfCurrentInstruction = try getNextIndexFromBranch(condition: (accumulator == 0), placeholder: currentInstruction.theOperand, placeholderDictionary: assembledCode.mainCodeBlock.placeholdersForBranches)
            case .branch_if_positive:
                self.indexOfCurrentInstruction = try getNextIndexFromBranch(condition: (accumulator > 0), placeholder: currentInstruction.theOperand, placeholderDictionary: assembledCode.mainCodeBlock.placeholdersForBranches)
            case .input:
                self.requiresInput = true
                timer.invalidate()
            }
            
            if currentInstruction.theOperator.requiresIncrementation() {
                indexOfCurrentInstruction += 1
            }
        } catch {
            self.executionError = error.localizedDescription
            timer.invalidate()
            return
        }
    }
    
    
    func resumeAfterInput(inputNumber : Int) {
        self.accumulator = inputNumber
        self.indexOfCurrentInstruction += 1
        self.requiresInput = false
        
        startTimer()
    }
    
    func resetProgram() {
        self.accumulator = 0
        self.indexOfCurrentInstruction = 0
        self.registers.removeAll()
        self.executionError = nil
        self.outputs.removeAll()
        timer.invalidate()
    }
    
    private func fillRegistersWithInitialValues(variables : [DeclaredVariable]) {
        Array(variables.enumerated()).forEach { index, element in
            registers[element.identifier] = RegisterData(indexForDisplay: index, value: element.initialValue)
        }
    }
    
    private func getValueFromRegister(identifier : String?) throws -> Int {
        guard let value = registers[identifier ?? ""]?.value else {
            throw ExecutionErrors.undeclaredVariableAccess(at: indexOfCurrentInstruction)
        }
        return value
    }
    
    private func getIndexOfPlaceholder(placeholder : String?, placeholderDictionary : [String : Int]) throws -> Int {
        guard let indexOfPlaceholder = placeholderDictionary[placeholder ?? ""] else  {
            throw ExecutionErrors.missingPlaceholder(at: indexOfCurrentInstruction)
        }
        return indexOfPlaceholder
    }
    
    private func getNextIndexFromBranch(condition : Bool, placeholder : String?, placeholderDictionary : [String : Int]) throws -> Int {
        do {
            return condition ? try getIndexOfPlaceholder(placeholder: placeholder, placeholderDictionary: placeholderDictionary) : self.indexOfCurrentInstruction + 1
        } catch {
            throw error
        }
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0, target: self, selector: #selector(runLineOfAssembledCode), userInfo: nil, repeats: true)
    }
}
