//
//  File.swift
//  
//
//  Created by WeIHa'S on 2024/1/23.
//

import Foundation

extension String {
    /// removeQuotes
    var withoutQuotes: String {
        if self.hasPrefix("\"") && self.hasSuffix("\"") {
            return String(self.dropFirst().dropLast())
        } else {
            return self
        }
    }
    
    var asCSVCell: String {
        return "\"\(replacingOccurrences(of: "\"", with: "\"\""))\""
    }
    
    /// Tries to preserve the parity between open and close characters for different formats. Analizes the escape character count to do so
    func csvSplit(_ separator: String = ",") -> [String] {
        func oddNumberOfQuotes(_ string: String) -> Bool {
            return string.components(separatedBy: "\"").count % 2 == 0
        }

        let initial = self.components(separatedBy: separator)
        var merged = [String]()
        for newString in initial {
            guard let record = merged.last , oddNumberOfQuotes(record) == true else {
                merged.append(newString)
                continue
            }
            merged.removeLast()
            let lastElem = record + separator + newString
            merged.append(lastElem)
        }
        return merged.map({$0.withoutQuotes})
    }
}
