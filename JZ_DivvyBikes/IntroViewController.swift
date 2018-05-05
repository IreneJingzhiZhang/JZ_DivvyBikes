//
//  IntroViewController.swift
//  JZ_DivvyBikes
//
//  Created by Jingzhi Zhang on 11/3/17.
//  Copyright © 2017 NIU CS Department. All rights reserved.
//

import UIKit

class IntroViewController: UIViewController {

    @IBOutlet weak var DivvyTextView: UITextView!
    @IBOutlet weak var viewDivvy: UIButton!
    @IBOutlet weak var viewPricing: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //eliminate the blank on top of the text view
        DivvyTextView.textContainerInset = UIEdgeInsets.zero;
        DivvyTextView.textContainer.lineFragmentPadding = 0;
        // Do any additional setup after loading the view.
    }

    
    @IBAction func didTapDivvy(sender: UIButton) {
        if let url = NSURL(string: "https://www.divvybikes.com/how-it-works"){
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func didTapPricing(_ sender: UIButton) {
        if let url = NSURL(string: "https://www.divvybikes.com/pricing"){
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }
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
