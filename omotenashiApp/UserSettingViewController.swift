//
//  UserSettingViewController.swift
//  omotenashiApp
//
//

import Foundation
import UIKit

class UserSettingViewController: UIViewController {
    
    // 共通している画面の要素
    @IBOutlet weak var usernameLabel: UILabel!
    
    // ポイント画面関する要素
    @IBOutlet weak var pointView: UIView!
    @IBOutlet weak var pointLabel: UILabel!
    
    
    // 設定画面に関する要素
    @IBOutlet weak var settingView: UIView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var languageLabel1: UILabel!
    @IBOutlet weak var languageLabel2: UILabel!
    @IBOutlet weak var sexLabel: UILabel!
    
    
    @IBOutlet weak var settingButton: UIButton!
    @IBOutlet weak var pointButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UserDefaultの取得
        let ud = NSUserDefaults.standardUserDefaults()
        let userInfo = ud.objectForKey("userInfo") as? [String: String]
        
        // 画面の更新
        setViewInfoByUserInfo(userInfo!)
        
        
        
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
        self.usernameLabel.text = userInfo["name"]
        self.locationLabel.text = userInfo["nationality"]
        self.sexLabel.text = userInfo["sex"]
        let languages = userInfo["languages"]?.componentsSeparatedByString(",")
        print(userInfo["languages"])
        if (languages?[0] != nil) {
            languageLabel1.text = languages![0]
        }
        if (languages?[1] != nil) {
            languageLabel2.text = languages![1]
        }
        self.pointLabel.text = userInfo["point"]
 
    }
    
    
}
