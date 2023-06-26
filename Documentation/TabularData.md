# TabularData

[Explore and manipulate data in Swift with TabularData](https://developer.apple.com/videos/play/tech-talks/10100)

## Build

## Loading
### ``CSV``
- CSV optionsaG
```swift
import TabularData

let options = CSVReadingOptions(
    hasHeaderRow: false,
    nilEncodings: ["", "nil"] ,
    ignoresEmptyLines: true,
    delimiter: ";"
)
let dataFrame = try DataFrame(contentsOfCSVFile: url, options: options)
```
- Partial loading
let dataFrame = try DataFrame(
    contentsOfCSVFile: url,
    columns: ["id", "name"],
    types: ["id": .integer, "name", .string]
)

### ``JSON``

## Writing Data
     
### Tabular Operation utility functions.

## Print Formatting
```swift
let formattingOption = FormattingOptions(
    maximumLineWidth: 250,
    maximumCellWidth: 15,
    maximumRowCount: 5
)

let data = try DataFrame(contentsOfJSONFile: ...)
print(data.description(options: formattingOption))
```

### Date Parsing
```swift
var options = CSVReadingOptions()
options.addDateParseStrategy(
    Date.ParseStrategy(
        format: "\(year: .twoDigits)/\(month: .twoDigits)/\(day: .twoDigits)",
        locale: Locale(identifier: "en_US"),
        timeZone: TimeZone(abbreviation: "PST")!
    )
)
```

## Operation

- `filter`
- `removeColumn`

## Data Transformation
- `map` 
- `transformColumn` (inplace)
- `decode`
- `filled`
- `summary`
- `Numeric summary`
- `sort`
- `combineColumns`
- `explode`

## Demo: Augmenting a Dataset
- `grouped`
- `joined`
- 

## Best Practices
``` swift
let idID = ColumnID("id", Int.self)
let nameID = ColumnID("name", String.self)
let scoreID = ColumnID("score", Int.self)

var tracks = try DataFrame(
    contentsOfCSVFile: destcsvURL,
    columns: [
        idID.name,
        nameID.name,
        scoreID.name
    ],
    types: [
        idID.name: .integer,
        nameID.name: .string,
        scoreID.nam: .integer
    ]
)
```

### Load errors
- `Failed to parse`
- `Wrong number of columns`
- `Bad encoding`
- `Misplaced quote`

### performance
- Date parsing
- Grouping
- Transform Column
 
