//
//  ViewController.swift
//  Calculator
//
//  Created by 주민경 on 2021/01/12.
//

import UIKit

class ViewController: UIViewController {

    
    var inputFirstNumberString: String = ""
    var inputSecondNumberString: String = ""
    var operatorString: String = ""
    var resultText: String = ""
    var operatingString: String="" 
    
    @IBOutlet private weak var resultLabel: UILabel?
    @IBOutlet private weak var operatingStringLabel: UILabel?
    @IBOutlet private weak var buttonContainerView: UIView?
    private var buttonCollectionView: UICollectionView = .init(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    let calculator: Calculator = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupCollectionView()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction private func didClickNumbeicFunction(_ sender: UIButton) {
        print(#function)
        
        guard let newInputNumber = sender.titleLabel?.text,
              let operatingStringLabelText = self.operatingStringLabel?.text else { return }
        
        self.operatingStringLabel?.text = operatingStringLabelText + self.calculator.inputNewNumber(newInputNumber)
    }
    
    @IBAction private func didClickOperatorFunction(_ sender: UIButton) {
        print(#function)
        guard let inputOperatorString = sender.titleLabel?.text,
              let operatingStringText = self.operatingStringLabel?.text else { return }
        
        self.operatingStringLabel?.text = operatingStringText + self.calculator.insertOperatorString(inputOperatorString)
    }
    
    @IBAction private func didClickResultFunction(_ sender: UIButton) {
        
        let resultString = self.calculator.calculateResult()
        
        self.resultLabel?.text = resultString
        self.operatingStringLabel?.text = resultString
    }
    
    @IBAction private func didClickResetFunction(_ sender: UIButton){
        self.calculator.resetAllString()
        self.resultLabel?.text = ""
        self.operatingStringLabel?.text = ""
    }

}


private extension ViewController {
    
    func setupCollectionView() {
        self.buttonContainerView?.addSubview(self.buttonCollectionView)
        
        self.buttonCollectionView.backgroundColor = UIColor(red: CGFloat(49 / 255.0), green: CGFloat(49 / 255.0), blue:CGFloat(40 / 255.0), alpha: CGFloat(0.9))
        self.buttonCollectionView.register(UINib(nibName: "ButtonCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ButtonCollectionViewCell")
        self.buttonCollectionView.delegate = self
        self.buttonCollectionView.dataSource = self
        self.setupCollectionViewAutoLayout()

    }
    
    func setupCollectionViewAutoLayout(){
        guard let buttonContainerView = self.buttonContainerView else { return }
        
        self.buttonCollectionView.translatesAutoresizingMaskIntoConstraints = false
        self.buttonCollectionView.topAnchor.constraint(equalTo: buttonContainerView.topAnchor, constant: .zero).isActive = true
        self.buttonCollectionView.leadingAnchor.constraint(equalTo: buttonContainerView.leadingAnchor , constant: .zero).isActive = true
        self.buttonCollectionView.trailingAnchor.constraint(equalTo: buttonContainerView.trailingAnchor, constant: .zero).isActive = true
        self.buttonCollectionView.bottomAnchor.constraint(equalTo: buttonContainerView.bottomAnchor, constant: .zero).isActive = true
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.sizeForItemAt(collectionView, indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
    
}

extension ViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 17 // 9 + 5 + 2 + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = buttonCollectionView.dequeueReusableCell(withReuseIdentifier: "ButtonCollectionViewCell", for: indexPath)
        
        if let buttonCell = cell as? ButtonCollectionViewCell{
            buttonCell.update(indexPath)
            buttonCell.delegate = self
        }
        return cell
    }
    
    
}

extension ViewController: ButtonCollectionViewCellDelegate {
    func buttonCollectionViewCell(_ cell: ButtonCollectionViewCell, didSelect sender: UIButton) {
        self.decideAction(sender)
    }
}

extension ViewController {
    
    func sizeForItemAt(_ collectionView: UICollectionView, indexPath: IndexPath) -> CGSize{
        let width = self.buttonCollectionView.frame.width / 4.0
        let height = self.buttonCollectionView.frame.height / 5.0
        
        let isZeroButton = indexPath.row == 12
        let isResetButton = indexPath.row == 15
        
        if isZeroButton {
            return CGSize(width: width*2, height: height)
            
        } else if isResetButton {
            return CGSize(width: width*3, height: height)
            
        } else {
            return CGSize(width: width, height: height)
        }
    }
}

private extension ViewController {
    func decideAction(_ sender: UIButton) {
        guard let titleString = sender.titleLabel?.text else { return }
        
        switch titleString {
        
        case "+","-","x","/":
            self.didClickOperatorFunction(sender)
            
        case "AC":
            self.didClickResetFunction(sender)
            
        case "=":
            self.didClickResultFunction(sender)
            
        default:
            self.didClickNumbeicFunction(sender)
        }
    }
}



