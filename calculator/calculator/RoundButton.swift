//
//  RoundButton.swift
//  calculator
//
//  Created by 안선영 on 2022/08/14.
//

import UIKit

@IBDesignable
class RoundButton: UIButton {
    @IBInspectable var isRound: Bool = false{
        didSet{
            if isRound{
                self.layer.cornerRadius = self.frame.height / 2
            }
        }
    }
}
