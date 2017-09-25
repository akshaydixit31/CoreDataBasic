//
//  TextFieldValidate.swift
//  CoreDataBasic
//
//  Created by Appinventiv Technologies on 25/09/17.
//  Copyright © 2017 Appinventiv Technologies. All rights reserved.
//

import Foundation
import UIKit


class TextFieldValidate{
    
    func shakeBtn(_ textField: UITextField) {
        
        textField.transform = CGAffineTransform(translationX: 1, y: -5)
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.0,
                       initialSpringVelocity: 6.0,
                       options: .allowUserInteraction,
                       animations: {
                        
                        textField.transform = .identity
                        
        },completion: nil)
    }
    
}

extension String{
    
    func isValid(_ email: String) -> Bool {
        
        let emailRegEx = "(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"+"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"+"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"+"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"+"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"+"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"+"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        
        let emailTest = NSPredicate(format:"SELF MATCHES[c] %@", emailRegEx)
        return emailTest.evaluate(with: email)
        
    }
    
    func validateContact(value: String) -> Bool {
        
        let PHONE_REGEX = "^\\d{3}\\d{3}\\d{4}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: value)
        print(result)
        return result
    
    }
    
}
