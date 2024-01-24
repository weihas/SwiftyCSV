// The Swift Programming Language
// https://docs.swift.org/swift-book
import Foundation

public struct CSVFile {
    private let fileURL: URL
    
    public var lines: [CSVLine]
    
    
    public init(filePath: String) throws {
        let url = URL(fileURLWithPath: filePath)
        try self.init(fileURL: url)
    }
    
    
    public init(fileURL: URL) throws {
        self.fileURL = fileURL
        
        let csvContent = try String(contentsOf: fileURL, encoding: .utf8).replacingOccurrences(of: "\r\n", with: "\n")
        self.lines = csvContent.components(separatedBy: "\n").dropLast().map({ CSVLine(rawValue: $0)})
    }
    
    public func save(to newURL: URL? = nil) throws {
        let result = lines.map(\.rawValue).joined(separator: "\n").appending("\n")
        try result.write(to: fileURL, atomically: true, encoding: .utf8)
    }
}
