//
//  SpinningView.swift
//  omotenashiApp
//
//  Created by sho on 2016/11/10.
//  Copyright © 2016年 TMT. All rights reserved.
//

import UIKit

class SpinningView: UIView{
    
    let circleLayer = CAShapeLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
}

func setup(){
    circleLayer.line
}
