//
//  ViewController.swift
//  JZ_DivvyBikes
//
//  Created by Jingzhi Zhang on 10/29/17.
//  Copyright © 2017 NIU CS Department. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Create the info button
        let infoButton = UIButton(type: .infoLight)
        infoButton.addTarget(self, action: #selector(buttonTapped(_sender:)), for: .touchUpInside)
        self.view.addSubview(infoButton)
        
 /*
        //set a
        let PictureURL = URL(string: largeString)!
        let pictureData = NSData(contentsOf: PictureURL as URL)
        let ePicture = UIImage(data:pictureData! as Data)
        employeePicture.image = ePicture
        
        /*display images based on the timer*/
        updateCounter = 0;
        timer = Timer.scheduledTimer(timeInterval: 2.5, target:self, selector:#selector(DetailView.updateTimer), userInfo:nil, repeats:true)
*/
        
    }
    
    /*
     
     
     
     //show different images
     internal func updateTimer()
     {
        updateCounter = (updateCounter+1)%3
        pageControl.currentPage = updateCounter
        switch (updateCounter){
            case 0: pickImage(imageString: largeString)
            case 1: pickImage(imageString: mediumString)
            case 2: pickImage(imageString: thumbnailString)
            default: break 
            }
     }
     
     func pickImage(imageString: String) {
        let PictureURL = URL(string: imageString)!
        let pictureData = NSData(contentsOf: PictureURL as URL)
        let ePicture = UIImage(data:pictureData! as Data)
        employeePicture.image = ePicture
     }
     

     
     
     
     */
    
    
    
    
    
    
    /*
     This function presents a view controller when button is pressed
     */
    @objc func buttonTapped(_sender: UIButton) {
        
        //Present About view controller
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "AboutAppNavigationController") as! UINavigationController
        self.present(controller, animated: true, completion: nil)
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

