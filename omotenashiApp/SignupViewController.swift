//
//  SignupViewController.swift
//  omotenashiApp
//


import UIKit

class SignupViewController: UIViewController {
  
  @IBOutlet weak var nameTextField: CustomUITextField!
  @IBOutlet weak var emailTextField: CustomUITextField!
  @IBOutlet weak var passwordTextField: CustomUITextField!
  
    override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.

  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func signupButton(sender: AnyObject) {
    let nameStr = self.nameTextField.text!
    let emailStr = self.emailTextField.text!
    let passwordStr = self.passwordTextField.text!
    let imgStr = "test"
    let languagesStr = "test"
    let nationalityStr = "test"

    
    // サインアップ処理
    let isSignup: Bool = Authentication.signup(nameStr, email: emailStr, password: passwordStr, img: imgStr, languages: languagesStr, nationality: nationalityStr)
    // サインアップできたらメイン画面へ遷移
    if (isSignup == true) {
      let storyboard = UIStoryboard(name: "Main", bundle: nil)
      let viewController = storyboard.instantiateInitialViewController()! as UIViewController
      self.presentViewController(viewController, animated: true, completion: nil)
    }
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
