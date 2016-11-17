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
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewDidDisappear(animated)
        let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let userInfo = appDelegate.requestId?.componentsSeparatedByString(",")
        self.nameLabel!.text = userInfo![1]
        NSTimer.scheduledTimerWithTimeInterval(5.0, target: self, selector: #selector(self.onTimer(_:)), userInfo: userInfo![0], repeats: true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func onTimer(sender: NSTimer) {
        Help.getDistanceFromServer(String(sender.userInfo), completionHander: {(distance: String) -> Void in
            self.distanceLabel.text = distance
        })
    }
    
    
}
