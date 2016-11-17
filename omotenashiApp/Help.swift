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
        
        let params = ["user_id":userId, "content":content, "latitude":String(latitude), "longitude": String(longitude)]
        let request = Http.createPostRequest(Const.apiHelpCreateUrl, params: params)
        let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
        let task = session.dataTaskWithRequest(request, completionHandler: {
            (data, resp, err) in
        })
        task.resume()
        
    }
    
    
    class func didOmotenashi(helpId: String) {
        print(helpId)
        let params = ["helpId":helpId]
        let request = Http.createPostRequest(Const.apiHelpDidOmotenashiUrl, params: params)
        let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
        let task = session.dataTaskWithRequest(request, completionHandler: {
            (data, resp, err) in
        })
        task.resume()
        
    }
    
    
    // 自分のリクエストが承認されたかどうか確認する関数
    class func confirmedHelpRequest(requestId: String, completionHandler: (String) -> Void) {
        var result = "false"
        let params = ["requestId":requestId]
        let request = Http.createPostRequest(Const.apiHelpComfirmUrl, params: params)
        let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
        let task = session.dataTaskWithRequest(request, completionHandler: {
            (data, resp, err) in
            let data = NSString(data: data!, encoding: NSUTF8StringEncoding) as! String
            if (data != "false") {
                dispatch_async(dispatch_get_main_queue(), {
                    result = data
                    completionHandler(result)
                })
            } else {
                dispatch_async(dispatch_get_main_queue(), {
                    completionHandler(result)
                })
            }
            
        })
        task.resume()
    }
    
    
    // 自分の現在位置から100m(distance)以内のお助けリクエストが存在するか確認する処理
    class func getHelpWithLocation(latitude: Double, longitude: Double, distance: Int) {
        
        let params = ["latitude":String(latitude), "longitude":String(longitude), "distance":String(distance)]
        let request = Http.createPostRequest(Const.apiHelpSearchUrl, params: params)
        let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
        let task = session.dataTaskWithRequest(request, completionHandler: {
            (data, resp, err) in
            do {
                let helpRequest: ReturnHelpRequest = try Unbox(data!)
                // 既にそのお助けリクエストの通知を受け取っていないか確認
                let userDefault = NSUserDefaults.standardUserDefaults()
                var helpInfo:Dictionary = userDefault.objectForKey("helpInfo") as! Dictionary<String, AnyObject>
                let notifiedHelpIdList = helpInfo["notifiedHelpIdList"]?.mutableCopy() as! NSMutableArray
                let isNotified = notifiedHelpIdList.indexOfObject(helpRequest.id)
                if (isNotified == NSNotFound) {
                    
                    // お助けリクエスト情報を保存する
                    self.setActiveHelpInfo(helpRequest)
                    
                    let notification = Notification.createDefaultNotification(String(helpRequest.distance), alertAction: "アプリを開く")
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
            
        })
        task.resume()
    
    }
    
    class func setHelpDistance(id: String, distance: String) {
        let params = ["id":id, "distance":distance]
        let request = Http.createPostRequest(Const.apiHelpSetDistanceUrl, params: params)
        let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
        let task = session.dataTaskWithRequest(request, completionHandler: {
            (data, resp, err) in
        })
        task.resume()
    }
    
    // 自分が承認したお助けリクエストの情報を取得する
    class func getActiveHelpInfo() -> Dictionary<String, String>{
        let userDefault = NSUserDefaults.standardUserDefaults()
        let activeHelpInfo = userDefault.objectForKey("helpActiveInfo") as! Dictionary<String, String>
        
        return activeHelpInfo
    }
    
    // リクエストを承認したことをサーバーに伝える
    class func informConfirmHelp(userId: String, helpId: String){
        
        var _helpId = String(helpId)
        var _userId = String(userId)
        
        
        let params = ["user_id":_userId, "help_id":_helpId,]
        let request = Http.createPostRequest(Const.apiHelpsetConfirmUrl, params: params)
        let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
        let task = session.dataTaskWithRequest(request, completionHandler: {
            (data, resp, err) in
        })
        task.resume()
        
    }
    
    class func getDistanceFromServer(id: String, completionHander: (String) -> Void) {
        var result = "false"
        let params = ["id": id, "test": "tst"]
        let request = Http.createPostRequest(Const.apiHelpGetDistanceUrl, params: params)
        let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
        let task = session.dataTaskWithRequest(request, completionHandler: {
            (data, resp, err) in
            let data = NSString(data: data!, encoding: NSUTF8StringEncoding) as! String
            if (data != "false") {
                dispatch_async(dispatch_get_main_queue(), {
                    result = data
                    completionHander(result)
                })
            } else {
                dispatch_async(dispatch_get_main_queue(), {
                    completionHander(result)
                })
            }
        })
        task.resume()
    }
    
    class func setActiveHelpInfo(helpInfo: ReturnHelpRequest) {
        let id = String(helpInfo.id)
        let name = String(helpInfo.name)
        let sex = String(helpInfo.sex)
        let content = String(helpInfo.content)
        let nationality = String(helpInfo.nationality)
        let distance = String(helpInfo.distance)
        let direction = String(helpInfo.direction)
        let latitude = String(helpInfo.latitude)
        let longitude = String(helpInfo.longitude)
        
        let helpActiveInfo = [
            "id": id,
            "name": name,
            "sex": sex,
            "content": content,
            "nationality": nationality,
            "distance": distance,
            "direction": direction,
            "latitude": latitude,
            "longitude": longitude
        ]
        
        let userDefault = NSUserDefaults.standardUserDefaults()
        userDefault.setObject(helpActiveInfo, forKey: "helpActiveInfo") // リクエスト関連情報の保存
        userDefault.synchronize()
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
    let sex: String
    let name: String
    let nationality: String
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
        self.sex = unboxer.unbox("sex")
        self.name = unboxer.unbox("name")
        self.nationality = unboxer.unbox("nationality")
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
