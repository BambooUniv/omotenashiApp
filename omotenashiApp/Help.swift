//
//  Help.swift
//  omotenashiApp
//
// お助け機能関係を司るクラス
//

import Foundation
import UIKit

class Help {
  
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
  
}
