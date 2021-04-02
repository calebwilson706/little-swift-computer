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
    @Published var executionError : String? = nil
    
    var assembledCodeSource : PreparedAndAssembledCode? = nil
    var timer = Timer()
    
}
