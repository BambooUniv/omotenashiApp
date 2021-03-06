//
//  UserSettingViewController.swift
//  omotenashiApp
//
//

import Foundation
import UIKit
import SDWebImage

extension NSMutableData {
    func appendString(string: String) {
        let data = string.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
        appendData(data!)
    }
}

class UserSettingViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // 共通している画面の要素
    @IBOutlet weak var usernameLabel: UILabel!
    
    // ポイント画面関する要素
    @IBOutlet weak var pointView: UIView!
    @IBOutlet weak var pointLabel: UILabel!
    @IBOutlet weak var userImageLabel: UIImageView!
    
    
    // 設定画面に関する要素
    @IBOutlet weak var settingView: UIView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var languageLabel1: UILabel!
    @IBOutlet weak var languageLabel2: UILabel!
    @IBOutlet weak var sexLabel: UILabel!
    @IBOutlet weak var signoutButton: UIButton!
    
    
    @IBOutlet weak var settingButton: UIButton!
    @IBOutlet weak var pointButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UserDefaultの取得
        let ud = NSUserDefaults.standardUserDefaults()
        let userInfo = ud.objectForKey("userInfo") as? [String: String]
        
        // 画面の更新
        setViewInfoByUserInfo(userInfo!)
        
        
        
        
        // 設定画面を表示する
        pointView.hidden = true
        settingView.hidden = false
        
        // ボタンの装飾
        settingButton.backgroundColor = UIColor(red: CGFloat(156)/255.0, green: CGFloat(141)/255.0, blue: CGFloat(42)/255.0, alpha: 1.0)
        settingButton.layer.cornerRadius = 7
        signoutButton.backgroundColor = UIColor(red: CGFloat(156)/255.0, green: CGFloat(141)/255.0, blue: CGFloat(42)/255.0, alpha: 1.0)
        signoutButton.layer.cornerRadius = 7
        pointButton.backgroundColor = UIColor(red: CGFloat(156)/255.0, green: CGFloat(141)/255.0, blue: CGFloat(42)/255.0, alpha: 1.0)
        pointButton.layer.cornerRadius = 7
        
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        for touch: UITouch in touches {
            let tag = touch.view!.tag
            switch tag {
            case 1:
                self.userImageLabel.alpha = 0.8
            default:
                break
            }
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesEnded(touches, withEvent: event)
        for touch: UITouch in touches {
            let tag = touch.view!.tag
            switch tag {
            case 1:
                self.userImageLabel.alpha = 1.0
                openImagePicker()
            default:
                break
            }
        }
    }
    
    @IBAction func showSettingButton(sender: AnyObject) {
        pointView.hidden = true
        settingView.hidden = false
    }
    
    @IBAction func showPointButton(sender: AnyObject) {
        pointView.hidden = false
        settingView.hidden = true
    }
    
    // ユーザ情報に合わせて画面の表示更新する関数
    func setViewInfoByUserInfo(userInfo: Dictionary<String, String>) {
        self.usernameLabel.text = userInfo["name"]
        self.locationLabel.text = userInfo["nationality"]
        self.sexLabel.text = userInfo["sex"]
        let languages = userInfo["languages"]?.componentsSeparatedByString(",")
        print(userInfo["languages"])
        if (languages?[0] != nil) {
            languageLabel1.text = languages![0]
        }
        if (languages?[1] != nil) {
            languageLabel2.text = languages![1]
        }
        
        let ud = NSUserDefaults.standardUserDefaults()
        let point = ud.objectForKey("point") as! Int
        print(point)
        self.pointLabel.text = String(point)
 
    }
    
    func openImagePicker() {
        var ipc: UIImagePickerController = UIImagePickerController()
        ipc.delegate = self
        UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(ipc, animated:true, completion:nil)
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        // アルバムの画面を閉じる
        picker.dismissViewControllerAnimated(true, completion: nil)
        
        // 画像をリサイズ
        let resizedImage = resize(image, width: 300, height: 500)
        
        // 画像の送信部分
        let myUrl = NSURL(string: "http://omotenashi.prodrb.com/api/img/set_image.php")
        let request = NSMutableURLRequest(URL: myUrl!)
        request.HTTPMethod = "POST"
        
        let ud = NSUserDefaults.standardUserDefaults()
        ud.setObject(true, forKey: "isImg")
        let userInfo = ud.objectForKey("userInfo") as? [String: String]
        let param = [
            "user_id": userInfo!["id"]!
        ]
        
        let boundary = generateBoundaryString()
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        let imageData = UIImageJPEGRepresentation(resizedImage, 1)
        if (imageData == nil) {
            print("image Error")
            return;
        }
        request.HTTPBody = createBodyWithParameters(param, filePathKey: "file", imageDataKey: imageData!, boundary: boundary)
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            if error != nil {
                print("error=\(error)")
                return
            }
            // レスポンスを出力
            let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding) as! String
            dispatch_async(dispatch_get_main_queue(),{
                //self.userImageLabel.sd_setImageWithURL(NSURL(string: "http://omotenashi.prodrb.com/api/img/2"))
                let imgUrl = "http://omotenashi.prodrb.com/api/img/" + responseString
                self.userImageLabel.sd_setImageWithPreviousCachedImageWithURL(NSURL(string: imgUrl), placeholderImage: nil, options: SDWebImageOptions.RefreshCached, progress: nil, completed: nil)
                self.userImageLabel.layer.cornerRadius = 83
                self.userImageLabel.layer.masksToBounds = true
            });
        }
        task.resume()

        
        
        
        
        
    }
    
    func createBodyWithParameters(parameters: [String: String]?, filePathKey: String?, imageDataKey: NSData, boundary: String) -> NSData {
        var body = NSMutableData()
        if parameters != nil {
            for (key, value) in parameters! {
                body.appendString("--\(boundary)\r\n")
                body.appendString("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.appendString("\(value)\r\n")
            }
        }
        let filename = "user-profile.jpg"
        let mimetype = "image/jpg"
        body.appendString("--\(boundary)\r\n")
        body.appendString("Content-Disposition: form-data; name=\"\(filePathKey!)\"; filename=\"\(filename)\"\r\n")
        body.appendString("Content-Type: \(mimetype)\r\n\r\n")
        body.appendData(imageDataKey)
        body.appendString("\r\n")
        body.appendString("--\(boundary)--\r\n")
        return body
    }
    
    func generateBoundaryString() -> String {
        return "Boundary-\(NSUUID().UUIDString)"
    }
    
    func resize(image: UIImage, width: Int, height: Int) -> UIImage {
        let imageRef: CGImageRef = image.CGImage!
        let sourceWidth: Int = CGImageGetWidth(imageRef)
        let sourceHeight: Int = CGImageGetHeight(imageRef)
        
        let size: CGSize = CGSize(width: width, height: height)
        UIGraphicsBeginImageContext(size)
        image.drawInRect(CGRectMake(0, 0, size.width, size.height))
        
        let resizeImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizeImage
    }
    
    
    @IBAction func singOutButton(sender: AnyObject) {
        Authentication.signout()
    }
}
