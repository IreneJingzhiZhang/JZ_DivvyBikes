//
//  LoginViewController.swift
//  testRadioButton
//
//  Created by Jingzhi Zhang on 11/1/17.
//  Copyright © 2017 NIU CS Department. All rights reserved.
//

import UIKit
import CoreData

class LoginViewController: UIViewController {

    @IBOutlet weak var logEmail: UITextField!
    @IBOutlet weak var logPwd: UITextField!
    @IBOutlet weak var newEmail: UITextField!
    @IBOutlet weak var newPwd: UITextField!
    @IBOutlet weak var newConPwd: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        logEmail.clearButtonMode = .always
        logPwd.clearButtonMode = .always
        newEmail.clearButtonMode = .always
        newConPwd.clearButtonMode = .always
        newPwd.clearButtonMode = .always
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func SignIn(_ sender: UIButton) {
        // Read values from text fields
        let userEmail = logEmail.text
        let userPassword = logPwd.text
        
        // Check if required fields are not empty
        if (userEmail?.isEmpty)! || (userPassword?.isEmpty)!
        {
            // Display alert message here
            
            displayMessage(userMessage: "One of the required fields is missing")
            
            return
        }
        else{
            if validateEmail(enteredEmail:userEmail!){
                //Fetch data request
                let request = NSFetchRequest<NSFetchRequestResult>(entityName:"User")
                request.returnsObjectsAsFaults = false
                
                
                //use a loop to fetch all the data
                do{
                    let appDelegate  = UIApplication.shared.delegate as! AppDelegate
                    let context = appDelegate.persistentContainer.viewContext
                    
                    let results = try context.fetch(request)
                    
                        for item in results as! [NSManagedObject]{
                            if (userEmail == item.value(forKey: "email") as? String) && (userPassword == item.value(forKey: "password") as? String){
                                    displayMessage(userMessage: "Successfully signed in.")
                            }
                        }//end the for loop
                }//end the do loop
                catch{
                    print("Fetched Data Error!")
                }
                
                displayMessage(userMessage: "Successfully Registered.")
            }
            else{
                displayMessage(userMessage: "Wrong format for email")
            }
        }
        
    }
    
    @IBAction func SignUp(_ sender: UIButton) {
        let userEmail = newEmail.text;
        let userPassword = newPwd.text;
        let userRepeatPassword = newConPwd.text;
        
        // Check for empty fields
        if((userEmail?.isEmpty)! || (userPassword?.isEmpty)! || (userRepeatPassword?.isEmpty)!)
        {
            
            // Display alert message
            
            displayMessage(userMessage: "All fields are required");
            
            return;
        }
        
        //Check if passwords match
        if(userPassword != userRepeatPassword)
        {
            // Display an alert message
            displayMessage(userMessage: "Passwords do not match");
            return;
            
        }
        else{
            
            if validateEmail(enteredEmail:userEmail!){
                
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let context = appDelegate.persistentContainer.viewContext
                
                let newUser = NSEntityDescription.insertNewObject(forEntityName:"User", into: context)
                newUser.setValue(userEmail,forKey:"email")
                newUser.setValue(userPassword,forKey:"password")
                
                //save the context if no error is catched
                do{
                    try context.save()
                    print("SAVED!")
                }
                catch{
                    print("ERROR!")
                }
                
                displayMessage(userMessage: "Successfully Registered.")

            }
            else{
                displayMessage(userMessage: "Wrong format for email")
            }
        }

    }
    
    func displayMessage(userMessage:String) -> Void {
        DispatchQueue.main.async
            {
                let alertController = UIAlertController(title: "Alert", message: userMessage, preferredStyle: .alert)
                
                let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
                    // Code in this block will trigger when OK button tapped.
                    print("Ok button tapped")
                    DispatchQueue.main.async
                        {
                            self.dismiss(animated: true, completion: nil)
                    }
                }
                alertController.addAction(OKAction)
                self.present(alertController, animated: true, completion:nil)
        }
    }
    
    
    func validateEmail(enteredEmail:String) -> Bool {
        
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: enteredEmail)
        
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


//dismiss the keyboard
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
