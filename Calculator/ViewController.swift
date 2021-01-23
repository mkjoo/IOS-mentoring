//
//  ViewController.swift
//  Calculator
//
//  Created by 주민경 on 2021/01/12.
//

import UIKit

class ViewController: UIViewController {

    
    var inputFirstNumberString:String = "";
    var inputSecondNumberString:String = "";
    var operatorString:String = "";
    var resultText:String = "";
    
    let calculator: calculator = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction private func didClickNumbeicFunction(_ sender: UIButton){
        print(#function);
        
        guard let newInputNumber = sender.titleLabel?.text else { return }
        
        calculator.insertNumberString(newInputNumber)
    }
    
    @IBAction private func didClickOperatorFunction(_ sender: UIButton){
        print(#function)
        guard let inputOperatorString = sender.titleLabel?.text else { return }
        
        calculator.insertOperatorString(inputOperatorString)
    }
    
    @IBAction private func didClickResultFunction(_ sender: UIButton){
        
        calculator.calculateResult()
    }
    
    @IBAction private func didClickResetFunction(_ sender: UIButton){
        
        calculator.resetAllString()
    }

}

