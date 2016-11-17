//
//  SearchViewController.swift
//  omotenashiApp
//
//  Created by sho on 2016/10/25.
//  Copyright © 2016年 TMT. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var spinningView: SpinningView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 自分のリクエストが承認されたか確認するタイマーを設定
        NSTimer.scheduledTimerWithTimeInterval(5.0, target: self, selector: #selector(self.onTimer(_:)), userInfo: nil, repeats: true)

        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func onTimer(sender: NSTimer) {
        let userDefault = NSUserDefaults.standardUserDefaults()
        let userInfo = userDefault.objectForKey("userInfo") as! Dictionary<String, String>
        let requestId = userInfo["id"]!
        Help.confirmedHelpRequest(requestId, completionHandler: {(result: String)->Void in
            if (result != "false") {
                
                var appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                appDelegate.requestId = result
                
                let storyboard: UIStoryboard = self.storyboard!
                let nextView = storyboard.instantiateViewControllerWithIdentifier("Seached") as! SeachedViewController
                self.presentViewController(nextView, animated: true, completion: nil)
            }
        })
    }
    
    override func viewDidAppear(animated: Bool) {
        self.spinningView.updateAnimation()
    }
    
    
    @IBAction func moveSearchResult(sender: AnyObject) {
        //探索結果画面へ遷移
        let storyboard: UIStoryboard = self.storyboard!
        let nextView = storyboard.instantiateViewControllerWithIdentifier("SearchResult") as! SearchResultViewController
        self.presentViewController(nextView, animated: true, completion: nil)
    }

}
