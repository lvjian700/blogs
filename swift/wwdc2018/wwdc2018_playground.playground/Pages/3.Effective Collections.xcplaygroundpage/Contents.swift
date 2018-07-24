//: [Previous](@previous)

import Foundation

extension Collection {
  var second: Element? {
    return self.dropFirst().first
  }
}

[1, 2, 3].second

//: ## Slices & Lazy collection
// Eager and lazy
(1...1000).map { $0 * 2}.filter { $0 < 10 } // eager
(1...1000).lazy.map { $0 * 2}.filter { $0 < 10 }.first // lazy

// bridging string
let string: String = "1111"
let nsstring: NSString = string as NSString

// Thread
var sleepingBears = [String]()
let q = DispatchQueue(label: "Bear")

q.async { sleepingBears.append("Jian") }
q.async { sleepingBears.append("Mei") }
q.async { print(sleepingBears) }

//: [Next](@next)
