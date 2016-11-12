//
//  SignInViewController.swift
//  omotenashiApp
//

//

import UIKit

class SignInViewController: UIViewController {
  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!

  
  override func viewDidLoad() {
    super.viewDidLoad()
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
    
    /*
    let isSignin: Bool = Authentication.signin(emailStr, password: passwordStr)
    if (isSignin == true) {
      let storyboard = UIStoryboard(name: "Main", bundle: nil)
      let viewController = storyboard.instantiateInitialViewController()! as UIViewController
      self.presentViewController(viewController, animated: true, completion: nil)
    }
     */
  }
}