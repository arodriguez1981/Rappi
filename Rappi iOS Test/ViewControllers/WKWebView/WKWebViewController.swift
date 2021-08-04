//
//  WKWebView.swift
//  
//
//  Created by Alex Rodriguez on 02/08/21.
//

import Foundation
import WebKit

protocol closeWebViewDelegate{
    func close(_ requestToken : String)
}

class WKWebViewController: UIViewController, WKUIDelegate, WKNavigationDelegate {
    var closeDelegate: closeWebViewDelegate?
    var webView: WKWebView!
    var requestToken: String!
    var titulo: String!
    
    var urlToLoad : String!
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if titulo != nil {
            self.navigationItem.title = titulo
        }
        
        //UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        if requestToken != "" {
            let approveURL = "https://www.themoviedb.org/auth/access?request_token=\(requestToken!)"
            if let url = URL(string: "\(approveURL)"), !url.absoluteString.isEmpty {
                let request = URLRequest(url: url)
                webView.load(request)
            }
        }
        
        let closeButton = UIBarButtonItem(title: "Cerrar", style: .plain, target: self, action: #selector(self.dismissWebView))
        self.navigationItem.leftBarButtonItem = closeButton
        webView.allowsBackForwardNavigationGestures = true
    }
    
    @objc func dismissWebView() {
        self.dismiss(animated: true, completion: nil)
        self.closeDelegate?.close(self.requestToken)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        //UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
}
