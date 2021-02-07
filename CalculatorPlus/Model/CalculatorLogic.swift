//
//  CalculatorLogic.swift
//  CalculatorPlus
//
//  Created by Manu Safarov on 02.02.2021.
//

import Foundation

struct CalculatorLogic {
    
    private var number: Double?
    
    private var intermediateCalculation: (n1: Double, calcMethod: String)?
    
    mutating func setNumber(_ number: Double) {
        self.number = number
    }
    
    mutating func calculate(symbol: String) -> Double? {
        
        if let n = number {
            switch symbol {
            case "+/-":
                return n * -1
            case "C":
                intermediateCalculation = nil
                return 0
            case "%":
                return n * 0.01
            case "=":
                let result = performTwoNumberCalculation(n2: n)
                intermediateCalculation = nil
                return result
            default:
                var result = n
                
                if let previousCalcResult = performTwoNumberCalculation(n2: n) {
                    result = previousCalcResult
                }
                intermediateCalculation = (n1: result, calcMethod: symbol)
                return result
            }
        }
        
        return nil
    }
    
    private func performTwoNumberCalculation(n2: Double) -> Double? {
        
        if let n1 = intermediateCalculation?.n1,
           let operation = intermediateCalculation?.calcMethod {
            
            switch operation {
            case "+":
                return n1 + n2
            case "-":
                return n1 - n2
            case "*":
                return n1 * n2
            case "/":
                return n1 / n2
            default:
                fatalError("The operation passed in does not match any of the cases.")
            }
        }
        
        return nil
    }
}
