//
//  Notification.swift
//  
//  通知を管理するクラス
//

import Foundation
import UIKit

class Notification {
    
    class func createDefaultNotification(alertBody: String, alertAction: String) -> UILocalNotification {
        //ローカル通知
        let notification = UILocalNotification()
        //ロック中にスライドで〜〜のところの文字
        notification.alertAction = alertAction
        //通知の本文
        notification.alertBody = String(alertBody) + "m先で困っている人がいます！！"
        //通知される時間（とりあえず10秒後に設定）
        notification.fireDate = NSDate(timeIntervalSinceNow:0.1)
        //通知音
        notification.soundName = UILocalNotificationDefaultSoundName
        //アインコンバッジの数字
        notification.applicationIconBadgeNumber = 1
        //通知を識別するID
        notification.userInfo = ["notifyID":"gohan"]
        
        return notification
    }
}
