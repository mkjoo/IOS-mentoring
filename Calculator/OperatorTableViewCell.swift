//
//  OperatorTableViewCell.swift
//  Calculator
//
//  Created by 주민경 on 2021/02/09.
//

import UIKit

protocol OperatorTableViewCellDelegate: class {
    func operatorTableViewCell(_ tableViewCell: OperatorTableViewCell, didSelect button: UIButton)
}
class OperatorTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var button: UIButton?
    
    weak var delegate: OperatorTableViewCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.setupOperatorButton()

    }
    
    func setupOperator(_ indexPath: IndexPath) {
        var operatorString = "*"
        if indexPath.row == 0 {
            operatorString = "+"
        } else if indexPath.row == 1 {
            operatorString = "-"
        } else if indexPath.row == 2 {
            operatorString = "*"
        } else if indexPath.row == 3 {
            operatorString = "/"
        } else {
            operatorString = "="
        }
        self.button?.setTitle("\(operatorString)", for: .normal)
       

    }

    
}

private extension OperatorTableViewCell {
    
    func setupOperatorButton() {
        self.button?.addTarget(self, action: #selector(self.operatorButtonAction(_:)), for: .touchUpInside)
    }
    
}

private extension OperatorTableViewCell {
    
    @objc func operatorButtonAction(_ sender: UIButton) {
        self.delegate?.operatorTableViewCell(self, didSelect: sender)
    }
}
