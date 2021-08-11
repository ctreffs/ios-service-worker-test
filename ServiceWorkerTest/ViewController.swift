//
//  ViewController.swift
//  ServiceWorkerTest
//
//  Created by Christian Treffs on 11.08.21.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    
    lazy var webView = WKWebView()
    
    lazy var checkServiceWorkerSupport: WKUserScript = {
        // https://gist.github.com/tiffanytse/863ceededcd3010085b5c1eea7206dd7
        let source: String = """
        if ('serviceWorker' in navigator) {
          // check to see if service worker API exists
          window.addEventListener('load', function() {
            navigator.serviceWorker.register('/sw.js').then(function(registration) {
              // registration was successful
              console.log('ServiceWorker registration successful with scope: ', registration.scope);
            }).catch(function(err) {
              // registration failed :(
              console.log('ServiceWorker registration failed: ', err);
            });
          });
        } else {
            console.error("no 'serviceWorker' in navigator");
            console.log(navigator);
        }
        """
       
        return WKUserScript(source: source,
                     injectionTime: .atDocumentStart,
                     forMainFrameOnly: false)
    
    }()

    override func loadView() {
        self.view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://googlechrome.github.io/samples/service-worker/registration-events/")!
        let req = URLRequest(url: url)
        webView.configuration.userContentController.addUserScript(checkServiceWorkerSupport)
        webView.load(req)
    }

    

}

