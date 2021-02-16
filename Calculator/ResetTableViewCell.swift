//
//  ResetTableViewCell.swift
//  Calculator
//
//  Created by 주민경 on 2021/02/09.
//

import UIKit

protocol ResetTableViewCellDelegate: class {
    func resetTableViewCell(_ tableViewCell: ResetTableViewCell, didSelect button: UIButton)
}

class ResetTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var resetButton: UIButton?
    
    weak var delegate: ResetTableViewCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupResetButton()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

private extension ResetTableViewCell {
    
    func setupResetButton() {
        self.resetButton?.addTarget(self, action: #selector(self.resetButtonAction(_:)), for: .touchUpInside)
    }
    
}

private extension ResetTableViewCell {
    
    @objc func resetButtonAction(_ sender: UIButton) {
        self.delegate?.resetTableViewCell(self, didSelect: sender)
    }
}
