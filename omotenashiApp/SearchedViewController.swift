//
//  SearchedViewController.swift
//  omotenashiApp
//
//

import Foundation
import UIKit

class SeachedViewController :UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var omotenashiButton: UIButton!
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewDidDisappear(animated)
        let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let userInfo = appDelegate.requestId?.componentsSeparatedByString(",")
        self.nameLabel!.text = userInfo![1]
        NSTimer.scheduledTimerWithTimeInterval(5.0, target: self, selector: #selector(self.onTimer(_:)), userInfo: userInfo![0], repeats: true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ボタンの装飾
        omotenashiButton.backgroundColor = UIColor(red: CGFloat(156)/255.0, green: CGFloat(141)/255.0, blue: CGFloat(42)/255.0, alpha: 1.0)
        omotenashiButton.layer.cornerRadius = 7
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func onTimer(sender: NSTimer) {
        Help.getDistanceFromServer(String(sender.userInfo!), completionHander: {(distance: String) -> Void in
            self.distanceLabel.text = distance
        })
    }
    
    @IBAction func didOmotenashi(sender: AnyObject) {
        let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let userInfo = appDelegate.requestId?.componentsSeparatedByString(",")
        print(userInfo![0])
        Help.didOmotenashi(userInfo![0])
    }
    
}
