//
//  register-data.swift
//  LittleSwiftComputer
//
//  Created by Caleb Wilson on 01/04/2021.
//

import Foundation

struct RegisterData {
    let indexForDisplay : Int
    var value : Int
    
    mutating func setValue(to value : Int){
        self.value = value
    }
}
