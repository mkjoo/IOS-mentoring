//
//  ViewController.swift
//  Calculator
//
//  Created by 주민경 on 2021/01/12.
//

import UIKit

class ViewController: UIViewController {

    
    var inputNumber1:String = "";
    var inputNumber2:String = "";
    var operatorChar:String = "";
    var resultText:String = "";
    
    @IBAction private func didClickNumbeicFunction(_ sender:UIButton){
        print(#function);
        
        if(operatorChar.isEmpty || operatorChar == "" ){
            inputNumber1 += sender.titleLabel!.text!
            print("inputNumber1 ::: \(inputNumber1)")
        }else{
            inputNumber2 += sender.titleLabel!.text!
            print("inputNumber2 ::: \(inputNumber2)")
        }
        
    }
    
    @IBAction private func didClickOperatorFunction(_ sender:UIButton){
        print(#function)
        operatorChar = sender.titleLabel!.text!
        print(operatorChar);
    }
    
    @IBAction private func didClickResultFunction(_ sender:UIButton){
        if (operatorChar.isEmpty || operatorChar == ""){
            print("-")
        }else{
            let num1:Float32 = Float32(inputNumber1) ?? 0
            let num2:Float32 = Float32(inputNumber2) ?? 0
            
            if (operatorChar == "+"){
                resultText = String(num1 + num2);
            }else if (operatorChar == "-"){
                resultText = String(num1 - num2);
            }else if (operatorChar == "x"){
                resultText = String(num1 * num2);
            }else if (operatorChar == "/"){
                resultText = String(num1 / num2);
            }
            print("------ restult ------")
            print("\(num1) \(operatorChar) \(num2) = \(resultText)")
            print("---------------------")
            inputNumber1 = resultText;
            inputNumber2 = "";
            print("inputNumber1 :: result :: \(inputNumber1)")
            
        }
    }
    
    @IBAction private func didClickResetFunction(_ sender:UIButton){
        inputNumber1 = "";
        inputNumber2 = "";
        operatorChar = "";
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

