//
//  pointViewController.swift
//  omotenashiApp
//
//  Created by 竹之下遼 on 2016/11/17.
//  Copyright © 2016年 TMT. All rights reserved.
//

import Foundation
import UIKit

class PointViewController: UIViewController {
    
    @IBOutlet weak var pointLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var buyButton: UIButton!
    
    @IBOutlet weak var img1: UIImageView!
    @IBOutlet weak var img2: UIImageView!
    @IBOutlet weak var img3: UIImageView!
    @IBOutlet weak var img4: UIImageView!
    @IBOutlet weak var img5: UIImageView!
    @IBOutlet weak var img6: UIImageView!
    @IBOutlet weak var img7: UIImageView!
    @IBOutlet weak var img8: UIImageView!
    
    @IBOutlet weak var price1: UILabel!
    @IBOutlet weak var price2: UILabel!
    @IBOutlet weak var price3: UILabel!
    @IBOutlet weak var price4: UILabel!
    @IBOutlet weak var price5: UILabel!
    @IBOutlet weak var price6: UILabel!
    @IBOutlet weak var price7: UILabel!
    @IBOutlet weak var price8: UILabel!
    
    var point :Int = 0
    
    
    @IBAction func img1Button(sender: AnyObject) {
        showAlert(self.price1)
    }

    @IBAction func img2Button(sender: AnyObject) {
        showAlert(self.price2)
    }
    
    @IBAction func img3Button(sender: AnyObject) {
        showAlert(self.price3)
    }
    
    @IBAction func img4Button(sender: AnyObject) {
        showAlert(self.price4)
    }
    @IBAction func img5Button(sender: AnyObject) {
        showAlert(self.price5)
    }
    @IBAction func img6Button(sender: AnyObject) {
        showAlert(self.price6)
    }
    @IBAction func img7Button(sender: AnyObject) {
        showAlert(self.price7)
    }
    @IBAction func img8Button(sender: AnyObject) {
        showAlert(self.price8)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.contentSize = CGSize(width: 300, height: 1000)
        
        let ud = NSUserDefaults.standardUserDefaults()
        ud.setObject(800, forKey: "point")
        ud.synchronize()
        print(point)
        point = ud.objectForKey("point") as! Int
        self.pointLabel.text = String(point)
        
        cancelButton.backgroundColor = UIColor(red: CGFloat(156)/255.0, green: CGFloat(141)/255.0, blue: CGFloat(42)/255.0, alpha: 1.0)
        cancelButton.layer.cornerRadius = 7
        buyButton.backgroundColor = UIColor(red: CGFloat(156)/255.0, green: CGFloat(141)/255.0, blue: CGFloat(42)/255.0, alpha: 1.0)
        buyButton.layer.cornerRadius = 7
    }
    
    
    func showAlert(label: UILabel) {
        let alert: UIAlertController = UIAlertController(title: "交換の確認", message: "200ポイントと商品を交換しますか？", preferredStyle:  UIAlertControllerStyle.Alert)
        
        let defaultAction: UIAlertAction = UIAlertAction(title: "交換する", style: UIAlertActionStyle.Default, handler:{
            // ボタンが押された時の処理を書く（クロージャ実装）
            (action: UIAlertAction!) -> Void in
            let priceStr = label.text?.substringToIndex(label.text!.startIndex.advancedBy(3))
            
            self.point = self.point - Int(priceStr!)!
            self.pointLabel.text = String(self.point)
        })
        
        // キャンセルボタン
        let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: UIAlertActionStyle.Cancel, handler:{
            // ボタンが押された時の処理を書く（クロージャ実装）
            (action: UIAlertAction!) -> Void in
            
            print("Cancel")
        })
        
        alert.addAction(cancelAction)
        alert.addAction(defaultAction)
        
        // ④ Alertを表示
        presentViewController(alert, animated: true, completion: nil)

    }
    
    @IBAction func pushBuy(sender: AnyObject) {
    }
    
    
}
