//
//  SignupViewController.swift
//  omotenashiApp
//


import UIKit

class SignupViewController: UIViewController {
  
  @IBOutlet weak var nameTextField: CustomUITextField!
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
    let nameStr = self.nameTextField.text
    let passwordStr = self.passwordTextField.text
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
