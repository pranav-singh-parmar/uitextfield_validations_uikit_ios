//
//  ViewController.swift
//  uitextfield-validations
//
//  Created by Pranav Singh on 25/02/24.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var phoneNumberTF: UITextField!
    
    @IBOutlet weak var priceTF: UITextField!

    //MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    //MARK: - Custom Functions
    private func setUpView() {
        phoneNumberTF.keyboardType = .numberPad
        priceTF.keyboardType = .decimalPad
        
        phoneNumberTF.delegate = self
        priceTF.delegate = self
    }
}

//MARK: - UITextFieldDelegate
extension ViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters: StringInTextField? = if textField == phoneNumberTF {
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

