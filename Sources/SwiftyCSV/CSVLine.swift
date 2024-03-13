//
//  CSVLine.swift
//  
//
//  Created by WeIHa'S on 2024/1/23.
//

import Foundation

/// Represents a single line in a CSV file, encapsulating the logic for parsing and assembling CSV fields.
public struct CSVLine: RawRepresentable {
    
    /// An array of strings, each representing a field within the CSV line. This is the primary storage for the line's data.
    public var fields: [String]
    
    /// Initializes a `CSVLine` instance directly with an array of strings representing the fields of the CSV line.
    /// This initializer can be used when the fields are already separated and no parsing of a raw string representation is necessary.
    /// - Parameter fields: An array of strings, where each string is a field in the CSV line.
    public init(fields: [String]) {
        self.fields = fields
    }
    
    /// Initializes a `CSVLine` instance from a raw string representation of a CSV line.
    /// The raw string is split into fields based on CSV formatting rules, handling quotes and commas appropriately.
    /// - Parameter rawValue: A string that represents a single line in a CSV format.
    public init(rawValue: String) {
        // Splits the raw string into fields, taking into account CSV encoding rules such as quoted fields.
        fields = rawValue.csvSplit()
    }
    
    /// A string representation of the `CSVLine`, assembling the fields into a single CSV-formatted line.
    /// Each field is properly quoted and escaped according to CSV rules, and fields are joined with commas.
    public var rawValue: String {
        // Joins the fields into a CSV-formatted string, quoting and escaping each field as necessary.
        fields.map({$0.asCSVCell}).joined(separator: ",")
    }
    
    /// Accesses individual fields within the `CSVLine` using subscript notation.
    /// - Parameter index: The index of the field to access.
    /// - Returns: The string value of the field at the specified index.
    public subscript(_ index: Int) -> String {
        get { fields[index] }
        set { fields[index] = newValue }
    }
}
