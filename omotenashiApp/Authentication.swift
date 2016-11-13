//
//  Authentication.swift
//  omotenashiApp
//
//  Copyright © 2016年 TMT. All rights reserved.
//

import Foundation
import UIKit

class Authentication {
  
  /*----------------------------------------
  * サインアップを行う関数
  *----------------------------------------*/
    class func signup(name: String, email: String, password: String, sex: String, img: String, languages: String, nationality: String, completionHandler: (Bool) -> Void){
        var result = false
        
        let params = ["name":name, "email":email, "password":password, "sex":sex, "img":img, "languages":languages, "nationality":nationality]
        let request = Http.createPostRequest(Const.apiSignupUrl, params: params)
        let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
        let task = session.dataTaskWithRequest(request, completionHandler: {
            (data, resp, err) in
          if (data != false) {
                dispatch_async(dispatch_get_main_queue(), {
                    result = true
                    completionHandler(result)
                })
          }
    })
    task.resume()
    
  }
  
  
  /*----------------------------------------
  * メールアドレスとパスワードでサインイン処理を行う
  *----------------------------------------*/
    class func signin(email: String, password: String, completionHandler: (Bool) -> Void) {
        
    var result = false
    
    let params = ["email":email, "password":password]
    let request = Http.createPostRequest(Const.apiSigninUrl, params: params)
    let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
    let task = session.dataTaskWithRequest(request, completionHandler: {
        (data, resp, err) in
        let userInfo:NSDictionary = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
        if userInfo != false {
            // サインインできたらユーザ情報をUserDefaultsに辞書型で保存1
            let userDefault = NSUserDefaults.standardUserDefaults()
            userDefault.setObject(userInfo, forKey: "userInfo") // ユーザ情報を保存
            userDefault.setObject(true, forKey: "isSignin") // サインイン情報を保存
            userDefault.synchronize()
            
            dispatch_async(dispatch_get_main_queue(), {
                result = true
                completionHandler(result)
            })
       }
    })
    task.resume()
        
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