//
//  CSVFile.swift
//
//
//  Created by WeIHa'S on 2024/1/23.
//

import Foundation

/// Represents a CSV file, encapsulating functionalities for reading from and writing to CSV files.
public struct CSVFile {
    
    /// The URL of the CSV file on the filesystem.
    private let fileURL: URL
    
    /// An array of `CSVLine` objects representing the lines in the CSV file.
    public var lines: [CSVLine]
    
    /// Initializes a `CSVFile` instance from a file path string.
    /// - Parameter filePath: The path to the CSV file.
    /// - Throws: An error if the file cannot be found or read, or if its contents cannot be interpreted as UTF-8 encoded text.
    public init(filePath: String) throws {
        let url = URL(fileURLWithPath: filePath)
        try self.init(fileURL: url)
    }
    
    /// Initializes a `CSVFile` instance directly from a `URL` object.
    /// - Parameter fileURL: The `URL` of the CSV file.
    /// - Throws: An error if the file cannot be read, or if its contents cannot be interpreted as UTF-8 encoded text.
    public init(fileURL: URL) throws {
        self.fileURL = fileURL
        
        // Reads the file content, normalizes line endings to '\n', and initializes `lines` with the processed content.
        let csvContent = try String(contentsOf: fileURL, encoding: .utf8).replacingOccurrences(of: "\r\n", with: "\n")
        self.lines = csvContent.components(separatedBy: "\n").dropLast().map({ CSVLine(rawValue: $0) })
    }
    
    /// Saves the current state of `lines` back to the file system, either to the original file or to a new specified location.
    /// - Parameter newURL: An optional `URL` to save the file to. If not provided, the file is saved to its original location.
    /// - Throws: An error if the file cannot be written.
    public func save(to newURL: URL? = nil) throws {
        let result = lines.map(\.rawValue).joined(separator: "\n").appending("\n")
        try result.write(to: newURL ?? fileURL, atomically: true, encoding: .utf8)
    }
    
    /// Accesses individual lines within the `CSVFile` using subscript notation.
    /// - Parameter index: The index of the line to access.
    /// - Returns: The `CSVLine` object representing the line at the specified index.
    public subscript(_ index: Int) -> CSVLine {
        get { lines[index] }
        set { lines[index] = newValue }
    }
}
