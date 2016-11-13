//
//  SearchResultViewController.swift
//  omotenashiApp
//
//  Created by sho on 2016/10/25.
//  Copyright © 2016年 TMT. All rights reserved.
//

import UIKit

class SearchResultViewController: UIViewController {
    
    @IBOutlet weak var distanceCircleRotation: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*--------------------------------
         * 距離と方角の円盤を回転させる
         ---------------------------------*/
        //角度計算
        var angle:CGFloat = CGFloat((270.0 * M_PI) / 180.0)
        //回転するためのアフィン変換
        distanceCircleRotation.transform = CGAffineTransformMakeRotation(angle)
        
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

}
