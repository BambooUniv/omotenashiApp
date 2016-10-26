//
//  Authentication.swift
//  omotenashiApp
//
//  Created by 竹之下遼 on 2016/10/26.
//  Copyright © 2016年 TMT. All rights reserved.
//

import Foundation

class Authentication {
  
  class func signin(email: String, password: String)->Bool {
    
    // POSTでAPIを叩く
    let url = NSURL(string:"http:omotenashi.prodrb.com/api/signin.php")
    let request = NSMutableURLRequest(URL: url!)
    let str = "email=" + email + "&password=" + password
    let strData = str.dataUsingEncoding(NSUTF8StringEncoding)
    request.HTTPMethod = "POST"
    request.HTTPBody = strData
    request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringLocalAndRemoteCacheData
    request.timeoutInterval = 10.0
    
    var response: NSURLResponse?
    do {
      
       // MEMO:NSURLConnectionは今後廃止されるのでNSURLSessionで書き直す必要あり
       let data = try NSURLConnection.sendSynchronousRequest(request, returningResponse: &response)
       let userInfo:NSDictionary = try! NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
       
       if userInfo != false {
       
        // サインインできたらユーザ情報をUserDefaultsに辞書型で保存1
        let userDefault = NSUserDefaults.standardUserDefaults()
        userDefault.setObject(userInfo, forKey: "userInfo") // ユーザ情報を保存
        userDefault.setObject(true, forKey: "isSignin") // サインイン情報を保存
        userDefault.synchronize()
        
        
        return true
        
       }
      
    } catch (let e) {
      print(e)
    }
    return false // サインインできなければfalseを返す
  }
  
}