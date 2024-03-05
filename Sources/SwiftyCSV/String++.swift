//
//  File.swift
//  
//
//  Created by WeIHa'S on 2024/1/23.
//

import Foundation

extension String {
    /// Removes enclosing quotes from a string if it starts and ends with a quote character.
    var withoutQuotes: String {
        if self.hasPrefix("\"") && self.hasSuffix("\"") {
            return String(self.dropFirst().dropLast())
        } else {
            return self
        }
    }
    
    /// Formats the string as a CSV cell, enclosing it in quotes and escaping any existing quotes within the string.
    var asCSVCell: String {
        return "\"\(replacingOccurrences(of: "\"", with: "\"\""))\""
    }
    
    /// Splits the string into an array of substrings based on a specified separator. It accounts for quoted substrings to avoid splitting within them.
    /// The function ensures that splitting respects the presence of quotes, treating them as encapsulating a single cell even if they contain the separator.
    /// - Parameter separator: The character used to split the string. Defaults to ",".
    /// - Returns: An array of substrings, where each substring represents a cell in a CSV row, with quotes removed.
    func csvSplit(_ separator: String = ",") -> [String] {
        func oddNumberOfQuotes(_ string: String) -> Bool {
            return string.components(separatedBy: "\"").count % 2 == 0
        }

        let initial = self.components(separatedBy: separator)
        var merged = [String]()
        for newString in initial {
            guard let record = merged.last, oddNumberOfQuotes(record) else {
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
