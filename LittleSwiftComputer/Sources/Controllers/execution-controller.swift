//
//  executor.swift
//  LittleSwiftComputer
//
//  Created by Caleb Wilson on 31/03/2021.
//

import Foundation

class ExecutionController : ObservableObject {
    
    @Published var accumulator : Int = 0
    @Published var indexOfCurrentInstruction : Int = 0
    @Published var registers = [String : RegisterData]()
    @Published var executionError : Error?
    @Published var outputs = [Int]()
    @Published var requiresInput = false
    @Published var isPaused = false
    
    var assembledCodeSource : PreparedAndAssembledCode? = nil
    var timer = Timer()
    var isRunning : Bool {
        timer.isValid
    }
    var canRunProgram : Bool {
        !isRunning && !requiresInput
    }
    var canStopProgram : Bool {
        isRunning || requiresInput || isPaused
    }
    var canPauseProgram : Bool {
        isRunning
    }
    var registersForDisplaying : [RegisterData] {
        registers.values.sorted { $0.indexForDisplay < $1.indexForDisplay }
    }
}
