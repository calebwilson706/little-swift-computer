//
//  dynamicButtonLabelsController.swift
//  LittleSwiftComputer
//
//  Created by Caleb Wilson on 07/04/2021.
//

import Foundation

class DynamicButtonLabelsController : ObservableObject {
    let runButtonLabel = DynamicButtonLabel(completedString: "Execute Code")
    let cancelButtonLabel = DynamicButtonLabel(completedString: "Stop Execution")
    let resumeButtonLabel = DynamicButtonLabel(completedString: "Resume Execution")
    let pauseButtonLabel = DynamicButtonLabel(completedString: "Pause Execution")
}
