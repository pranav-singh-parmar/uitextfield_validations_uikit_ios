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
        
        //https://medium.com/livefront/understanding-swifts-characterset-5a7a89a32b54
        let characterSet: CharacterSet
        switch allowedCharacters {
        case .lettersAndWhiteSpaces:
            characterSet = CharacterSet.letters.union(.whitespaces)
        case .emailAddress:
            //CharacterSet(charactersIn: "-_.~")
            characterSet = CharacterSet(charactersIn: "-_.@").union(.alphanumerics)
        case .numbers:
            characterSet = CharacterSet.init(charactersIn: "0123456789")
        case .decimalNumbers:
            let occurrenciesOfDot = text.filter { $0 == "." }.count
            if occurrenciesOfDot > 0 &&
                string == "." {
                return false
            }
            //characterSet = NSCharacterSet.init(charactersIn: "0123456789.").inverted
            characterSet = CharacterSet.decimalDigits
        }
        
        //https://stackoverflow.com/questions/59436650/how-to-print-a-content-of-the-characterset-decimaldigits
        //let set = CharacterSet.decimalDigits
        //let allCharacters = UInt32.min ... UInt32.max
        //        allCharacters
        //            .lazy
        //            .compactMap { UnicodeScalar($0) }
        //            .filter { set.contains($0) }
        //            .map { String($0) }
        //            .forEach { print($0) }
        
        let rangeOfInvalidCharacters = string.rangeOfCharacter(from: characterSet.inverted)
        let isStringValid = rangeOfInvalidCharacters == nil
        if let length {
            let newLength: Int = text.count + string.count - range.length
            return (isStringValid && (newLength <= length))
        }
        return isStringValid
    }
}

//MARK: - String
extension String {
    func isRegexValid(forString string: String) -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", self)
        return predicate.evaluate(with: string)
    }
    
    var isValidEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return emailRegEx.isRegexValid(forString: self)
    }
}
