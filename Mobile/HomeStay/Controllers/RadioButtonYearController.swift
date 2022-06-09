//
//  RadioButtonYearController.swift
//  HomeStay
//
//  Created by pofiapple10 on 05/12/21.
//  Copyright © 2021 POFI TECHNOLOGIES. All rights reserved.
//

import Foundation
import UIKit

class RadioButtonYearController: NSObject {
    var buttonsYearArray: [UIButton]! {
        didSet {
            for b in buttonsYearArray {
                b.setImage(UIImage(named: "Rectangle 4641"), for: .normal)
                b.setImage(UIImage(named: "Group 8822")?.maskWithColor(color: AppColor), for: .selected)
            }
        }
    }
    var selectedButton: UIButton?
    var defaultButton: UIButton = UIButton() {
        didSet {
            buttonArrayYearUpdated(buttonSelected: self.defaultButton)
        }
    }

    func buttonArrayYearUpdated(buttonSelected: UIButton) {
        for b in buttonsYearArray {
            if b == buttonSelected {
                selectedButton = b
                b.isSelected = true
            } else {
                b.isSelected = false
            }
        }
    }
}

