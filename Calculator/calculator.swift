//
//  calculator.swift
//  Calculator
//
//  Created by 주민경 on 2021/01/23.
//

import Foundation
import UIKit


protocol CalculatorDelegate: class {
    func calculatorNoNumber()
    func calculatorNoOperator()
    func calculatorNoResult()
    func calculatorDidChangeResult(_ result: Double)
}

class Calculator{
    
    var inputFirstNumberString: String = ""
    var inputSecondNumberString: String = ""
    var operatorString: String = ""
    var resultText: String = ""
    var didClickResultButton: Bool = false
    
    weak var delegate: CalculatorDelegate?
    
    func inputNewNumber(_ numberString: String?) -> String {
        guard let inputNumberString = numberString else {
            self.delegate?.calculatorNoNumber()
            return ""
        }

        if self.operatorString.isEmpty && !self.didClickResultButton {
            self.inputFirstNumberString += inputNumberString
            print("inputNumber1 ::: \(self.inputFirstNumberString)")
            return inputNumberString
            
        } else if !self.operatorString.isEmpty {
            self.inputSecondNumberString += inputNumberString
            print("inputNumber2 ::: \(self.inputSecondNumberString)")
            return inputNumberString
            
        } else {
            return ""
        }
    }
        
    func insertOperatorString(_ newOperatorString: String) -> String {
        if self.operatorString.isEmpty{
            self.operatorString = newOperatorString
            return newOperatorString
            
        }else{
            self.calculateResult()
            return self.insertOperatorString(newOperatorString)
        }
        
    }
        
    func calculateResult() -> String {
        guard !self.operatorString.isEmpty,
              let firstCalculateNumber = Double(self.inputFirstNumberString),
              let secondCalculateNumber = Double(self.inputSecondNumberString)
        else {
            print("no operator!!! or number parsing error")
            return ""
        }

        if self.operatorString == "+" {
            self.resultText = String(firstCalculateNumber + secondCalculateNumber)
            
        } else if operatorString == "-" {
            self.resultText = String(firstCalculateNumber - secondCalculateNumber)
            
        } else if operatorString == "x" {
            self.resultText = String(firstCalculateNumber * secondCalculateNumber)
            
        } else if operatorString == "/" {
            self.resultText = String(firstCalculateNumber / secondCalculateNumber)
        }
            
        self.inputFirstNumberString = resultText
        self.inputSecondNumberString = ""
        self.operatorString = ""
        
        print("inputNumber1 :: result :: \(self.inputFirstNumberString)")
        self.didClickResultButton = true
        
        return self.resultText
            
    }
    
    func resetAllString(){
        self.inputFirstNumberString = ""
        self.inputSecondNumberString = ""
        self.operatorString = ""
        self.didClickResultButton = false
    }
}

private extension Calculator{
    func didChageResult(_ resultString: String) {
        guard let newResult = Double(resultString) else { return }
        
        self.delegate?.calculatorDidChangeResult(newResult)
    }
}

