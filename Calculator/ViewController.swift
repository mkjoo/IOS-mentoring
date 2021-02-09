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
    
    @IBOutlet private weak var resultLabel: UILabel?
    @IBOutlet private weak var operatorButtonTableView: UITableView?
    @IBOutlet private var numbericButtonTableView: UITableView?
    
    
    let calculator: Calculator = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.calculator.delegate = self
        self.setupTableView()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction private func didClickNumbeicFunction(_ sender: UIButton){
        print(#function);
        
        guard let newInputNumber = sender.titleLabel?.text else { return }
        
        calculator.inputNewNumber(newInputNumber)
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
extension ViewController: CalculatorDelegate{

    func calculatorNoNumber() {
        print("There is no Number")
    }
    
    func calculatorNoOperator() {
        print("There is no Operator")
    }
    
    func calculatorNoResult() {
        print("There is no Result")
    }
    
    func calculatorDidChangeResult(_ result: Double) {
        self.resultLabel?.text = "\(result)"
    }
    
}

private extension ViewController {
    
    func setupTableView() {
        self.numbericButtonTableView?.delegate = self
        self.numbericButtonTableView?.dataSource = self
        self.numbericButtonTableView?.isScrollEnabled = false
        self.numbericButtonTableView?.separatorStyle = .none
        self.numbericButtonTableView?.register(UINib(nibName: "NumbericTableViewCell", bundle: nil),
                                               forCellReuseIdentifier: "NumbericTableViewCell")
        self.numbericButtonTableView?.register(UINib(nibName: "ResetTableViewCell", bundle: nil),
                                               forCellReuseIdentifier: "ResetTableViewCell")
        
        self.operatorButtonTableView?.delegate = self
        self.operatorButtonTableView?.dataSource = self
        self.operatorButtonTableView?.isScrollEnabled = false
        self.operatorButtonTableView?.separatorStyle = .none
        self.operatorButtonTableView?.register(UINib(nibName: "OperatorTableViewCell", bundle: nil),
                                               forCellReuseIdentifier: "OperatorTableViewCell")
        
    }
    
    
        
    
}



extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(tableView == numbericButtonTableView){
            return section == 0 ? 4 : 1
        }else{
            return section == 0 ? 5 : 1
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = tableView.frame.height
        
        return tableView.frame.height / 5.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        if(tableView == numbericButtonTableView){
            if indexPath.section == 0 {
                let numbericCell = tableView.dequeueReusableCell(withIdentifier: "NumbericTableViewCell", for: indexPath) as? NumbericTableViewCell
                numbericCell?.setupBasicNumber(indexPath)
                numbericCell?.delegate = self
                return numbericCell ?? cell
            } else {
                let resetAllCell = tableView.dequeueReusableCell(withIdentifier: "ResetTableViewCell", for: indexPath) as? ResetTableViewCell
                return resetAllCell ?? cell
            }
            
        }else{
           
            let operatorCell = tableView.dequeueReusableCell(withIdentifier: "OperatorTableViewCell", for: indexPath) as? OperatorTableViewCell
            operatorCell?.setupOperator(indexPath)
            operatorCell?.delegate = self
            return operatorCell ?? cell
           
            
        }
 
    }
    
}

extension ViewController: NumbericTableViewCellDelegate {
    
    func numbericTableViewCell(_ tableViewCell: NumbericTableViewCell, didSelect button: UIButton) {
        print("\(#function) buttonTitle: \(button.titleLabel?.text)")
        didClickNumbeicFunction(button)
    }
}

extension ViewController: ResetTableViewCellDelegate{
    func resetTableViewCell(_ tableViewCell: ResetTableViewCell, didSelect button: UIButton) {
        print("\(#function) buttonTitle: \(button.titleLabel?.text)")
        didClickResetFunction(button)
        
    }
}

extension ViewController: OperatorTableViewCellDelegate{
    func operatorTableViewCell(_ tableViewCell: OperatorTableViewCell, didSelect button: UIButton) {
        print("\(#function) buttonTitle: \(button.titleLabel?.text)")
        if(button.titleLabel?.text == "="){
            didClickResultFunction(button)
        }else{
            didClickOperatorFunction(button)
        }
        
    }
}


