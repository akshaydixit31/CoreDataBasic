//
//  AddDataVc.swift
//  CoreDataBasic
//
//  Created by Appinventiv Technologies on 20/09/17.
//  Copyright © 2017 Appinventiv Technologies. All rights reserved.
//

import UIKit
import CoreData

class AddDataVc: UIViewController {
    //-------- Outlet's -------------
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var dobTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var contactTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    
    
    //---------- variable's ---------
    var person: Person?
    var enterData = [String:String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contactTextField.delegate = self
        
        let datePicker = UIDatePicker()
        datePicker.addTarget(self,
                             action: #selector(AddDataVc.datePickerAction(_:)),
                             for: .valueChanged)
        dobTextField.inputView = datePicker
        
        if let s = person {
            
            nameTextField.text = s.name
            emailTextField.text = s.email
            //              dobTextField.text = s.dob
            contactTextField.text = s.contact
            cityTextField.text = s.city
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>,
                               with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        self.view.endEditing(true)
        
    }
    
    @IBAction func saveButton(_ sender: UIButton) {
        
        
        let textFieldCheck = checkTextFieldData()
        
        if !textFieldCheck{
            
            enterData["name"] = nameTextField.text
            enterData["email"] = emailTextField.text
            enterData["contact"] = contactTextField.text
            enterData["city"] = cityTextField.text
            
            CoreDataManager.save(entityName: "Person",
                                 enterData: enterData)
            
            alert(title: "Congrats:",
                  message: "Record has been saved:")
            
        }
        
    }
    
    @objc func datePickerAction(_ sender: UIDatePicker) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        
        let strDate = dateFormatter.string(from: sender.date)
        self.dobTextField.text = strDate
    }
    
    
    @IBAction func clearButton(_ sender: UIButton) {
        
        clearText()
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        
        self.dismiss(animated: true,
                     completion: nil)
        
    }
}

extension AddDataVc: UITextFieldDelegate {
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        
        let currentText = contactTextField.text ?? ""
        guard let stringRange = Range(range,
                                      in: currentText) else {
                                        return false
                                        
        }
        
        let updatedText = currentText.replacingCharacters(in: stringRange,
                                                          with: string)
        
        return updatedText.count <= 10
        
    }
    
    func textView(_ textView: UITextView,
                  shouldChangeTextIn range: NSRange,
                  replacementText text: String) -> Bool {
        
        let currentText = textView.text ?? ""
        guard let stringRange = Range(range,
                                      in: currentText) else {
                                        return false
                                        
        }
        
        let changedText = currentText.replacingCharacters(in: stringRange,
                                                          with: text)
        
        return changedText.count <= 10
        
    }
    
    
    
    
}
//========================= Extension for class function ================
extension AddDataVc{
    
    func alert(title: String, message: String){
        
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "Ok",
                                      style: UIAlertActionStyle.default,
                                      handler: nil))
        self.present(alert, animated: true,
                     completion: nil)
        
        
    }
    
    func clearText(){
        
        nameTextField.text?.removeAll()
        dobTextField.text?.removeAll()
        emailTextField.text?.removeAll()
        contactTextField.text?.removeAll()
        cityTextField.text?.removeAll()
        nameTextField.becomeFirstResponder()
        
    }
    func checkTextFieldData() -> Bool{
        
        guard let name = nameTextField.text else{
            
            return false
            
        }
        
        guard let dob = dobTextField.text else{
            
            return false
            
        }
        
        guard let email = emailTextField.text else{
            
            return false
            
        }
        
        guard let contact = contactTextField.text else{
            
            return false
            
        }
        guard let city = cityTextField.text else{
            
            return false
            
        }
        
        var alertMessage = String()
        
        if name.isEmpty {
            
            if alertMessage.isEmpty{
                
                alertMessage =  "Name"
                
            } else {
                
                alertMessage +=  ",Name"
                
            }
            
        }
        if dob.isEmpty {
            
            if alertMessage.isEmpty{
                
                alertMessage = "Dob"
                
            } else {
                
                alertMessage += ",Dob"
                
            }
            
            
            
        }
        
        if email.isEmpty {
            
            if alertMessage.isEmpty{
                
                alertMessage = "Email"
                
            } else {
                
                alertMessage += ",Email"
                
            }
            
        } else{
            
            let emailValid = email.isValid(emailTextField.text!)
            if !emailValid{
                
                shakeBtn(emailTextField)
                alert(title: "Error", message: "Enter a valid email:")
                
            }
            
            
        }
        
        if contact.isEmpty{
            
            if alertMessage.isEmpty{
                
                alertMessage = "Contact"
                
            } else {
                
                alertMessage += ",Contact"
                
            }
            
        } else {
            
            
            let contactValid = contact.validateContact(value: contactTextField.text!)
            
            if !contactValid{
                
                shakeBtn(contactTextField)
                alert(title: "Error", message: "Enter a valid Contact number:")
                
            }
        }
        
        if city.isEmpty{
            
            if alertMessage.isEmpty{
                
                alertMessage = "City"
                
            } else {
                
                alertMessage += ",City"
                
            }
            
        }
        
        
        if alertMessage.isEmpty{
            print(alertMessage)
            return false
            
        } else {
            
            alert(title: "Error", message: alertMessage + " cant be empty:")
            
            return true
            
        }
    }
    
    func shakeBtn(_ textField: UITextField) {
        textField.transform = CGAffineTransform(translationX: -5, y:0 )
        UIView.animate(withDuration: 0.2,
                       delay: 0,
                       usingSpringWithDamping: 0.2,
                       initialSpringVelocity: 6.0,
                       options:.curveLinear,
                       animations: {
                        
                        textField.transform = .identity
                        
        },completion: nil)
    }
}
