//
//  ViewController.swift
//  CalculatorPlus
//
//  Created by Manu Safarov on 29.01.2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var displayLabel: UILabel!
    
    private var isFinishedTypingNumber: Bool = true
    private var calculator = CalculatorLogic()
    
    private var displayValue: Double {
        get {
            let text   = displayLabel.text ?? ""
            let double = Double(text) ?? 0
            return double
        }
        set {
            let isInt = floor(newValue) == newValue
            
            if isInt {
                displayLabel.text = String(format: "%.0f", newValue)
            } else {
                displayLabel.text = newValue.withCommas()
            }
        }
        
    }
    
    @IBAction func calcButtonPressed(_ sender: UIButton) {
        
        isFinishedTypingNumber = true
        
        calculator.setNumber(displayValue)
        
        if let calcMethod = sender.currentTitle {
            
            if let result = calculator.calculate(symbol: calcMethod) {
                displayValue = result
            }
        }
    }
    
    @IBAction func numButtonPressed(_ sender: UIButton) {
        
        guard let numValue = sender.currentTitle else { return }
        
        if isFinishedTypingNumber {
            if numValue == "0" {
                return
            }
            
            isFinishedTypingNumber = false
            if numValue == "." {
                displayLabel.text! += numValue
            } else {
                displayLabel.text = numValue
            }
        } else {
            if numValue == "." {
                let isInt = !displayLabel.text!.contains(".")
                if !isInt {
                    return
                }
            }
            displayLabel.text! += numValue
        }
    }
}

    //MARK: - Correction of fractional number residuals using NumberFormatter.

extension Double {
    func withCommas() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        numberFormatter.maximumFractionDigits = 8  // default is 3 decimals
        return numberFormatter.string(from: NSNumber(value: self)) ?? ""
    }
}
