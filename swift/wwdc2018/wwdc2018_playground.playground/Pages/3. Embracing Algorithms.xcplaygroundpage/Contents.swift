
//: [Previous](@previous)

import Foundation
import QuartzCore

/*:
 # Embracing Algorithms
 https://developer.apple.com/videos/play/wwdc2018/223/
 */
//: > What's the computer do kid ?
//: > They compute!
//: So funny !!!

/*:
 Algorithms improve scalibility
 */

/*:
 Tips
 - Get to know your standard library
 - Linear O(n) and Quarted O(n^2)
 - O(n log n)
 */

// Algorithms is division
// challenage? Remove Odd numbers

/*:
 Discover Algorithms
 - Search it and read document
 - https://github.com/apple/swift/blob/master/test/Prototypes/Algorithms.swift
 */

//: No Raw Loops

/*:
 ### Real lession today
 
 There is a conversation [Comment's on PR](https://git.realestate.com.au/resi-mobile/resi-mobile-ios/pull/4048#discussion_r161716) for how check a element existing
*/

func measure(block: () -> ()) -> CFTimeInterval {
  let start = CACurrentMediaTime()
  block();
  let end = CACurrentMediaTime()
  return end - start
}

struct Collection {
  let name: String
}

struct CollectionViewModel {
  let collection: Collection
}

class CollectionsViewController {
  private var collectionViewModels: [CollectionViewModel] = []
  
  private var existingCollectionNames: [String] {
    return collectionViewModels.map { $0.collection.name}
  }
  
  func display(newCollection collection: Collection) {
    if existingCollectionNames.contains(collection.name) {
      print("This is a existing collection: \(collection.name)")
    }
//
//    if isDuplicated(collection: collection) {
//      print("This is a existing collection: \(collection.name)")
//    }

    collectionViewModels.insert(CollectionViewModel(collection: collection), at: 0)
  }
  
  private func isDuplicated(collection: Collection) -> Bool {
    return collectionViewModels.contains { $0.collection.name == collection.name }
  }
}

let vc = CollectionsViewController()

let names: [Int] = Array(0...5000)
let newNames = [names, names].flatMap { $0 }

measure {
  newNames.forEach {
    vc.display(newCollection: Collection(name: "\($0)"))
  }
}

// 22.89584232000198
// 18.89853264200065


//: [Next](@next)

