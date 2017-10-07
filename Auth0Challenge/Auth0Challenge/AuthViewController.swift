//
//  ViewController.swift
//  Auth0Challenge
//
//  Created by Mohga Nabil on 10/6/17.
//  Copyright © 2017 IBM. All rights reserved.
//

import UIKit
enum ErrorConstants:String {
	case EMTPY_USERNAME = "EMTPY_USERNAME"
	case EMPTY_PASSWORD = "EMPTY_PASSWORD"
	case SHORT_PASSWORD = "SHORT_PASSWORD"
	case USER_EXISTS = "USER_EXISTS"
}
class AuthViewController: UIViewController {
	
	@IBOutlet weak var email: UITextView!
	@IBOutlet weak var passowrd: UITextView!
	@IBOutlet weak var registerBtn: UIButton!
	@IBOutlet weak var loginBtn: UIButton!
	
	@IBAction func register(_ sender: UIButton) {
		if let err = self.validateCredentials(){
			self.displayAlerts(err: err)
		}else{
			Auth0Services.getInstance().signUp(email: email.text, password: passowrd.text) { (success) in
				if success{
					//To-do: navigate to user profile
				}else{
					//To-do: Display alert
				}
			}
		}
	}
	
	
	@IBAction func login(_ sender: UIButton) {
		if let err = self.validateCredentials(){
			self.displayAlerts(err: err)
		}else{
			Auth0Services.getInstance().signIn(email: email.text, password: passowrd.text) { (success) in
				if success{
					let story = UIStoryboard(name: "Main", bundle: nil)
					let userProfileViewController = story.instantiateViewController(withIdentifier: "Userprofile") as! UserProfileViewController
					DispatchQueue.main.async {
						self.present(userProfileViewController, animated: true, completion: nil)
					}
					
				}else{
					//To-do: Display alert
				}
			}
		}
	}
	
	func validateCredentials()-> ErrorConstants?{
		guard self.email.text != nil && !self.email.text.isEmpty else {
			return .EMTPY_USERNAME
		}
		
		guard self.passowrd.text != nil && !self.passowrd.text.isEmpty else{
			return .EMPTY_PASSWORD
		}
		
		guard self.passowrd.text.characters.count >= 6  else {
			return .SHORT_PASSWORD
		}
		return nil
	}
	
	func displayAlerts(err:ErrorConstants) {
		let errMsg = NSLocalizedString(err.rawValue, comment: "")
		let alertVC = UIAlertController(title: "Error", message: errMsg, preferredStyle: .alert)
		alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
		self.present(alertVC, animated: true, completion: nil)
	}
}

