//
//  calculator.swift
//  Calculator
//
//  Created by 주민경 on 2021/01/23.
//

import Foundation


protocol CalculatorDelegate: class {
    func calculatorNoNumber()
    func calculatorNoOperator()
    func calculatorNoResult()
    func calculatorDidChangeResult(_ result: Double)
}

class Calculator{
    
    var inputFirstNumberString:String = "";
    var inputSecondNumberString:String = "";
    var operatorString:String = "";
    var resultText:String = "";
    
    weak var delegate: CalculatorDelegate?
    
    func inputNewNumber(_ numberString: String?) -> String {
        guard let inputNumberString = numberString else {
            self.delegate?.calculatorNoNumber()
            return ""
        }

        if self.operatorString.isEmpty {
            self.inputFirstNumberString += inputNumberString
            
            print("inputNumber1 ::: \(self.inputFirstNumberString)")
        } else {
            self.inputSecondNumberString += inputNumberString
            print("inputNumber2 ::: \(self.inputSecondNumberString)")
        }
        return inputNumberString
    
    
    }
        
    func insertOperatorString(_ newOperatorString: String) -> String{
        
        self.operatorString = newOperatorString
        
        return newOperatorString
        
    }
        
    func calculateResult() -> String{
        
        guard
            !self.operatorString.isEmpty,
            let firstCalculateNumber = Double(inputFirstNumberString),
            let secondCalculateNumber = Double(inputSecondNumberString)
        else {
            print("no operator!!! or number parsing error")
            return ""
        }

        if (operatorString == "+"){
            self.resultText = String(firstCalculateNumber + secondCalculateNumber)
        }else if (operatorString == "-"){
            self.resultText = String(firstCalculateNumber - secondCalculateNumber)
        }else if (operatorString == "x"){
            self.resultText = String(firstCalculateNumber * secondCalculateNumber)
        }else if (operatorString == "/"){
            self.resultText = String(firstCalculateNumber / secondCalculateNumber)
        }
            
        self.inputFirstNumberString = resultText
        self.inputSecondNumberString = "";
        
        print("inputNumber1 :: result :: \(inputFirstNumberString)")
        
        return resultText
            
    }
    
    func resetAllString(){
        self.inputFirstNumberString = "";
        self.inputSecondNumberString = "";
        self.operatorString = "";
    }

    
    
}

private extension Calculator{
    func didChageResult(_ resultString: String){
        guard let newResult = Double(resultString) else { return }
        
        self.delegate?.calculatorDidChangeResult(newResult)
        
    }
}
