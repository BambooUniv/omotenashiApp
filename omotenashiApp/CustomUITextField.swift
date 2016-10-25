//
//  MyUITextField.swift
//  omotenashiApp
//



import UIKit

class CustomUITextField: UITextField {

  
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
      // 余白設定
      self.leftView = UIView(frame: CGRect(x: 0,y: 0,width: 10,height: 5))
      self.leftView?.backgroundColor = UIColor.clearColor()
      self.leftViewMode = UITextFieldViewMode.Always
    }
 

}
