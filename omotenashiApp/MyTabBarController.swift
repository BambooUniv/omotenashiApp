//
//  MyTabBarController.swift
//  omotenashiApp
//
//

import Foundation
import UIKit

extension UIColor {
    class func rgb(r: Int, g: Int, b: Int, alpha: CGFloat) -> UIColor{
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: alpha)
    }
    class func MainColor() -> UIColor {
        return UIColor.rgb(24, g: 135, b: 208, alpha: 1.0)
    }
}

class MyTabBarController :UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.barTintColor = UIColor.rgb(233, g: 203, b: 115, alpha: 1)
        
        let colorKey = UIColor(red: 156/255, green: 140/255, blue: 42/255, alpha: 1.0)
        // fontの設定
        let fontFamily: UIFont! = UIFont.systemFontOfSize(10)
        // 選択時の設定
        let selectedAttributes = [NSFontAttributeName: fontFamily, NSForegroundColorAttributeName: colorKey]
        /// タイトルテキストカラーの設定
        UITabBarItem.appearance().setTitleTextAttributes(selectedAttributes, forState: UIControlState.Selected)
        
        self.tabBar.items![0].image = UIImage(named: "tabImageHelp")!.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        self.tabBar.items![1].image = UIImage(named: "tabImageUser")!.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        self.tabBar.items![2].image = UIImage(named: "tabImageOmotenashi")!.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        
        self.tabBar.items![2].enabled = false
       
    }
}
