//
//  MyTabBarController.swift
//  omotenashiApp
//
//

import Foundation
import UIKit

class MyTabBarController :UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.barTintColor = UIColor.brownColor()
        
        self.tabBar.items![0].image = UIImage(named: "tabImageHelp")!.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        self.tabBar.items![1].image = UIImage(named: "tabImageUser")!.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        self.tabBar.items![2].image = UIImage(named: "tabImageOmotenashi")!.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
       
    }
}
