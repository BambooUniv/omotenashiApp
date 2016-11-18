//
//  SignupViewController.swift
//  omotenashiApp
//


import UIKit
import QuartzCore

class SignupViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate,UITextFieldDelegate {
  
    @IBOutlet weak var inputFormView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var cancelUIButton: UIButton!
  @IBOutlet weak var nameTextField: CustomUITextField!
  @IBOutlet weak var emailTextField: CustomUITextField!
  @IBOutlet weak var passwordTextField: CustomUITextField!
  @IBOutlet weak var sexTextField: CustomUITextField!
  @IBOutlet weak var nationalityTextField: CustomUITextField!
  @IBOutlet weak var language1TextField: CustomUITextField!
  @IBOutlet weak var language2TextField: CustomUITextField!
  
  var sexPickOption = ["男性", "女性"]
  var nationalityPickOption = ["日本", "アメリカ", "イギリス", "中国", "韓国", "ケニア"]
  var languagePickOption = ["日本語", "英語", "中国語", "韓国語", "タイ語", "アラビア語"]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    
    // UIViewPickerの生成
    let sexPickerView = UIPickerView()
    let nationalityPickerView = UIPickerView()
    let language1PickerView = UIPickerView()
    let language2PickerView = UIPickerView()
    
    // 識別用のタグを設定
    sexPickerView.tag = 1
    nationalityPickerView.tag = 2
    language1PickerView.tag = 3
    language2PickerView.tag = 4
    
    // デリゲートの設定
    sexPickerView.delegate = self
    nationalityPickerView.delegate = self
    language1PickerView.delegate = self
    language2PickerView.delegate = self
    
    // UITextFieldとUIPickerViewを関連付ける
    self.sexTextField.inputView = sexPickerView
    self.nationalityTextField.inputView = nationalityPickerView
    self.language1TextField.inputView = language1PickerView
    self.language2TextField.inputView = language2PickerView
    
    //未入力のときの文字を表示
    self.nameTextField.placeholder = "Minamimoto Sho"
    self.emailTextField.placeholder = "sample@gmail.com"
    self.sexTextField.placeholder = "選択してください"
    self.nationalityTextField.placeholder = "選択してください"
    self.language1TextField.placeholder = "選択してください"
    self.language2TextField.placeholder = "選択してください"
    
    nameTextField.delegate = self
    emailTextField.delegate = self
    passwordTextField.delegate = self
    sexTextField.delegate = self
    nationalityTextField.delegate = self
    language1TextField.delegate = self
    language2TextField.delegate = self

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
                    let offsetY: CGFloat = CGRectGetMaxY(inputFormView.frame) - CGRectGetMinY(convertedKeyboardFrame)
                    if offsetY < 0 { return }
                    updateScrollViewSize(offsetY, duration: animationDuration)
                }
            }
        }
    
    func keyboardWillBeHidden(notification: NSNotification) {
            restoreScrollViewSize()
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
    
    
    // MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  //キャンセルボタンを押した時の処理
    @IBAction func cancelButton(sender: AnyObject) {
        //signin画面へ遷移
            let storyboard: UIStoryboard = self.storyboard!
            let nextView = storyboard.instantiateViewControllerWithIdentifier("signin") as! SignInViewController
            self.presentViewController(nextView, animated: false, completion: nil)
    }
    
  @IBAction func signupButton(sender: AnyObject) {
    let nameStr = self.nameTextField.text!
    let emailStr = self.emailTextField.text!
    let passwordStr = self.passwordTextField.text!
    let sexStr = self.sexTextField.text!
    let imgStr = "default.png"
    let languagesStr = self.language1TextField.text! + "," + self.language2TextField.text!
    let nationalityStr = self.nationalityTextField.text!

    
    // サインアップ処理
    Authentication.signup(nameStr, email: emailStr, password: passwordStr, sex: sexStr, img: imgStr, languages: languagesStr, nationality: nationalityStr, completionHandler: {(isSignup) -> Void in
        if (isSignup == true) {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let viewController = storyboard.instantiateInitialViewController()! as UIViewController
            self.presentViewController(viewController, animated: true, completion: nil)
        }
    })
  }
  
  /*----------------------------------
   * UIPickerViewDelegate
   *--------------------------------*/
  func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    var number = 0
    if (pickerView.tag == 1) {
      number = sexPickOption.count
    } else if (pickerView.tag == 2) {
      number = nationalityPickOption.count
    } else if (pickerView.tag == 3) {
      number = languagePickOption.count
    } else if (pickerView.tag == 4) {
      number = languagePickOption.count
    }
    return number
  }
  
  func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    if (pickerView.tag == 1) {
      return sexPickOption[row]
    } else if (pickerView.tag == 2) {
      return nationalityPickOption[row]
    } else if (pickerView.tag == 3) {
      return languagePickOption[row]
    } else if (pickerView.tag == 4) {
      return languagePickOption[row]
    }
    return sexPickOption[row]
  }
  
  func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    if (pickerView.tag == 1) {
      sexTextField.text = sexPickOption[row]
    } else if (pickerView.tag == 2) {
      nationalityTextField.text = nationalityPickOption[row]
    } else if (pickerView.tag == 3) {
      language1TextField.text = languagePickOption[row]
    } else if (pickerView.tag == 4) {
      language2TextField.text = languagePickOption[row]
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
