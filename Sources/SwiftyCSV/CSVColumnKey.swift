//
//  CSVColumnKey.swift
//
//
//  Created by WeIHa'S on 2024/3/18.
//

import Foundation

/// Protocol representing the type of column in a CSV file.
public protocol CSVColumnKey {
    /// The raw value representing the column index.
    var rawValue: Int { get }
}

/// Extension to CSVLine allowing subscripting by CSVColumnType.
public extension CSVLine {
    /// Allows subscripting CSVLine by CSVColumnType to access or modify the value of a specific column.
    /// - Parameter column: The type of column to access or modify.
    /// - Returns: The value of the column.
    subscript(column: CSVColumnKey) -> String {
        get {
            self.fields[column.rawValue]
        }
        set {
            self.fields[column.rawValue] = newValue
        }
    }
}
