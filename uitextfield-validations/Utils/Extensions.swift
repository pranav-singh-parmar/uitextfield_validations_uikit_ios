//
//  Extensions.swift
//  uitextfield-validations
//
//  Created by Pranav Singh on 27/02/24.
//

import UIKit

//MARK: - UITextField
extension UITextField {
    func validate(
        withReplacementString string: String, // contains new string added to existing one
        andRange range: NSRange,
        toAllow allowedCharacters: StringInTextField,
        uptoLength length: Int? = nil
    ) -> Bool {
        guard let text = self.text else {
            return false
        }
        
        let strValid: Bool
        switch allowedCharacters {
        case .numbers:
            let numberCS = NSCharacterSet.init(charactersIn: "0123456789").inverted
            strValid = string.rangeOfCharacter(from: numberCS) == nil
        case .decimalNumbers:
            let occurrenciesOfDot = text.filter { $0 == "." }.count
            if occurrenciesOfDot > 0 &&
                string == "." {
                return false
            }
            //let decimalNumberCS = NSCharacterSet.init(charactersIn: "0123456789.").inverted
            let decimalNumberCS = CharacterSet.decimalDigits
            strValid = string.rangeOfCharacter(from: decimalNumberCS) == nil
        }
        if let length {
            let newLength: Int = text.count + string.count - range.length
            return (strValid && (newLength <= length))
        }
        return strValid
    }
}
