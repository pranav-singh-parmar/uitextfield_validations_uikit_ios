//
//  ViewController.swift
//  uitextfield-validations
//
//  Created by Pranav Singh on 25/02/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

extension ViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return textField.validate(
            withReplacementString: string,
            andRange: range,
            toAllow: .numbers
        )
    }
}

