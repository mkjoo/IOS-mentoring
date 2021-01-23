//
//  calculator.swift
//  Calculator
//
//  Created by 주민경 on 2021/01/23.
//

import Foundation

class calculator{
    
    var inputFirstNumberString:String = "";
    var inputSecondNumberString:String = "";
    var operatorString:String = "";
    var resultText:String = "";
    
    func insertNumberString(_ inputNumberString: String){
        if self.operatorString.isEmpty {
            self.inputFirstNumberString += inputNumberString
            print("inputNumber1 ::: \(self.inputFirstNumberString)")
        } else {
            self.inputSecondNumberString += inputNumberString
            print("inputNumber2 ::: \(self.inputSecondNumberString)")
        }
    }
        
    func insertOperatorString(_ newOperatorString: String){
        
        self.operatorString = newOperatorString
        
    }
        
    func calculateResult(){
        
        guard
            !self.operatorString.isEmpty,
            let firstCalculateNumber = Double(inputFirstNumberString),
            let secondCalculateNumber = Double(inputSecondNumberString)
        else {
            print("no operator!!! or number parsing error")
            return
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
            
    }
    
    func resetAllString(){
        self.inputFirstNumberString = "";
        self.inputSecondNumberString = "";
        self.operatorString = "";
    }

    
    
}
