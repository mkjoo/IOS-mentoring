//
//  ViewController.swift
//  Calculator
//
//  Created by 주민경 on 2021/01/12.
//

import UIKit

class ViewController: UIViewController {

    
    var inputFirstNumberString:String = ""
    var inputSecondNumberString:String = ""
    var operatorString:String = ""
    var resultText:String = ""
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
    
    @IBAction private func didClickNumbeicFunction(_ sender: UIButton){
        print(#function);
        
        guard
            let newInputNumber = sender.titleLabel?.text
        else { return }
        
        self.operatingStringLabel?.text! += calculator.inputNewNumber(newInputNumber)
    }
    
    @IBAction private func didClickOperatorFunction(_ sender: UIButton){
        print(#function)
        guard
            let inputOperatorString = sender.titleLabel?.text
        else { return }
        
        self.operatingStringLabel?.text! += calculator.insertOperatorString(inputOperatorString)
    }
    
    @IBAction private func didClickResultFunction(_ sender: UIButton){
        
        guard
            let resultString: String? = calculator.calculateResult()
        else { return }
        
        self.resultLabel?.text = resultString
        self.operatingStringLabel?.text = resultString
    }
    
    @IBAction private func didClickResetFunction(_ sender: UIButton){
        calculator.resetAllString()
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
        let width = buttonCollectionView.frame.width / 4.0
        let height = buttonCollectionView.frame.height / 5.0
        
        if indexPath.row == 12 {
            return CGSize(width: width*2, height: height)
        } else if indexPath.row == 15 {
            return CGSize(width: width*3, height: height)
        }
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return .zero // 가로 spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return .zero // 세로 spacing
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

private extension ViewController {
    func decideAction(_ sender: UIButton){
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



