//
//  SignupViewController.swift
//  omotenashiApp
//


import UIKit

class SignupViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    // POSTでAPIを叩く
    let url = NSURL(string:"http:omotenashi.prodrb.com/api/signup.php")
    let request = NSMutableURLRequest(URL: url!)
    let str = "name=test4&email=test4@gmail.com&password=test4&img=test4&languages=japanese,english&nationality=japan"
    let strData = str.dataUsingEncoding(NSUTF8StringEncoding)
    request.HTTPMethod = "POST"
    request.HTTPBody = strData
    request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringLocalAndRemoteCacheData
    request.timeoutInterval = 10.0
    
    var response: NSURLResponse?
    do {
      
      // MEMO:NSURLConnectionは今後廃止されるのでNSURLSessionで書き直す必要あり
      let data = try NSURLConnection.sendSynchronousRequest(request, returningResponse: &response)
      /*
       let userInfo:NSDictionary = try! NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
       
       if userInfo != false {
       
       // サインインできたらユーザ情報をUserDefaultsに辞書型で保存1
       let userDefault = NSUserDefaults.standardUserDefaults()
       userDefault.setObject(userInfo, forKey: "userInfo") // ユーザ情報を保存
       userDefault.setObject(true, forKey: "isSignin") // サインイン情報を保存
       userDefault.synchronize()
       
       
       }
       */
    } catch (let e) {
      print(e)
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
   // Get the new view controller using segue.destinationViewController.
   // Pass the selected object to the new view controller.
   }
   */
  
}
