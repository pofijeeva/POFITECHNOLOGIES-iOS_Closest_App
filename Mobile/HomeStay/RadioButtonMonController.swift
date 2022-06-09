//
//  RadioButtonMonController.swift
//  HomeStay
//
//  Created by pofiapple10 on 05/12/21.
//  Copyright © 2021 POFI TECHNOLOGIES. All rights reserved.
//

import Foundation
import UIKit

class RadioButtonMonController: NSObject {
    var buttonsMonArray: [UIButton]! {
        didSet {
            for b in buttonsMonArray {
                b.setImage(UIImage(named: "Rectangle 4641"), for: .normal)
                b.setImage(UIImage(named: "Group 8822")?.maskWithColor(color: AppColor), for: .selected)
            }
        }
    }
    var selectedButton: UIButton?
    var defaultButton: UIButton = UIButton() {
        didSet {
            buttonMonArrayUpdated(buttonSelected: self.defaultButton)
        }
    }

    func buttonMonArrayUpdated(buttonSelected: UIButton) {
        for b in buttonsMonArray {
            if b == buttonSelected {
                selectedButton = b
                b.isSelected = true
            } else {
                b.isSelected = false
            }
        }
    }
}

