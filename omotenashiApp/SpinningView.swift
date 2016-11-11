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
    
    func setup(){
        circleLayer.lineWidth = 4
        circleLayer.fillColor = nil
        circleLayer.strokeColor = UIColor(red: 0.8078, green: 0.2549, blue: 0.2392, alpha: 1.0).CGColor
        layer.addSublayer(circleLayer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let radius = min(bounds.width, bounds.height) / 2 - circleLayer.lineWidth/2
        
        let startAngle = CGFloat(-M_PI_2)
        let endAngle = startAngle + CGFloat(M_PI * 2)
        let path = UIBezierPath(arcCenter: CGPointZero, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        circleLayer.position = center
        circleLayer.path = path.CGPath
    }

}
