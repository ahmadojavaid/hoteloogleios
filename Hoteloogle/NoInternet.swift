
//
//  NoInternet.swift
//  Hoteloogle
//
//  Created by macbook on 26/06/2019.
//  Copyright © 2019 macbook. All rights reserved.
//

import UIKit

class NoInternet: UIViewController {
    var gameTimer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: true)
        
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @objc func runTimedCode()
    {
        print("timer...")
        if Reach.isConnectedToNetwork()
        {
            
            gameTimer?.invalidate()
            AppDelegate.shared().checkNet()
        }
        
    }
    
    @IBAction func retryBtn(_ sender: Any)
    {
         AppDelegate.shared().checkNet()
    }
}
