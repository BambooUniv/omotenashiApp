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
    
    
    
    @IBOutlet weak var settingButton: UIButton!
    @IBOutlet weak var pointButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UserDefaultの取得
        let ud = NSUserDefaults.standardUserDefaults()
        let userInfo = ud.objectForKey("userInfo") as? [String: String]
        
        
        
        
        // 設定画面を表示する
        pointView.hidden = true
        settingView.hidden = false
        
        // ボタンの装飾
        settingButton.backgroundColor = UIColor(red: CGFloat(156)/255.0, green: CGFloat(141)/255.0, blue: CGFloat(42)/255.0, alpha: 1.0)
        settingButton.layer.cornerRadius = 7
        pointButton.backgroundColor = UIColor(red: CGFloat(156)/255.0, green: CGFloat(141)/255.0, blue: CGFloat(42)/255.0, alpha: 1.0)
        pointButton.layer.cornerRadius = 7
        
    }
    
    
    @IBAction func showSettingButton(sender: AnyObject) {
        pointView.hidden = true
        settingView.hidden = false
    }
    
    @IBAction func showPointButton(sender: AnyObject) {
        pointView.hidden = false
        settingView.hidden = true
    }
    
    // ユーザ情報に合わせて画面の表示更新する関数
    func setViewInfoByUserInfo(userInfo: Dictionary<String, String>) {
        
    }
}
