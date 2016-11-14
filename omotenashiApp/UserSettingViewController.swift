//
//  UserSettingViewController.swift
//  omotenashiApp
//
//

import Foundation
import UIKit

class UserSettingViewController: UIViewController {
    
    // 画面を切り替えるTabBar
    
    // ポイント画面関する要素
    @IBOutlet weak var pointView: UIView!
    
    
    
    // 設定画面に関する要素
    @IBOutlet weak var settingView: UIView!
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 設定画面を表示する
        pointView.hidden = false
        settingView.hidden = true
        
    }
    
    
    @IBAction func showSettingButton(sender: AnyObject) {
        pointView.hidden = false
        settingView.hidden = true
    }
    
    @IBAction func showPointButton(sender: AnyObject) {
        pointView.hidden = true
        settingView.hidden = false
    }
}
