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
    
    @IBOutlet weak var genderLabel: UILabel!
    
    @IBOutlet weak var genderTF: UITextField!
    
    @IBOutlet weak var experienceLabel: UILabel!
    
    @IBOutlet weak var experienceTF: UITextField!
    
    @IBOutlet weak var submitBTN: UIButton!
    
    //MARK: - Variables
    private let genderList = ["Male", "Female", "Others"]
    private let genderPicker = UIPickerView()

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
            genderTF.becomeFirstResponder()
        } else if genderTF.isFirstResponder {
            genderTF.text = genderList[genderPicker.selectedRow(inComponent: 0)]
            experienceTF.becomeFirstResponder()
        } else if experienceTF.isFirstResponder {
            self.view.endEditing(true)
        }
    }
    
    @objc func textFieldValueChange(_ textField: UITextField) {
        if let _ = getValidationMessageIfAnyFieldIsInvalid() {
            submitBTN.setEnabled(false)
        } else {
            submitBTN.setEnabled(true)
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
        genderLabel.text = AppTexts.gender
        experienceLabel.text = AppTexts.experience
        submitBTN.setTitle(AppTexts.submit, for: .normal) 
        
        nameTF.placeholder = TextFieldPlaceholder.enterYourName
        emailTF.placeholder = TextFieldPlaceholder.enterYourEmail
        phoneNumberTF.placeholder = TextFieldPlaceholder.enterYourPhoneNumber
        genderTF.placeholder = TextFieldPlaceholder.selectYourGender
        experienceTF.placeholder = TextFieldPlaceholder.enterYourExperience
        
        nameTF.keyboardType = .default
        nameTF.textContentType = .name
        nameTF.autocapitalizationType = .words
        nameTF.returnKeyType = .next
        // nameTF.reloadInputViews()
        
        emailTF.keyboardType = .emailAddress
        emailTF.textContentType = .emailAddress
        emailTF.returnKeyType = .next
        
        phoneNumberTF.keyboardType = .numberPad
        phoneNumberTF.textContentType = .telephoneNumber
        phoneNumberTF.returnKeyType = .next
        
        genderTF.inputView = genderPicker
        genderTF.tintColor = .clear
        
        experienceTF.keyboardType = .decimalPad
        // experienceTF.textContentType = .
        experienceTF.returnKeyType = .done
        
        nameTF.delegate = self
        emailTF.delegate = self
        phoneNumberTF.delegate = self
        genderTF.delegate = self
        experienceTF.delegate = self
        
        genderPicker.delegate = self
        genderPicker.dataSource = self
        
        nameTF.addTarget(self, action: #selector(textFieldValueChange(_:)), for: .editingChanged)
        emailTF.addTarget(self, action: #selector(textFieldValueChange(_:)), for: .editingChanged)
        phoneNumberTF.addTarget(self, action: #selector(textFieldValueChange(_:)), for: .editingChanged)
        genderTF.addTarget(self, action: #selector(textFieldValueChange(_:)), for: .editingChanged)
        experienceTF.addTarget(self, action: #selector(textFieldValueChange(_:)), for: .editingChanged)
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
//         toolBar.barTintColor = UIColor.white
//         toolBar.tintColor = UIColor.black
        
        let doneBTN =  UIBarButtonItem(title: AppTexts.done, style: .done, target: self, action: #selector(doneTapped))
        toolBar.setItems([doneBTN], animated: true)
        
        let spaceBTN =  UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        toolBar.setItems([spaceBTN], animated: true)
        
        let cancelBTN =  UIBarButtonItem(title: AppTexts.cancel, style: .done, target: self, action: #selector(cancelTapped))
        toolBar.setItems([cancelBTN], animated: true)
        
        toolBar.setItems([cancelBTN, spaceBTN, doneBTN], animated: false)
        
        nameTF.inputAccessoryView = toolBar
        emailTF.inputAccessoryView = toolBar
        phoneNumberTF.inputAccessoryView = toolBar
        genderTF.inputAccessoryView = toolBar
        experienceTF.inputAccessoryView = toolBar
        
        submitBTN.setEnabled(false)
        if #available(iOS 14.0, *) {
            submitBTN.addAction(UIAction(handler: { action in
                guard let button = action.sender as? UIButton else {
                    return
                }
                self.submitBA(button)
            }), for: .primaryActionTriggered)
        } else {
            submitBTN.addTarget(self, action: #selector(submitBA(_:)), for: .touchUpInside)
        }
    }
    
    private func getValidationMessageIfAnyFieldIsInvalid() -> String? {
        if nameTF.text?.trim.isEmpty == true {
            return ""
        } else if emailTF.text?.trim.isEmpty == true {
            return ""
        } else if !(emailTF.text?.isValidEmail == true) {
            return ""
        } else if phoneNumberTF.text?.isEmpty == true {
            return ""
        } else if phoneNumberTF.text?.count != 10 {
            return ""
        } else if genderTF.text?.isEmpty == true {
            return ""
        } else if experienceTF.text?.isEmpty == true {
            return ""
        } else {
            return nil
        }
    }
    
    private func clearAllFields() {
        nameTF.text = ""
        emailTF.text = ""
        phoneNumberTF.text = ""
        genderTF.text = ""
        genderPicker.reloadAllComponents()
        experienceTF.text = ""
    }
    
    @IBAction func submitBA(_ sender: UIButton) {
        if let message = getValidationMessageIfAnyFieldIsInvalid() {
            let alert = UIAlertController(title: "Error!", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel))
            self.present(alert, animated: true)
        } else {
            let alert = UIAlertController(title: "Success!", message: "All Details are Valid.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
                self.clearAllFields()
            })
            self.present(alert, animated: true)
        }
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
        } else if textField == experienceTF {
            .decimalNumbers
        } else {
            nil
        }
        let maxLength: Int? = if textField == phoneNumberTF {
            12
        } else {
            60
        }
        return textField.validate(
            withReplacementString: string,
            andRange: range,
            toAllow: allowedCharacters ?? .numbers,
            uptoLength: maxLength
        )
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        doneTapped()
        return true
    }
}

//MARK: - UIPickerViewDelegate, UIPickerViewDataSource
extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return genderList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return genderList[row]
    }
}
