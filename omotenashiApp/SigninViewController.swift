//
//  SignInViewController.swift
//  omotenashiApp
//

//

import UIKit
import QuartzCore

class SignInViewController: UIViewController, UITextFieldDelegate {
  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var newUser: UIButton!
  @IBAction func newuserButton(sender: AnyObject) {
    //signin画面へ遷移
    let storyboard: UIStoryboard = self.storyboard!
    let nextView = storyboard.instantiateViewControllerWithIdentifier("Signup") as! SignupViewController
    self.presentViewController(nextView, animated: false, completion: nil)
  }
  @IBOutlet weak var passwordTextField: UITextField!
  @IBOutlet weak var signinButton: UIButton!
  @IBOutlet weak var scrollView: UIScrollView!
  @IBOutlet weak var textFieldView: UIView!
    
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
    
    emailTextField.delegate = self
    passwordTextField.delegate = self
    
  }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector: "keyboardWillBeShown:",
                                                         name: UIKeyboardWillShowNotification,
                                                         object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector: "keyboardWillBeHidden:",
                                                         name: UIKeyboardWillHideNotification,
                                                         object: nil)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        NSNotificationCenter.defaultCenter().removeObserver(self,
                                                            name: UIKeyboardWillShowNotification,
                                                            object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self,
                                                            name: UIKeyboardWillHideNotification,
                                                            object: nil)
    }
    
    func keyboardWillBeShown(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            if let keyboardFrame = userInfo[UIKeyboardFrameEndUserInfoKey]?.CGRectValue, animationDuration = userInfo[UIKeyboardAnimationDurationUserInfoKey]?.doubleValue {
                restoreScrollViewSize()
                
                let convertedKeyboardFrame = scrollView.convertRect(keyboardFrame, fromView: nil)
                let offsetY: CGFloat = CGRectGetMaxY(textFieldView.frame) - CGRectGetMinY(convertedKeyboardFrame)
                if offsetY < 0 { return }
                updateScrollViewSize(offsetY, duration: animationDuration)
            }
        }

    }
    
    func keyboardWillBeHidden(notification: NSNotification) {
        restoreScrollViewSize()
    }
    
    // MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        return true
    }
    
    func updateScrollViewSize(moveSize: CGFloat, duration: NSTimeInterval) {
        UIView.beginAnimations("ResizeForKeyboard", context: nil)
        UIView.setAnimationDuration(duration)
        
        let contentInsets = UIEdgeInsetsMake(0, 0, moveSize, 0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
        scrollView.contentOffset = CGPointMake(0, moveSize)
        
        UIView.commitAnimations()
    }
    
    func restoreScrollViewSize() {
        scrollView.contentInset = UIEdgeInsetsZero
        scrollView.scrollIndicatorInsets = UIEdgeInsetsZero
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