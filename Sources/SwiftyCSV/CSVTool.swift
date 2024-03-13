//
//  CSVTool.swift
//  
//
//  Created by WeIHa'S on 2024/3/5.
//

import Foundation

/// - Parameters:
///   - asyncing: A boolean value indicating whether the processing should be done concurrently (true) or sequentially (false). When set to true, the method processes each CSV line concurrently. When set to false, the processing is done sequentially.
///   - csvLines: An array of CSVLine objects representing the lines to be processed.
///   - handel: A closure that takes a single CSVLine object and returns a processed CSVLine object asynchronously. This closure is applied to each line in the csvLines array.
/// - Throws: The method can throw errors that might occur during the asynchronous handling of CSV lines. Callers of this method should be prepared to handle these errors using try-catch mechanisms.
/// - Returns: An array of CSVLine objects that have been processed according to the logic defined in the handel closure. The order of the lines in the returned array corresponds to the order of the lines in the input array.
/// - Important: Asynchronous is random but synchronization is the original order, which needs to be paid attention to.
@available(iOS 13.0.0, *)
@available(macOS 10.15, *)
public func processCSVLines(asyncing: Bool = false, csvLines: [CSVLine], handel: @escaping (CSVLine) async -> CSVLine) async throws -> [CSVLine] {
    let lines = csvLines
    
    if asyncing {
        // Use concurrent tasks to process each line
        return await withTaskGroup(of: CSVLine.self, returning: [CSVLine].self) { taskGroup in
            for line in lines {
                taskGroup.addTask {
                    return await handel(line)
                }
            }
            
            return await taskGroup.reduce(into: [CSVLine]()) { partialResult, string in
                partialResult.append(string)
            }
        }
        
    } else {
        var progressLines: [CSVLine] = []
        
        for line in lines {
            let newLine = await handel(line)
            progressLines.append(newLine)
        }
        
        return progressLines
    }
}
