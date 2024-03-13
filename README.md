# **SwiftyCSV**

SwiftyCSV is a lightweight CSV library for Swift, designed to simplify the process of working with CSV files.

### How to Use

#### Introduction

To get started, obtain a CSV file from your filesystem:

```swift
let file = try CSVFile(filePath: "/Users/weiha/Desktop/file.csv")
```

#### Accessing CSV Data

Retrieve a single line from the file:

```swift
let line = file.lines[0]
// or
let line = file[0]
```

Accessing a single field within a line:

```swift
let field = line.fields[0]
// or
let field = line[0]
```

#### Manipulating CSV Data

Perform actions on each line:

```swift
for line in file.lines {
    print(line)
}
```

Or modify lines:

```swift
for index in file.lines.indices {
    file.lines[index].fields.first = "Hello"
}
```

#### Asynchronous Operations

For asynchronous operations, use the provided function:

```swift
func processCSVLines(asyncing: Bool = false, csvLines: [CSVLine], handel: @escaping (CSVLine) async -> CSVLine) async throws -> [CSVLine]
```

Async operation may result in out-of-order processing. Use the `asyncing` flag to control this behavior.

Example usage:

```swift
func doSomething(csvline: CSVLine) async -> CSVLine {
    var csvline = csvline
    try! await Task.sleep(nanoseconds: 10_0000_0000)
    csvline.fields[0] = "hello"
    return csvline
}

let convertLines = try await SwiftyCSV.processCSVLines(asyncing: true, csvLines: file.lines) {
    await doSomething(csvline: $0)
}

file.lines = convertLines
```

#### Saving Changes

Save any modifications made to the CSV file:

```swift
try csvFile.save()
```

### Note

Performance may degrade with large datasets. Use with caution for big data operations.
