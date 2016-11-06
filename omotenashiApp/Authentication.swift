//
//  Authentication.swift
//  omotenashiApp
//
//  Copyright © 2016年 TMT. All rights reserved.
//

import Foundation
import UIKit

class Authentication {
  
  class func signup(_ name: String, email: String, password: String, sex: String, img: String, languages: String, nationality: String)->Bool {
    
    // POSTでAPIを叩く
    let url = URL(string:Const.apiSignupUrl)
    let request = NSMutableURLRequest(url: url!)

    // パラメータの作成
    var str = "name="+name+"&"
        str = str + "email="+email+"&"
        str = str + "password="+password+"&"
        str = str + "sex="+sex+"&"
        str = str + "img="+img+"&"
        str = str + "languages="+languages+"&"
        str = str + "nationality="+nationality
    
    let strData = str.data(using: String.Encoding.utf8)
    request.httpMethod = "POST"
    request.httpBody = strData
    request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringLocalAndRemoteCacheData
    request.timeoutInterval = 10.0
    
    var response: URLResponse?
    do {
      
      // MEMO:NSURLConnectionは今後廃止されるのでNSURLSessionで書き直す必要あり
      let data = try NSURLConnection.sendSynchronousRequest(request as URLRequest, returning: &response)
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
  class func signin(_ email: String, password: String)->Bool {
    
    // POSTでAPIを叩く
    let url = URL(string:"http:omotenashi.prodrb.com/api/signin.php")
    let request = NSMutableURLRequest(url: url!)
    let str = "email=" + email + "&password=" + password
    let strData = str.data(using: String.Encoding.utf8)
    request.httpMethod = "POST"
    request.httpBody = strData
    request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringLocalAndRemoteCacheData
    request.timeoutInterval = 10.0
    
    var response: URLResponse?
    do {
      
       // MEMO:NSURLConnectionは今後廃止されるのでNSURLSessionで書き直す必要あり
       let data = try NSURLConnection.sendSynchronousRequest(request as URLRequest, returning: &response)
       let userInfo:NSDictionary = try! JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
       
       if userInfo != false {
       
        // サインインできたらユーザ情報をUserDefaultsに辞書型で保存1
        let userDefault = UserDefaults.standard
        userDefault.set(userInfo, forKey: "userInfo") // ユーザ情報を保存
        userDefault.set(true, forKey: "isSignin") // サインイン情報を保存
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
    
    let userDefault = UserDefaults.standard
    let isSignin = userDefault.object(forKey: "isSignin") as? Bool
    
    if (isSignin == true) {
      userDefault.set(false, forKey: "isSignin")
    }
    
    // サインイン画面に遷移
    let storyboard = UIStoryboard(name: "Signin", bundle: nil)
    let signInViewController = storyboard.instantiateViewController(withIdentifier: "signin") as! SignInViewController

    
    // MEMO: これだとサインアウトボタンを押すたびにViewControllerが無限に生成されて
    //        メモリを圧迫するので要リファクタリング
    var tc = UIApplication.shared.keyWindow?.rootViewController;
    tc?.dismiss(animated: true, completion: nil)
    while ((tc!.presentedViewController) != nil) {
      tc = tc!.presentedViewController;
    }
    tc?.present(signInViewController, animated: true, completion: nil)
  }
  
  
  
  
}
