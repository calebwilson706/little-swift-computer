//
//  the-assembly-challenges.swift
//  LittleSwiftComputer
//
//  Created by Caleb Wilson on 12/04/2021.
//

import Foundation

let assemblyCodeInitialChallenges = [
    
    ChallengeContainer(
        challengeTitle: "Multiples of A Positive",
        description: "Write some assembly code to output the multiples of a positive input number up until another positive input number.",
        exampleSolutionFileName: "multiples-solution"
    ),
    
    ChallengeContainer(
        challengeTitle: "Multiply Two Positive Numbers",
        description: "Write some assembly code to multiply two positive numbers together.",
        exampleSolutionFileName: "multiply-two-numbers-solution",
        tip: "3 + 3 + 3 + 3 is the same as 3x4."
    ),
    
    ChallengeContainer(
        challengeTitle: "Divide A Positive Number",
        description: "Write some assembly code divide a positive input number input by another positive input number.",
        exampleSolutionFileName: "divide-two-numbers-solution",
        tip: "Count how many times you can subtract the divider from the first number."
    ),
    
    ChallengeContainer(
        challengeTitle: "Square A Number",
        description: "Write some assembly code to square a positive number which is input.",
        exampleSolutionFileName: "square-number-solution"
    ),
    
    ChallengeContainer(
        challengeTitle: "Fibonacci",
        description: "Write some assembly code to output the first 10 numbers in the Fibonacci sequence. \nFeel free to do some more work and allow input to determine the amount of elements output.",
        exampleSolutionFileName: "fibonacci-solution"
    ),
    
    ChallengeContainer(
        challengeTitle: "Negative Number Fun Part 1 (Multiply)",
        description: "Write some assembly code to multiply two input numbers, however allow for negative input as well as positive!",
        exampleSolutionFileName: "negatives-multiplication-solution",
        tip: "The way I would do this is by manipulating the input and changing the final answer if necessary. \nDon't forget that 'positive X negative = negative' and 'negative X negative = positive'."
    ),
    
    ChallengeContainer(
        challengeTitle: "Negative Number Fun Part 2 (Divide)",
        description: "Write some assembly code to divide two input numbers, however allow for negative input as well as positive!",
        exampleSolutionFileName: "negatives-division-solution",
        tip: "Similar to the previous challenge you need to manipulate the input to prevent an infinite loop!"
    ),
    
    ChallengeContainer(
        challengeTitle: "Optimised Multiplication",
        description: "Come up with a way to optimise your assembly code for multiplication, my example solution is just for positives but you could try optimise the negative multiplication code also!",
        exampleSolutionFileName: "optimised-multiplication-solution",
        tip: "3 + 3 + 3 + 3 + 3 is the same as 5 + 5 + 5, Which one would take longer?"
    )

]


