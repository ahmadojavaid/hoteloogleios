//
//  ViewController.swift
//  Hoteloogle
//
//  Created by macbook on 21/06/2019.
//  Copyright © 2019 macbook. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate{
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var prView: UIView!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var notInternetVIew: UIView!
    
    
    
    
    var homeAddress = "http://m.hoteloogle.com/?mobile=1"
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
//        NotificationCenter.default.addObserver(self, selector: #selector(refreshTableView), name: NSNotification.Name(rawValue: "reload"), object: nil)
      
        
    }
    
    @objc func refreshTableView ()
    {
        if Reach.isConnectedToNetwork()
        {
            hideNoInternetView()
            loadHomePage()
        }
        else
        {
            showInternetNotConnected()
        }
    }
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        if Reach.isConnectedToNetwork()
        {
            hideNoInternetView()
            loadHomePage()
        }
        else
        {
            showInternetNotConnected()
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress"
        {
            print(Float(webView.estimatedProgress))
            
            let progress = Float(webView.estimatedProgress)
            progressBar.progress = progress
//            progressBar.setProgress(pro, animated: true)
            
            if progress == 1.0
            {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5)
                {
                    UIView.transition(with: self.view, duration: 0.5, options: .transitionCrossDissolve, animations: {
                        self.prView.isHidden = true
                    })
                    
                }
                
            }
            else
            {
                prView.isHidden = false
            }
            
            
        }
    }
    
    @IBAction func homeBtn(_ sender: Any)
    {
        if Reach.isConnectedToNetwork()
        {
            hideNoInternetView()
            loadHomePage()
        }
        else
        {
            showInternetNotConnected()
        }
        
        
    }
    @IBAction func reloadBtn(_ sender: Any)
    {
        if Reach.isConnectedToNetwork()
        {
            hideNoInternetView()
            webView.reload()
        }
        else
        {
            showInternetNotConnected()
        }
    }
    
    @IBAction func backBtnPreseed(_ sender: Any)
    {
        if Reach.isConnectedToNetwork()
        {
            hideNoInternetView()
            webView.goBack()
        }
        else
        {
            showInternetNotConnected()
        }
    }
    func loadHomePage()
    {
        
        
        
        
        let preferences = WKPreferences()
        preferences.javaScriptEnabled = true
        let configuration = WKWebViewConfiguration()
        configuration.preferences = preferences
        let url = URL(string: homeAddress)
        let request = URLRequest(url: url!)
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        
        webView.configuration.preferences.javaScriptEnabled = true
        webView.load(request)
    }
    func showInternetNotConnected()
    {
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5)
//        {
//            UIView.transition(with: self.view, duration: 0.5, options: .transitionCrossDissolve, animations: {
//                self.notInternetVIew.isHidden = false
//            })
//
//        }
        
        let alert = UIAlertView()
        alert.title = "Alert"
        alert.message = "Please connect to internet and try again"
        alert.addButton(withTitle: "Ok")
        alert.show()
    }

    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void)
    {
        
        if !(navigationAction.targetFrame != nil)
        {
            self.webView.load(navigationAction.request)
        }
        
        
        
        decisionHandler(WKNavigationActionPolicy(rawValue: WKNavigationActionPolicy.allow.rawValue + 2)!)
    }
    
    
    func hideNoInternetView()
    {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5)
        {
            UIView.transition(with: self.view, duration: 0.5, options: .transitionCrossDissolve, animations: {
                self.notInternetVIew.isHidden = true
            })
            
        }
    }
}

