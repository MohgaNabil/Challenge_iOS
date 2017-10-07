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
		Auth0Services.getInstance().signUp(email: email.text, password: passowrd.text) { (success) in
			if success{
				//To-do: navigate to user profile
			}else{
				//To-do: Display alert
			}
		}
	}
	

	@IBAction func login(_ sender: UIButton) {
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

