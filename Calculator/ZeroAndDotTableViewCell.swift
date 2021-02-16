//
//  ZeroAndDotTableViewCell.swift
//  Calculator
//
//  Created by 주민경 on 2021/02/15.
//

import UIKit

protocol ZeroAndDotTableViewCellDelegate: class {
    func ZeroAndDotTableViewCell(_ tableViewCell: ZeroAndDotTableViewCell, didSelect button: UIButton)
}

class ZeroAndDotTableViewCell: UITableViewCell {

    @IBOutlet private weak var leftButton: UIButton?
    @IBOutlet private weak var rightButton: UIButton?
    
    weak var delegate: ZeroAndDotTableViewCellDelegate?
    
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
        self.leftButton?.addTarget(self, action: #selector(self.zeroAndDotButtonAction(_:)), for: .touchUpInside)
    }
    
    func setupRightButton() {
        self.rightButton?.addTarget(self, action: #selector(self.zeroAndDotButtonAction(_:)), for: .touchUpInside)
    }
    
}

private extension ZeroAndDotTableViewCell {
    
    @objc func zeroAndDotButtonAction(_ sender: UIButton) {
        self.delegate?.ZeroAndDotTableViewCell(self, didSelect: sender)
    }
}

