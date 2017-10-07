//
//  Auth0ChallengeTests.swift
//  Auth0ChallengeTests
//
//  Created by Mohga Nabil on 10/6/17.
//  Copyright © 2017 IBM. All rights reserved.
//

import XCTest
@testable import Auth0Challenge

class Auth0ChallengeTests: XCTestCase {
	
	var authViewController:AuthViewController! = nil
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
		authViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CredentialsForm") as! AuthViewController
		authViewController.email = UITextView()
		authViewController.passowrd = UITextView()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testUserNameIsEmpty() {
		authViewController.email.text = "mohga.mkamel@gmail.com"
		XCTAssertNil(authViewController.validateUserName(), "Username is not empty nor nil")
		
    }
	func testPasswordIsEmpty() {
		authViewController.passowrd.text = "Yujin@123"
		XCTAssertNil(authViewController.validatePassword(), "Password is not empty nor nil")
	}
	func testPasswordLegnth() {
		authViewController.passowrd.text = "Yuji"
		XCTAssertNotNil(authViewController.validatePassword(), "Password is < 6 chars")
	}
	func testSignIn(){
		authViewController.email.text = "mohga.mkamel@gmail.com"
		authViewController.passowrd.text = "Yujin@123"
		Auth0Services.getInstance().signIn(email: authViewController.email.text, password: authViewController.passowrd.text) { (success, err) in
			XCTAssertNil((err == nil && success), "Sucessfully logged in")
		}
		
	}
	func testSignup(){
		authViewController.email.text = "mohga.mkamel@gmail.com"
		authViewController.passowrd.text = "Yujin@123"
		Auth0Services.getInstance().signUp(email: authViewController.email.text, password: authViewController.passowrd.text) { (success, err) in
			XCTAssertNotNil((err != nil && !success), "User already signed up")
		}
		
	}
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
