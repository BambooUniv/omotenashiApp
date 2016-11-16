//
//  MyUITextField.swift
//  omotenashiApp
//



import UIKit
import QuartzCore

class CustomUITextField: UITextField {

  
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
      
      // 角丸設定
      self.layer.cornerRadius = 40.0
        
      // 余白設定
      self.leftView = UIView(frame: CGRect(x: 0,y: 0,width: 10,height: 5))
      self.leftView?.backgroundColor = UIColor.clearColor()
      self.leftViewMode = UITextFieldViewMode.Always
      
      // 影設定
      self.layer.shadowOpacity = 0.15
      self.layer.masksToBounds = false
        
      //影のかかる方向を指定
      self.layer.shadowOffset = CGSizeMake(1.0, 1.0)
        
      // 影設定
      self.layer.shadowOpacity = 0.15
      self.layer.masksToBounds = false
      
    }
 

}
