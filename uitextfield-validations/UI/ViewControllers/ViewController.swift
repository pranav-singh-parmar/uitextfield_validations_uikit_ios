//
//  ViewController.swift
//  uitextfield-validations
//
//  Created by Pranav Singh on 25/02/24.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var nameTF: UITextField!
    
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var emailTF: UITextField!
    
    @IBOutlet weak var phoneNumberLabel: UILabel!
    
    @IBOutlet weak var phoneNumberTF: UITextField!
    
    @IBOutlet weak var experienceLabel: UILabel!
    
    @IBOutlet weak var experienceTF: UITextField!

    //MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    //MARK: - objc Functions
    @objc func doneTapped() {
        if nameTF.isFirstResponder {
            emailTF.becomeFirstResponder()
        } else if emailTF.isFirstResponder {
            phoneNumberTF.becomeFirstResponder()
        } else if phoneNumberTF.isFirstResponder {
            experienceTF.becomeFirstResponder()
        } else if experienceTF.isFirstResponder {
            self.view.endEditing(true)
        }
    }
    
    @objc func cancelTapped() {
        self.view.endEditing(true)
    }
    
    //MARK: - Custom Functions
    private func setUpView() {
        nameLabel.text = AppTexts.name
        emailLabel.text = AppTexts.email
        phoneNumberLabel.text = AppTexts.phoneNumber
        experienceLabel.text = AppTexts.experience
        
        nameTF.placeholder = TextFieldPlaceholder.enterYourName
        emailTF.placeholder = TextFieldPlaceholder.enterYourEmail
        phoneNumberTF.placeholder = TextFieldPlaceholder.enterYourPhoneNumber
        experienceTF.placeholder = TextFieldPlaceholder.enterYourExperience
        
        nameTF.keyboardType = .default
        nameTF.textContentType = .name
        nameTF.autocapitalizationType = .words
        // nameTF.reloadInputViews()
        
        emailTF.keyboardType = .emailAddress
        emailTF.textContentType = .emailAddress
        
        phoneNumberTF.keyboardType = .numberPad
        phoneNumberTF.textContentType = .telephoneNumber
        experienceTF.keyboardType = .decimalPad
        // priceTF.textContentType = .
        
        nameTF.delegate = self
        phoneNumberTF.delegate = self
        experienceTF.delegate = self
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        // toolBar.barTintColor = UIColor.appColor(.welcopme_Progress)
        // toolBar.tintColor = UIColor.appColor(.blackColor)
        
        let doneBtn =  UIBarButtonItem(title: AppTexts.done, style: .done, target: self, action: #selector(doneTapped))
        toolBar.setItems([doneBtn], animated: true)
        
        let spaceBtn =  UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        toolBar.setItems([spaceBtn], animated: true)
        
        let cancelBtn =  UIBarButtonItem(title: AppTexts.cancel, style: .done, target: self, action: #selector(cancelTapped))
        toolBar.setItems([cancelBtn], animated: true)
        
        toolBar.setItems([cancelBtn,spaceBtn,doneBtn], animated: false)
        
        nameTF.inputAccessoryView = toolBar
        emailTF.inputAccessoryView = toolBar
        phoneNumberTF.inputAccessoryView = toolBar
        experienceTF.inputAccessoryView = toolBar
    }
}

//MARK: - UITextFieldDelegate
extension ViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters: StringInTextField? = if textField == nameTF {
            .lettersAndWhiteSpaces
        } else if textField == emailTF {
            .emailAddress
        } else if textField == phoneNumberTF {
            .numbers
        } else if textField == phoneNumberTF {
            .decimalNumbers
        } else {
            nil
        }
        return textField.validate(
            withReplacementString: string,
            andRange: range,
            toAllow: allowedCharacters ?? .numbers
        )
    }
}

