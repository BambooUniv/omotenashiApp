//
//  MainViewController.swift
//  omotenashiApp
//
//  Created by sho on 2016/10/25.
//  Copyright © 2016年 TMT. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

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

  @IBAction func locationButton(sender: AnyObject) {
    print("location")
  }
  @IBAction func toiletButton(sender: AnyObject) {
    print("location")
  }
  @IBAction func sickButton(sender: AnyObject) {
    print("location")
  }
  @IBAction func mealButton(sender: AnyObject) {
    print("location")
  }
}
