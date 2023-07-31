//
//  File.swift
//
//
//  Created by 蒋艺 on 2023/6/23.
//

//import Foundation

actor Counter {
    var value = 0
    @discardableResult
    func increment(by n: Int = 1) -> Int {
        for _ in 0..<n {
            value += 1
        }
        return value
    }
}

//import System
import Foundation

let stdout = FileHandle.standardOutput
let data = "Hello, World😀𝛼∫≯𝒇ℱ𝒢𝓀♻️.\n".data(using: .utf8)!

//try stdout.writeAll(data)
try stdout.write(contentsOf: data)


let counter = Counter()

let task1 = Task {
    print(await counter.increment(by: 10000), await counter.value, "by Task1")
}

let task2 = Task {
    print(await counter.increment(by: 10000), await counter.value, "by Task2")
}

// Wait for both tasks to finish
/// Void. self stands for the return type of each group
await withTaskGroup(of: Void.self) { group in
    group.addTask { await task1.value }
    group.addTask { await task2.value }
    await group.waitForAll()
}

func onAppearHandle() async throws {
    
}

print("All tasks completed")

//try await withThrowingTaskGroup(of: Void.self, body: { group in
//    group.async {
//        thumbnails[id] = try await fetchOneThumbnail(withID: id)
//    }
//})

// optional value, error handling, concurrency
/*:
 ```swift
 for await quake in quakes {
 if quake.magnitude > 3 {
 ...
 }
 }
 
 ```
 */

//let url = URL(filePath: "/Users/meqt/Downloads/somefile.txt")
//for try await line in url.lines {
//    print(line)
//}

/*:
 AsyncSequence is just like Sequence but async, A wait
 */

/*:
 - Threading model and
 - Synchronization
 - GCD vs. Swift Concurrency above 13.0
 @Section("GCD") {
 await -> async wait, nonblocking wait ~[Swift Concurrency: Behind the scenes, 14:28](https://developer.apple.com/wwdc21/10254)
 Stack pop and push
 Thread in heap.
 dependency of codes.
 Cooperative thread pool
 await and non-blocking of thread,
 Tracking of task dependencies.
 }
 - Worker threads don't block
 Concurrency comes with cost.
 atomicity and await: atomicity is broken with await, cannot hold lock around await. Thread specific data is not perserved around an await.
 pthread, NScondtion and DispatchSemaphore are unsafe with swift concurrency and with no compiler support.
 os_unfair_lock and NSLock are safe but with no compiler support.
 ## Synchronization
 - Mutual exculsion
 actor using cooperative pool, **reuse thread** and **Non-blocking**.
 Serial Queue -> Actor
 Concurrency Queue -> Actors
 Cooperative thread pool.
 Actor hopping.
 Reentrancy and priority
 Main Actor.
 Reduce Context Switching.
 
 yeild to the main actor
 
 */

//import TabularData

//let csvURL = Bundle.module.url(forResource: "data", withExtension: "csv", subdirectory: "Resources")!
//let destcsvURL = URL(filePath: "/Users/meqt/Downloads/data.csv")
//let destJSONURL = URL(filePath: "/Users/meqt/Downloads/data.json")
//
////let dataFrame = try DataFrame(contentsOfCSVFile: url, options: options)
//let dataFrame = try DataFrame(contentsOfCSVFile: csvURL)
//print(dataFrame)
////try dataFrame.writeCSV(to: destcsvURL)
////try dataFrame.writeJSON(to: destJSONURL)
//print("CSV", try String(contentsOf: destcsvURL), separator: "\n")
//print("JSON", try String(contentsOf: destJSONURL), separator: "\n")
//
//print(dataFrame[row: 3])
//print(dataFrame[column: 2])


import os
//let logger = os.Logger(subsystem: <#T##String#>, category: <#T##String#>)
//logger.info(<#T##message: OSLogMessage##OSLogMessage#>)
