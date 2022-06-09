//
//  TermsOfServiceViewController.swift
//  HomeStay
//
//  Created by Apple7 on 20/02/21.
//  Copyright © 2021 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit
import WebKit

class TermsOfServiceViewController: BaseViewController,WKNavigationDelegate ,WKUIDelegate{

    
    @IBOutlet weak var HeaderLbl: UILabel!

    @IBOutlet weak var webView: WKWebView!

    var ComingType = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        displayWebPage()
        webView.navigationDelegate = self
        webView.uiDelegate = self


        // Do any additional setup after loading the view.
    }
    @IBAction func act_Back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    private func displayWebPage() {
        self.showActivityIndicator(uiView: self.view)
        if self.ComingType == "Terms"{
            self.HeaderLbl.text = "Terms"
            let url = URL(string: TERMS)
            let request = URLRequest(url: url!)
            webView.navigationDelegate = self
            webView.load(request)
        }else{
            self.HeaderLbl.text = "Privacy policy"

            let url = URL(string: PRIVACYPOLICY)
            let request = URLRequest(url: url!)
            webView.navigationDelegate = self
            webView.load(request)
        }
            
        }
        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            print(error)
            self.hideActivityIndicator(uiView: self.view)

        }
  
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.hideActivityIndicator(uiView: self.view)
        }
   

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
