//
//  ContactViewController.swift
//  JZ_DivvyBikes
//
//  Created by Jingzhi Zhang on 11/4/17.
//  Copyright © 2017 NIU CS Department. All rights reserved.
//

import UIKit
import MessageUI

class ContactViewController: UIViewController, MFMailComposeViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //make a phone call on device
    @IBAction func callBtnClicked(_ sender: UIButton) {
        //remove the space in the phone number string to avoid unwrapped optionals
        let phonenumber = "1-855-553-4889"
        let myURL:NSURL = (URL(string: "tel://\(phonenumber)") as NSURL?)!
        let application:UIApplication = UIApplication.shared
        if (application.canOpenURL(myURL as URL)) {
            UIApplication.shared.open(myURL as URL, options: [:], completionHandler: nil)
        }
    }
    
    // send an e-mail
    @IBAction func MIEmailBtnClicked(_ sender: UIButton) {
        sendEmail(emailString: "media@divvybikes.com", titleString: "Media inquires and reuests")
    }
    
    @IBAction func SOEmailBtnClicked(_ sender: UIButton) {
        sendEmail(emailString: "sponsorships@divvybikes.com", titleString: "Sponsorship inquiries and requests")
    }
    
    @IBAction func CPEmailBtnClicked(_ sender: UIButton) {
        sendEmail(emailString: "corporate@divvybikes.com", titleString: "Interested in joining Corporate Program")
    }
    
    @IBAction func didTapDivvy(sender: UIButton) {
        if let url = NSURL(string: "https://www.divvybikes.com/careers"){
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }
    }
    
    //Send an email
    func sendEmail(emailString: String, titleString: String){
        // Create a mail composer using the MFMailComposeViewController class
        // and assign it as a delegate
        let mailComposeVC = MFMailComposeViewController()
        mailComposeVC.mailComposeDelegate = self
        let toRecipents = [emailString]
        let emailTitle = titleString
        
        mailComposeVC.setToRecipients(toRecipents as [String])
        mailComposeVC.setSubject(emailTitle)
        
        // If MFMailComposer can send mail, then present the populated
        // mail composer view controller.
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposeVC, animated: true, completion: nil)
        }
        else {
            print("Cannot send an email!")
        }

    }
    
    // This is the MFMailComposerViewController delegate method.
    // When it finishes sending mail, dismiss the view controller.
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        self.dismiss(animated: true, completion: nil)
        
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
