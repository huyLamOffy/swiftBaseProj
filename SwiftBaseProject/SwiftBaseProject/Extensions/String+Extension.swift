//
//  String+Extension.swift
//  ineocoin
//
//  Created by Huy Lam on 12/8/17.
//  Copyright © 2017 Engie Ineo. All rights reserved.
//

import Foundation

extension String {
    func chunkFormatted(withChunkSize chunkSize: Int = 3,
                        withSeparator separator: Character = ",") -> String {
        return self.filter { $0 != separator }.chunk(n: chunkSize)
            .map{ String($0) }.joined(separator: String(separator))
    }
}

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}

extension String {
    var removeNonNumeric: String {
        return components(separatedBy: CharacterSet(charactersIn: "0123456789+").inverted).joined(separator: "")
    }
    var isPhoneNumber: Bool {
        do {
            let detector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.phoneNumber.rawValue)
            let matches = detector.matches(in: self, options: [], range: NSMakeRange(0, self.count))
            if let res = matches.first {
                return res.resultType == .phoneNumber && res.range.location == 0 && res.range.length == self.count
            } else {
                return false
            }
        } catch {
            return false
        }
    }
    
    func vpToFormattedPhoneNumber() -> String? {
        guard let first = self.first else { return nil }
        let pattern = first == "+" ? "+xx yxx xxxxxxxxxxx" : "xyxx xxxxxxxxxxx"
        let phoneNumber = self.replacingOccurrences(of: "+", with: "")
        var retVal: String = ""
        var index = 0
        for char in pattern.lowercased() {
            guard index < phoneNumber.count else {
                return retVal
            }
            
            if char == "x" {
                let charIndex = phoneNumber.index(phoneNumber.startIndex, offsetBy: index)
                let phoneChar = phoneNumber[charIndex]
                guard "0"..."9" ~= phoneChar else {
                    return nil
                }
                retVal.append(phoneChar)
                index += 1
            } else if char == "y" {
                var charIndex = phoneNumber.index(phoneNumber.startIndex, offsetBy: index)
                var indexTemp = 1
                while phoneNumber[charIndex] == "0" {
                    charIndex = phoneNumber.index(phoneNumber.startIndex, offsetBy: index + indexTemp)
                    indexTemp += 1
                }
                
                let phoneChar = phoneNumber[charIndex]
                guard "0"..."9" ~= phoneChar else {
                    return nil
                }
                retVal.append(phoneChar)
                index += indexTemp
            } else {
                retVal.append(char)
            }
        }
        
        if phoneNumber.endIndex > phoneNumber.index(phoneNumber.startIndex, offsetBy: index) {
            return nil
        }
        
        return retVal
    }
}
