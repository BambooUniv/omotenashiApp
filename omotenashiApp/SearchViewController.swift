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
        
        /*---------------------
         * くるくる回って人のイラストの周りを回転するものを作成
         *----------------------*/
        //円のCALayerを作成
//        let ovalShapeLayer = CAShapeLayer()
//        ovalShapeLayer.strokeColor = UIColor.blueColor().CGColor   //輪郭は青色
//        ovalShapeLayer.fillColor = UIColor.whiteColor().CGColor    //図形の中の色は白色
//        ovalShapeLayer.lineWidth = 5.0                             //輪郭の線の太さは5.0pt
//        ovalShapeLayer.lineDashPattern = [2,3]
//        //図形は円形
//        ovalShapeLayer.path = UIBezierPath(ovalInRect: CGRect(x: view.bounds.size.width/2, y: view.bounds.size.height/2, width: 100.0, height: 100.0)).CGPath
//        //作成したCALayerを画面に追加
//        view.layer.addSublayer(ovalShapeLayer)
//        //輪郭の線をアニメーションする
//        let strokeStartAnimation = CABasicAnimation(keyPath: "strokeStart")
//        strokeStartAnimation.fromValue = -0.5
//        strokeStartAnimation.toValue = 1.0
//        
//        let strokeEndAnimation = CABasicAnimation(keyPath: "strokeEnd")
//        strokeEndAnimation.fromValue = 0.0
//        strokeEndAnimation.toValue = 1.0
//        
//        let strokeAnimationGroup = CAAnimationGroup()
//        strokeAnimationGroup.duration = 1.5
//        strokeAnimationGroup.repeatDuration = CFTimeInterval.infinity
//        strokeAnimationGroup.animations = [strokeStartAnimation, strokeEndAnimation]
//        ovalShapeLayer.addAnimation(strokeAnimationGroup, forKey: nil)
        
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
