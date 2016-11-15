//
//  UIImageExtension.swift
//  omotenashiApp
//
//  Created by sho on 2016/11/15.
//  Copyright © 2016年 TMT. All rights reserved.
//

import UIKit

extension UIImage{
    
    func rotate(angle: CGFloat, point: CGPoint) -> UIImage{
        // (1)
        UIGraphicsBeginImageContextWithOptions(CGSize(width: self.size.width, height: self.size.height), false, 0.0)
        let context: CGContextRef = UIGraphicsGetCurrentContext()!
        // (2)
        CGContextTranslateCTM(context, point.x, point.y)
        // (3)
        CGContextScaleCTM(context, 1.0, -1.0)
        
        // (4)
        let radian: CGFloat = (-angle) * CGFloat(M_PI) / 180.0
        CGContextRotateCTM(context, radian)
        // (5)
        CGContextTranslateCTM(context, -(point.x - self.size.width / 2), (point.y - self.size.height / 2))
        // (6)
        CGContextDrawImage(context, CGRectMake(-self.size.width/2, -self.size.height/2, self.size.width, self.size.height), self.CGImage)
        
        // (7)
        let rotatedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return rotatedImage
    }
    
}
