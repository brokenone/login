//
//  Utilities.swift
//  Teacher
//
//  Created by Hrayr on 4/30/19.
//  Copyright © 2019 Hrayr. All rights reserved.
//

import UIKit

class Utilities: Any {
    
   class func isValidEmail (emailID:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@",emailRegEx)
        return emailTest.evaluate(with: emailID)
    }
}
