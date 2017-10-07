//
//  ErrorConstants.swift
//  Auth0Challenge
//
//  Created by Mohga Nabil on 10/7/17.
//  Copyright © 2017 IBM. All rights reserved.
//

import Foundation

enum ErrorConstants:String {
	case EMTPY_USERNAME = "EMTPY_USERNAME"
	case EMPTY_PASSWORD = "EMPTY_PASSWORD"
	case SHORT_PASSWORD = "SHORT_PASSWORD"
	case USER_EXISTS = "USER_EXISTS"
	case USER_NOT_REGISTERED = "USER_NOT_REGISTERED"
	case USER_REGISTERED = "USER_REGISTERED"
	case INTERNAL_SERVER_ERROR = "INTERNAL_SERVER_ERROR"
}
