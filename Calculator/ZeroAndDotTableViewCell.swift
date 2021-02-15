//
//  ZeroAndDotTableViewCell.swift
//  Calculator
//
//  Created by 주민경 on 2021/02/15.
//

import UIKit



class ZeroAndDotTableViewCell: UITableViewCell {

    @IBOutlet private weak var leftButton: UIButton?
    @IBOutlet private weak var rightButton: UIButton?
    
    let numbericTableViewCell: NumbericTableViewCell = .init()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.setupLeftButton()
        self.setupRightButton()
    }
    
    func setupBasicNumber(_ indexPath: IndexPath) {
        
        self.leftButton?.setTitle("0", for: .normal)
        self.rightButton?.setTitle(".", for: .normal)

    }
    
}

private extension ZeroAndDotTableViewCell {
    
    func setupLeftButton() {
        self.leftButton?.addTarget(self, action: #selector(numbericTableViewCell.numbericButtonAction(_:)), for: .touchUpInside)
    }
    
    func setupRightButton() {
        self.rightButton?.addTarget(self, action: #selector(numbericTableViewCell.numbericButtonAction(_:)), for: .touchUpInside)
    }
    
}

