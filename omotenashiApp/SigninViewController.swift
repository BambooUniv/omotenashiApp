//
//  SignInViewController.swift
//  omotenashiApp
//

//

import UIKit
import QuartzCore

class SignInViewController: UIViewController {
  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var newUser: UIButton!
  @IBOutlet weak var passwordTextField: UITextField!
  @IBOutlet weak var signinButton: UIButton!

  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    //textFild,UIButtonの角を丸くする
    emailTextField.layer.cornerRadius = 4.0  //丸角の半径
    passwordTextField.layer.cornerRadius = 4.0
    signinButton.layer.cornerRadius = 4.0
    
//    //新規登録ボタン
//    newUser.layer.cornerRadius = 4.0
//    let newUserColor: UIColor = UIColor(red: 147, green: 118, blue: 64,alpha: 1.0)
//    newUser.layer.borderColor = newUserColor.CGColor
//    newUser.layer.borderWidth = 2.0

    
    // 影設定
    emailTextField.layer.shadowOpacity = 0.15
    emailTextField.layer.masksToBounds = false
    passwordTextField.layer.shadowOpacity = 0.15
    passwordTextField.layer.masksToBounds = false
    
    //影のかかる方向を指定
    emailTextField.layer.shadowOffset = CGSizeMake(1.0, 1.0)
    passwordTextField.layer.shadowOffset = CGSizeMake(1.0, 1.0)
    
    //テキストボックスに余白を入れる
    emailTextField.leftView = UIView(frame: CGRectMake(0,0,8, emailTextField.frame.size.height))
    emailTextField.leftViewMode = UITextFieldViewMode.Always
    passwordTextField.leftView = UIView(frame: CGRectMake(0,0,8, passwordTextField.frame.size.height))
    passwordTextField.leftViewMode = UITextFieldViewMode.Always

    
  }
  
  @IBAction func signinButton(sender: AnyObject) {
    let emailStr = self.emailTextField.text!
    let passwordStr = self.passwordTextField.text!
    
    // サインイン処理
    Authentication.signin(emailStr, password: passwordStr, completionHandler: {(isSignin: Bool)->Void in
        if (isSignin == true) {
          let storyboard = UIStoryboard(name: "Main", bundle: nil)
          let viewController = storyboard.instantiateInitialViewController()! as UIViewController
          self.presentViewController(viewController, animated: true, completion: nil)
        }
    })
  }
}