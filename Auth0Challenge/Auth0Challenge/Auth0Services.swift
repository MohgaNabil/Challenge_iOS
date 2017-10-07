//
//  Auth0Services.swift
//  Auth0Challenge
//
//  Created by Mohga Nabil on 10/6/17.
//  Copyright © 2017 IBM. All rights reserved.
//

import Foundation

class Auth0Services {
	
	private var token:String?
	private var domain:String?
	private var clientId:String?
	private var connection:String?
	private var configurations:NSDictionary?
	private static var instance:Auth0Services?
	public static func getInstance() -> Auth0Services{
		guard instance != nil else {
			instance = Auth0Services()
			return instance!
		}
		return instance!
	}
	init() {
		if let configurations = self.loadBundle(){
			self.configurations = configurations
			self.domain = configurations["Domain"] as? String
			self.connection = configurations["Connection"] as? String
			self.clientId = configurations["ClientId"] as? String
		}
	}
	public func signIn(email:String, password:String,completionHandler:@escaping (_ sucess:Bool)->Void){
		if self.configurations != nil && self.domain != nil && clientId != nil && self.connection != nil{
			if let loginURI = self.configurations!["LoginURI"]{
				if let serviceURL = URL(string: "https://\(self.domain!)\(loginURI)"){
					var request = URLRequest(url: serviceURL)
					request.httpMethod = "POST"
					request.setValue("application/json", forHTTPHeaderField: "Content-Type")
					request.setValue("application/json", forHTTPHeaderField: "Accept-Charset")
					let requestBody = ["client_id": self.clientId!,"connection":self.connection!,"grant_type":"password","scope":"openid","username":email,"password":password]
					if JSONSerialization.isValidJSONObject(requestBody){
						if let jsonData = try? JSONSerialization.data(withJSONObject: requestBody, options: .prettyPrinted){
							request.httpBody = jsonData
							let theJSONText = String(data: jsonData,
							                         encoding: .ascii)
							print("response:\(theJSONText!)")
						}
						let session = URLSession(configuration:.default)
						let task = session.dataTask(with: request, completionHandler: { (data, response, error) in
							if error == nil && data != nil{
								if let jsonResult = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as? NSDictionary{
									if jsonResult?["error"] != nil{
										completionHandler(false)
									}else{
										self.token = jsonResult?["id_token"] as? String
										completionHandler(true)

									}
								}else{
									completionHandler(false)
								}
							}else{
								completionHandler(false)
							}
						})
						task.resume()
					}else{
						completionHandler(false)
					}
				}else{
					completionHandler(false)
				}
			}else{
				completionHandler(false)
			}
			
		}else{
			completionHandler(false)
		}
	}
	
	public func signUp(email:String, password:String,completionHandler:@escaping (_ sucess:Bool)->Void){
		if self.configurations != nil && self.domain != nil && clientId != nil && self.connection != nil{
			if let signUpURI = self.configurations!["SignUpURI"]{
				if let serviceURL = URL(string: "https://\(self.domain!)\(signUpURI)"){
					var request = URLRequest(url: serviceURL)
					request.httpMethod = "POST"
					request.setValue("application/json", forHTTPHeaderField: "Content-Type")
					request.setValue("application/json", forHTTPHeaderField: "Accept-Charset")

					let requestBody = ["client_id":self.clientId!,"connection":self.connection!,"email":email,"password":password]
					if JSONSerialization.isValidJSONObject(requestBody){
						if let jsonData = try? JSONSerialization.data(withJSONObject: requestBody, options: .prettyPrinted){
							request.httpBody = jsonData
							let theJSONText = String(data: jsonData,
													 encoding: .ascii)
							print("response:\(theJSONText!)")
						}
						let session = URLSession(configuration:.default)
						let task = session.dataTask(with: request, completionHandler: { (data, response, error) in
							if error == nil{
								if let jsonResult = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as? NSDictionary{
									if jsonResult?["error"] != nil{
										completionHandler(false)
									}else{
										completionHandler(true)
										
									}
								}else{
									completionHandler(false)
								}
							}else{
								completionHandler(false)
							}
						})
						task.resume()
					}else{
						completionHandler(false)
					}
				}else{
					completionHandler(false)
				}
			}else{
				completionHandler(false)
			}
			
		}else{
			completionHandler(false)
		}
	}
	
	public func fetchUserInfo(completionHandler:@escaping (_ userInfo:UserProfile?)->Void){
		if self.configurations != nil && self.domain != nil && self.token != nil{
			if let userProfileURI = self.configurations!["UserProfileURI"]{
				if let serviceURL = URL(string: "https://\(self.domain!)\(userProfileURI)"){
					var request = URLRequest(url: serviceURL)
					request.httpMethod = "POST"
					request.setValue("application/json", forHTTPHeaderField: "Content-Type")
					request.setValue("application/json", forHTTPHeaderField: "Accept-Charset")
					let requestBody = ["id_token":self.token!]
					if JSONSerialization.isValidJSONObject(requestBody){
						if let jsonData = try? JSONSerialization.data(withJSONObject: requestBody, options: .prettyPrinted){
							request.httpBody = jsonData
							let theJSONText = String(data: jsonData,
													 encoding: .ascii)
							print("response:\(theJSONText!)")
						}

						let session = URLSession(configuration:.default)
						let task = session.dataTask(with: request, completionHandler: { (data, response, error) in
							if error == nil && data != nil{
								if let jsonResult = try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary{
									let userProfileData = UserProfile()
									userProfileData.userName = jsonResult["nickname"] as? String
									userProfileData.avatarURL = jsonResult["picture"] as? String
									completionHandler(userProfileData)
								}else{
									completionHandler(nil)
								}
							}else{
								completionHandler(nil)
							}
						})
						task.resume()
					}else{
						completionHandler(nil)
					}
				}else{
					completionHandler(nil)
				}
			}else{
				completionHandler(nil)
			}
			
		}else{
			completionHandler(nil)
		}
	}
	
	public func logOut(){
		//To-Do revoke token
	}
	
	public func loadAvatar(imageURLString:String,completionHandler:@escaping (_ imageData:Data?)->Void){
		if let imageURL = URL(string: imageURLString){
			var request = URLRequest(url: imageURL)
			request.httpMethod = "GET"
			let session = URLSession(configuration:.default)
			let task = session.dataTask(with: request, completionHandler: { (data, response, error) in
				if error == nil && data != nil{
					completionHandler(data!)
				}else{
					completionHandler(nil)
				}
			})
			task.resume()
		}else{
			completionHandler(nil)
		}
	}
	
	private func loadBundle() -> NSDictionary?{
		guard let path = Bundle.main.path(forResource: "Auth0", ofType: "plist") else { return nil }
		guard let content = NSDictionary(contentsOfFile: path) else{
			return nil
		}
		return content
	}
}
