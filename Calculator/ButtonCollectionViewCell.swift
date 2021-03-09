//
//  CalculatorCollectionViewCell.swift
//  Calculator
//
//  Created by 주민경 on 2021/02/16.
//

import UIKit

protocol ButtonCollectionViewCellDelegate: class {
    func buttonCollectionViewCell(_ cell: ButtonCollectionViewCell, didSelect button: UIButton)
}

class ButtonCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cellButton: UIButton?
    
    weak var delegate: ButtonCollectionViewCellDelegate?
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupButton()
        
    }
    
    func update(_ indexPath: IndexPath) {
        let row = indexPath.row
        
        var title = ""
        let isOperatorButton = row == 3 || row == 7 || row == 11 || row == 14 || row == 16
        
        if isOperatorButton {
            title = self.getOperatorString(row)
            self.cellButton?.backgroundColor = UIColor.orange
            self.cellButton?.setTitleColor(UIColor.darkGray, for: .normal)
            
        } else {
            title = self.getNumbericString(row)
            self.cellButton?.backgroundColor = UIColor(red: CGFloat(49 / 255.0), green: CGFloat(49 / 255.0), blue:CGFloat(40 / 255.0), alpha: CGFloat(0.9))
            self.cellButton?.setTitleColor(UIColor.white, for: .normal)
        }
        
        self.cellButton?.setTitle(title, for: .normal)
    }
    
    func getOperatorString(_ row: Int) -> String {
        
        var operatorString = "*"
        
        switch row {
        case 3:
            operatorString = "+"
            
        case 7:
            operatorString = "-"
            
        case 11:
            operatorString = "x"
            
        case 14:
            operatorString = "/"
            
        default:
            operatorString = "="
        }
    
        return operatorString
    }
    
    func getNumbericString(_ row: Int) -> String {
        var numbericString = "0"
        
        if row == 15 {
            numbericString = "AC"
            
        } else if row == 13 {
            numbericString = "."
            
        } else {
            switch row {
            case 0,1,2:
                numbericString = String(7 + row)
                
            case 4,5,6:
                numbericString = String(row)
                
            case 8,9,10:
                numbericString = String(row - 7)
                
            default:
                numbericString = "0"
            }
        }
    
        return numbericString
    }

}

private extension ButtonCollectionViewCell {
    
    func setupButton() {
        self.cellButton?.addTarget(self, action: #selector(self.buttonCellDidTap(_:)), for: .touchUpInside)
    }
    
    @objc func buttonCellDidTap(_ sender: UIButton) {
        self.delegate?.buttonCollectionViewCell(self, didSelect: sender)
    }
}
