//
//  Help.swift
//  omotenashiApp
//
// お助け機能関係を司るクラス
//

import Foundation
import UIKit
import Unbox

class Help {
    
    // お助けリクエストに関するUserDefaultが設定されていない場合初期化する関数
    class func initHelpUserDefault() {
        
        let userDefault = NSUserDefaults.standardUserDefaults()
        let helpInfo = [
            "IsActive": false,           // 現在お助けリクエストを承諾中かどうか
            "activeHelpId": "",        // 承諾しているお助けリクエストのID
            "notifiedHelpIdList": [],  // 既に通知が来たお助けリクエストのIDの配列
        ]
        
        userDefault.setObject(helpInfo, forKey: "helpInfo") // リクエスト関連情報の保存
        userDefault.synchronize()
    }
  
    // お助けリクエストを作成する処理
    class func sendHelpWithType(userId: String, content: String, latitude: Double, longitude: Double) {
        // POSTでAPIを叩く
        let url = NSURL(string:Const.apiHelpCreateUrl)
        let request = NSMutableURLRequest(URL: url!)
        
        // パラメータの作成
        let str = "user_id="+userId+"&content="+content+"&latitude="+String(latitude)+"&longitude="+String(longitude)
        
        let strData = str.dataUsingEncoding(NSUTF8StringEncoding)
        request.HTTPMethod = "POST"
        request.HTTPBody = strData
        request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringLocalAndRemoteCacheData
        request.timeoutInterval = 10.0
        
        var response: NSURLResponse?
        do {
          // MEMO:NSURLConnectionは今後廃止されるのでNSURLSessionで書き直す必要あり
          let data = try NSURLConnection.sendSynchronousRequest(request, returningResponse: &response)

        } catch (let e) {
          print(e)
        }
    }
    
    
    // 自分の現在位置から100m(distance)以内のお助けリクエストが存在するか確認する処理
    class func getHelpWithLocation(latitude: Double, longitude: Double, distance: Int) {
        // POSTでAPIを叩く
        let url = NSURL(string:Const.apiHelpSearchUrl)
        let request = NSMutableURLRequest(URL: url!)
        
        // パラメータの作成
        let str = "latitude="+String(latitude)+"&longitude="+String(longitude)+"&distance="+String(distance)
        
        let strData = str.dataUsingEncoding(NSUTF8StringEncoding)
        request.HTTPMethod = "POST"
        request.HTTPBody = strData
        request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringLocalAndRemoteCacheData
        request.timeoutInterval = 10.0
        
        var response: NSURLResponse?
        do {
          // MEMO:NSURLConnectionは今後廃止されるのでNSURLSessionで書き直す必要あり
            let data = try NSURLConnection.sendSynchronousRequest(request, returningResponse: &response)
            do {
                let helpRequest: ReturnHelpRequest = try Unbox(data)
                
                // 既にそのお助けリクエストの通知を受け取っていないか確認
                let userDefault = NSUserDefaults.standardUserDefaults()
                var helpInfo:Dictionary = userDefault.objectForKey("helpInfo") as! Dictionary<String, AnyObject>
                let notifiedHelpIdList = helpInfo["notifiedHelpIdList"]?.mutableCopy() as! NSMutableArray
                
                let isNotified = notifiedHelpIdList.indexOfObject(helpRequest.id)
                if (isNotified == NSNotFound) {
                    //ローカル通知
                    let notification = UILocalNotification()
                    //ロック中にスライドで〜〜のところの文字
                    notification.alertAction = "アプリを開く"
                    //通知の本文
                    notification.alertBody = String(helpRequest.distance) + "m先で困っている人がいます！！"
                    //通知される時間（とりあえず10秒後に設定）
                    notification.fireDate = NSDate(timeIntervalSinceNow:0.1)
                    //通知音
                    notification.soundName = UILocalNotificationDefaultSoundName
                    //アインコンバッジの数字
                    notification.applicationIconBadgeNumber = 1
                    //通知を識別するID
                    notification.userInfo = ["notifyID":"gohan"]
                    //通知をスケジューリング
                    UIApplication.sharedApplication().scheduleLocalNotification(notification)
                    
                    
                    
                    
                    // 受け取った通知のIDをリストに加える
                    notifiedHelpIdList.addObject(helpRequest.id)
                    helpInfo["notifiedHelpIdList"] = notifiedHelpIdList
                    userDefault.setObject(helpInfo, forKey: "helpInfo")
                }
                
                
            } catch let error {
                print(error);
            }
          
        } catch (let e) {
            print(e)
        }
    }
}

struct HelpRequest {
    let id: Int
    let user_id: Int
    let content: String
    let latitude: Double
    let longitude: Double
    let created: Int
    let updated: Int
    let is_resolved: Int
    let resolved_user_id: Int
}


struct ReturnHelpRequest {
    let id: Int
    let user_id: Int
    let content: String
    let latitude: Double
    let longitude: Double
    let created: Int
    let updated: Int
    let is_resolved: Int?
    let resolved_user_id: Int?
    let distance: Int
    let direction: Int
}

extension ReturnHelpRequest: Unboxable {
    init(unboxer: Unboxer) {
        self.id = unboxer.unbox("id")
        self.user_id = unboxer.unbox("user_id")
        self.content = unboxer.unbox("content")
        self.latitude = unboxer.unbox("latitude")
        self.longitude = unboxer.unbox("longitude")
        self.created = unboxer.unbox("created")
        self.updated = unboxer.unbox("updated")
        self.is_resolved = unboxer.unbox("is_resolved")
        self.resolved_user_id = unboxer.unbox("resolve_user_id")
        self.distance = unboxer.unbox("distance")
        self.direction = unboxer.unbox("direction")
    }
}
