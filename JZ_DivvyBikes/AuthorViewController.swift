//
//  AuthorViewController.swift
//  ZhangReader
//
//  Created by Jingzhi Zhang on 9/23/17.
//  Copyright © 2017 NIU CS Department. All rights reserved.
//  Purpose: To show the author's information in a web view


import UIKit

class AuthorViewController: UIViewController {
    
    
    @IBOutlet weak var webView: UIWebView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        // Create a path to the index.html "data" file bundled under the "html" folder
        let path = Bundle.main.path(forResource: "/html/index", ofType: "html")!
        let data: NSData = NSData(contentsOfFile:path)!
        let html = NSString(data: data as Data, encoding:String.Encoding.utf8.rawValue)
        
        // Load the webView outlet with the content of the index.html file
        webView.loadHTMLString(html! as String, baseURL: Bundle.main.bundleURL)
        
        //set the blank between the "name" and navigation bar to not opaque and clear color  and it will be white. you can just set the IB in About Author view
        webView.isOpaque = false
        webView.backgroundColor = UIColor.clear
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

