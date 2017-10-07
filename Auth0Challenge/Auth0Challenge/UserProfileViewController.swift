//
//  UserProfileViewController.swift
//  Auth0Challenge
//
//  Created by Mohga Nabil on 10/7/17.
//  Copyright © 2017 IBM. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController {

	@IBOutlet weak var userNickName: UILabel!
	
	@IBOutlet weak var userProfilePicture: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		Auth0Services.getInstance().fetchUserInfo { (userProfile) in
			guard userProfile == nil else{
				DispatchQueue.main.async {
					self.userNickName.text = userProfile!.userName!
					guard userProfile!.avatarURL == nil else{
						Auth0Services.getInstance().loadAvatar(imageURLString: userProfile!.avatarURL!){(imageData) in
							if imageData != nil{
								self.userProfilePicture.image = UIImage(data: imageData!)
							}
						}
						return
					}
				}
				
				return
			}
		}
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	@IBAction func logOut(_ sender: UIButton) {
		Auth0Services.getInstance().logOut()
		let story = UIStoryboard(name: "Main", bundle: nil)
		let authViewController = story.instantiateViewController(withIdentifier: "CredentialsForm") as! AuthViewController
		DispatchQueue.main.async {
			self.present(authViewController, animated: true, completion: nil)
		}
	}
}
