//: [Previous](@previous)

import Foundation


let productJson = """
{
  "id": 1,
  "name": "Guitar",
  "description": "Still has most of its strings!",
  "price": 41.99,
  "sold": false,
  "url": "https://example.com/products/1"
}
"""

//: ### Object Decoding
// unarchiver.decodeObject(of: Listing.self, forKey: "listing")
// NSCoder -> NSSecureCoding


//: ### Codable

struct Product: Codable {
  let id: Int
  let name: String 
  let description: String
  let price: Double
  let sold: Bool
  let url: URL?
}

var product: Product = try! JSONDecoder().decode(Product.self, from: productJson.data(using: .utf8)!)



//: [Next](@next)
