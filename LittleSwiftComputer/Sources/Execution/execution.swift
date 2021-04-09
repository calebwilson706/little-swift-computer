//
//  execution.swift
//  LittleSwiftComputer
//
//  Created by Caleb Wilson on 03/04/2021.
//

import Foundation
import SwiftUI

extension ExecutionController {
    func execute(assembledCode : PreparedAndAssembledCode, speedSelection : ExecutionSpeeds) {
        resetProgram()
        self.assembledCodeSource = assembledCode
        
        fillRegistersWithInitialValues(variables: assembledCode.initializedVariables)
        startTimer(timeInterval: speedSelection.rawValue)
    }
    
    
    @objc func runLineOfAssembledCode() {
        let assembledCode = self.assembledCodeSource!
        let codeLines = assembledCode.mainCodeBlock.lines
        
        guard let currentInstruction = codeLines[safe : indexOfCurrentInstruction] else {
            timer.invalidate()
            self.requiresInput = false
            self.isPaused = false
            return
        }
        
        do {
            switch currentInstruction.theOperator {
            case .add:
                accumulator += try getValueFromRegister(identifier: currentInstruction.theOperand)
            case .subtract:
                accumulator -= try getValueFromRegister(identifier: currentInstruction.theOperand)
            case .store:
                registers[currentInstruction.theOperand!] = replaceRegisterWithNewValue(
                    name: currentInstruction.theOperand!,
                    newValue: accumulator
                )
            case .load:
                accumulator = try getValueFromRegister(identifier: currentInstruction.theOperand)
            case .output:
                try output(operand: currentInstruction.theOperand)
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
                
                withAnimation {
                    self.executionError = ExecutionErrors.requiresInput
                }
                
                timer.invalidate()
            }
            
            if currentInstruction.theOperator.requiresIncrementation() {
                indexOfCurrentInstruction += 1
            }
        } catch {
            withAnimation {
                self.executionError = error
            }
            timer.invalidate()
            return
        }
    }
    
    func resume(speedSelection : ExecutionSpeeds) {
        self.isPaused = false
        startTimer(timeInterval: speedSelection.rawValue)
    }
    
    func pause() {
        self.isPaused = true
        timer.invalidate()
    }
    
    func resumeAfterInput(inputNumber : Int, speedSelection : ExecutionSpeeds) {
        
        if let registerName = assembledCodeSource?.mainCodeBlock.lines[indexOfCurrentInstruction].theOperand {
            self.registers[registerName] = replaceRegisterWithNewValue(name: registerName, newValue: inputNumber)
        } else {
            self.accumulator = inputNumber
        }
        
        self.indexOfCurrentInstruction += 1
        self.requiresInput = false
        
        withAnimation {
            self.executionError = nil
        }
        
        startTimer(timeInterval: speedSelection.rawValue)
    }
    
    func resetProgram() {
        self.accumulator = 0
        self.indexOfCurrentInstruction = 0
        self.registers.removeAll()
        self.requiresInput = false
        self.isPaused = false
        
        withAnimation {
            self.executionError = nil
        }
        
        self.outputs.removeAll()
        timer.invalidate()
    }
    
    private func output(operand : String?) throws {
        do {
            let numberToAdd = try getValueFromRegister(identifier: operand)
            self.outputs.append(numberToAdd)
        } catch {
            guard operand == nil else {
                throw error
            }
            self.outputs.append(accumulator)
        }
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
    
    private func startTimer(timeInterval: Double) {
        timer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(runLineOfAssembledCode), userInfo: nil, repeats: true)
    }
    
    private func replaceRegisterWithNewValue(name : String, newValue : Int) -> RegisterData {
        return RegisterData(
            indexForDisplay: registers[name]?.indexForDisplay ?? registers.count,
            value: newValue
        )
    }
}
