//
//  SignupViewController.swift
//  omotenashiApp
//


import UIKit

class SignupViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
  
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
    

  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func signupButton(_ sender: AnyObject) {
    let nameStr = self.nameTextField.text!
    let emailStr = self.emailTextField.text!
    let passwordStr = self.passwordTextField.text!
    let sexStr = self.sexTextField.text!
    let imgStr = "default.png"
    let languagesStr = self.language1TextField.text! + "," + self.language2TextField.text!
    let nationalityStr = self.nationalityTextField.text!

    
    // サインアップ処理
    let isSignup: Bool = Authentication.signup(nameStr, email: emailStr, password: passwordStr, sex: sexStr, img: imgStr, languages: languagesStr, nationality: nationalityStr)
    // サインアップできたらメイン画面へ遷移
    if (isSignup == true) {
      let storyboard = UIStoryboard(name: "Main", bundle: nil)
      let viewController = storyboard.instantiateInitialViewController()! as UIViewController
      self.present(viewController, animated: true, completion: nil)
    }
  }
  
  /*----------------------------------
   * UIPickerViewDelegate
   *--------------------------------*/
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
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
  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
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
  
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
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
