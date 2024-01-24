//
//  File.swift
//  
//
//  Created by WeIHa'S on 2024/1/23.
//

import Foundation

public struct CSVLine: RawRepresentable {
    public var fields: [String] = []
    
    
    public init(rawValue: String) {
        fields = rawValue.csvSplit()
    }
    
    public var rawValue: String {
        fields.map({$0.asCSVCell}).joined(separator: ",")
    }
}
