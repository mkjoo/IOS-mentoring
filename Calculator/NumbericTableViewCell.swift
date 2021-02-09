//
//  NumbericTableViewCell.swift
//  Calculator
//
//  Created by 주민경 on 2021/02/09.
//

import UIKit

protocol NumbericTableViewCellDelegate: class {
    func numbericTableViewCell(_ tableViewCell: NumbericTableViewCell, didSelect button: UIButton)
}

class NumbericTableViewCell: UITableViewCell {

    @IBOutlet private weak var leftButton: UIButton?
    @IBOutlet private weak var centerButton: UIButton?
    @IBOutlet private weak var rightButton: UIButton?
    
    weak var delegate: NumbericTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.setupLeftButton()
        self.setupCentetButton()
        self.setupRightButton()
    }
    
    func setupBasicNumber(_ indexPath: IndexPath) {
        var baseNumber = 0
        if indexPath.row == 0 {
            baseNumber = 7
        } else if indexPath.row == 1 {
            baseNumber = 4
            
        } else if indexPath.row == 2 {
            baseNumber = 1
        } else {
            baseNumber = 0
        }
        self.leftButton?.setTitle("\(baseNumber)", for: .normal)
        if(baseNumber != 0){
            self.centerButton?.setTitle("\(baseNumber + 1)", for: .normal)
            self.rightButton?.setTitle("\(baseNumber + 2)", for: .normal)
        }else{
            self.centerButton?.setTitle(".", for: .normal)
            self.rightButton?.setTitle("?", for: .normal)
        }

    }
}

private extension NumbericTableViewCell {
    
    func setupLeftButton() {
        self.leftButton?.addTarget(self, action: #selector(self.numbericButtonAction(_:)), for: .touchUpInside)
    }
    
    func setupCentetButton() {
        self.centerButton?.addTarget(self, action: #selector(self.numbericButtonAction(_:)), for: .touchUpInside)
    }
    
    func setupRightButton() {
        self.rightButton?.addTarget(self, action: #selector(self.numbericButtonAction(_:)), for: .touchUpInside)
    }
    
}

private extension NumbericTableViewCell {
    
    @objc func numbericButtonAction(_ sender: UIButton) {
        self.delegate?.numbericTableViewCell(self, didSelect: sender)
    }
}

