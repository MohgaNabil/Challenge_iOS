//
//  ViewController.swift
//  Auth0Challenge
//
//  Created by Mohga Nabil on 10/6/17.
//  Copyright © 2017 IBM. All rights reserved.
//

import UIKit

class AuthViewController: UIViewController {
	
	@IBOutlet weak var email: UITextView!
	@IBOutlet weak var passowrd: UITextView!
	@IBOutlet weak var registerBtn: UIButton!
	@IBOutlet weak var loginBtn: UIButton!
	
	@IBAction func register(_ sender: UIButton) {
		if let err = self.validateUserName(){
			self.displayAlerts(err: err)
		}else if let err = self.validatePassword(){
			self.displayAlerts(err: err)
		}else{
			Auth0Services.getInstance().signUp(email: email.text, password: passowrd.text) { (success,err) in
				if success{
					self.displayAlerts(err: ErrorConstants.USER_REGISTERED)
				}else{
					self.displayAlerts(err: err!)
				}
			}
		}
	}
	
	
	@IBAction func login(_ sender: UIButton) {
		if let err = self.validateUserName(){
			self.displayAlerts(err: err)
		}else if let err = self.validatePassword(){
			self.displayAlerts(err: err)
		}else{
			Auth0Services.getInstance().signIn(email: email.text, password: passowrd.text) { (success,err) in
				if success{
					let story = UIStoryboard(name: "Main", bundle: nil)
					let userProfileViewController = story.instantiateViewController(withIdentifier: "Userprofile") as! UserProfileViewController
					DispatchQueue.main.async {
						self.present(userProfileViewController, animated: true, completion: nil)
					}
					
				}else{
					self.displayAlerts(err: err!)
				}
			}
		}
	}
	
	func validateUserName()-> ErrorConstants?{
		guard self.email.text != nil && !self.email.text.isEmpty else {
			return .EMTPY_USERNAME
		}
		return nil
	}
	
	func validatePassword()->ErrorConstants?{
		guard self.passowrd.text != nil && !self.passowrd.text.isEmpty else{
			return .EMPTY_PASSWORD
		}
		
		guard self.passowrd.text.characters.count >= 6  else {
			return .SHORT_PASSWORD
		}
		return nil
	}
	
	func displayAlerts(err:ErrorConstants) {
		DispatchQueue.main.async {
			let errMsg = NSLocalizedString(err.rawValue, comment: "")
			let alertVC = UIAlertController(title: "iOS Challenge", message: errMsg, preferredStyle: .alert)
			alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
			self.present(alertVC, animated: true, completion: nil)
		}
	}
}

