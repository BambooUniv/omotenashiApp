//
//  CustomButton.swift
//  omotenashiApp
//
//  Created by 竹之下遼 on 2016/11/14.
//  Copyright © 2016年 TMT. All rights reserved.
//

import Foundation
import UIKit

class CustomButton :UIButton {
    @IBInspectable var highlightedBackgroundColor :UIColor?
    @IBInspectable var nonHighlightedBackgroundColor :UIColor?
    override var highlighted :Bool {
        didSet {
            if highlighted {
                self.backgroundColor = highlightedBackgroundColor
            }
            else {
                self.backgroundColor = nonHighlightedBackgroundColor
            }
        }
    }
}