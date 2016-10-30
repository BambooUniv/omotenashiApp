//
//  Authentication.swift
//  omotenashiApp
//
//  Copyright © 2016年 TMT. All rights reserved.
//

import Foundation
import UIKit

class Authentication {
  
  class func signup(name: String, email: String, password: String, img: String, languages: String, nationality: String)->Bool {
    
    // POSTでAPIを叩く
    let url = NSURL(string:Const.apiSignupUrl)
    let request = NSMutableURLRequest(URL: url!)

    // パラメータの作成
    var str = "name="+name+"&"
        str = str + "email="+email+"&"
        str = str + "password="+password+"&"
        str = str + "img="+img+"&"
        str = str + "languages="+languages+"&"
        str = str + "nationality="+nationality
    
    let strData = str.dataUsingEncoding(NSUTF8StringEncoding)
    request.HTTPMethod = "POST"
    request.HTTPBody = strData
    request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringLocalAndRemoteCacheData
    request.timeoutInterval = 10.0
    
    var response: NSURLResponse?
    do {
      
      // MEMO:NSURLConnectionは今後廃止されるのでNSURLSessionで書き直す必要あり
      let data = try NSURLConnection.sendSynchronousRequest(request, returningResponse: &response)
      if (data != false) {
        return true
      }
      
    } catch (let e) {
      print(e)
    }
    
    return false
  }
  
  
  /*----------------------------------------
  * メールアドレスとパスワードでサインイン処理を行う
  *----------------------------------------*/
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
  
  
  /*----------------------------------------
   * サインアウト処理
   *----------------------------------------*/
  class func signout() {
    
    let userDefault = NSUserDefaults.standardUserDefaults()
    let isSignin = userDefault.objectForKey("isSignin") as? Bool
    
    if (isSignin == true) {
      userDefault.setObject(false, forKey: "isSignin")
    }
    
    // サインイン画面に遷移
    let storyboard = UIStoryboard(name: "Signin", bundle: nil)
    let signInViewController = storyboard.instantiateViewControllerWithIdentifier("signin") as! SignInViewController

    
    // MEMO: これだとサインアウトボタンを押すたびにViewControllerが無限に生成されて
    //        メモリを圧迫するので要リファクタリング
    var tc = UIApplication.sharedApplication().keyWindow?.rootViewController;
    tc?.dismissViewControllerAnimated(true, completion: nil)
    while ((tc!.presentedViewController) != nil) {
      tc = tc!.presentedViewController;
    }
    tc?.presentViewController(signInViewController, animated: true, completion: nil)
  }
  
  
  
  
}