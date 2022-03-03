//
//  ViewDocViewC.swift
//  Max
//
//  Created by aravind  yadav on 01/02/22.
//

import UIKit
import WebKit

class ViewDocViewC: UIViewController,UIWebViewDelegate, WKUIDelegate {

    @IBOutlet weak var imgDoc: UIImageView!
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var webview:WKWebView!
    var strUrl = ""
    override func viewDidLoad() {
        super.viewDidLoad()
      

        let myURL = URL(string:strUrl)
        let myRequest = URLRequest(url: myURL!)
        webview.load(myRequest)
        
    }
    
    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
