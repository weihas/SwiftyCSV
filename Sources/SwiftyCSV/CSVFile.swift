//
//  CSVFile.swift
//
//
//  Created by WeIHa'S on 2024/1/23.
//

import Foundation

/// Represents a CSV file, encapsulating functionalities for reading from and writing to CSV files.
public struct CSVFile: RawRepresentable {
    
    /// An array of `CSVLine` objects representing the lines in the CSV file.
    public var lines: [CSVLine]

    
    /// Initializes a `CSVFile` instance from a raw string value.
    /// - Parameter rawValue: The raw string value representing the CSV file content.
    public init(rawValue: String) {
        let strings = rawValue.replacingOccurrences(of: "\r\n", with: "\n")
        self.lines = strings.components(separatedBy: "\n").dropLast().map({ CSVLine(rawValue: $0) })
    }
    
    /// Initializes a `CSVFile` instance directly from a `URL` object.
    /// - Parameter fileURL: The `URL` of the CSV file.
    /// - Throws: An error if the file cannot be read, or if its contents cannot be interpreted as UTF-8 encoded text.
    public init(fileURL: URL) throws {
        let string = try String(contentsOf: fileURL, encoding: .utf8)
        self.init(rawValue: string)
    }
    
    /// Initializes a `CSVFile` instance from a file path string.
    /// - Parameter filePath: The path to the CSV file.
    /// - Throws: An error if the file cannot be found or read, or if its contents cannot be interpreted as UTF-8 encoded text.
    public init(filePath: String) throws {
        let url = URL(fileURLWithPath: filePath)
        try self.init(fileURL: url)
    }
    
    /// Returns the raw string representation of the CSV file.
    public var rawValue: String {
        lines.map(\.rawValue).joined(separator: "\n").appending("\n")
    }
    
    /// Accesses individual lines within the `CSVFile` using subscript notation.
    /// - Parameter index: The index of the line to access.
    /// - Returns: The `CSVLine` object representing the line at the specified index.
    public subscript(_ index: Int) -> CSVLine {
        get { lines[index] }
        set { lines[index] = newValue }
    }
    
    /// Saves the CSV file to the specified URL.
    /// - Parameter url: The URL where the CSV file should be saved.
    /// - Throws: An error if the file cannot be written or if there are encoding issues.
    public func save(to url: URL) throws {
        try rawValue.write(to: url, atomically: true, encoding: .utf8)
    }
}
