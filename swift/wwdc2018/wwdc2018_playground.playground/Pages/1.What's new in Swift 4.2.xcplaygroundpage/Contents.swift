//: [Previous](@previous)

/*:
 # What's new in Swift 4.2
 
 * WWDC 2018 Session: https://developer.apple.com/videos/play/wwdc2018/401/
 * https://www.hackingwithswift.com/articles/77/whats-new-in-swift-4-2
*/

/*:
 ### Equalable
*/
enum Either<Left, Right> {
    case left(Left)
    case right(Right)
}

extension Either: Equatable where Left: Equatable, Right: Equatable {}
extension Either: Hashable where Left: Hashable, Right: Hashable {}

var eitherSet = Set<Either<Int, String>>()
eitherSet.insert(.left(1))
eitherSet.insert(.right("1"))
eitherSet.insert(.left(1))
eitherSet.insert(.right("1"))

/*:
 ### Hashable
*/
struct Location {
    let suburb: String
    let state: String
    let postcode: Int
}

extension Location: Hashable {
    func hash(into hasher: inout Hasher) {
        suburb.hash(into: &hasher)
        state.hash(into: &hasher)
    }
}

let melbourne = Location(suburb: "Melboure", state: "VIC", postcode: 3000)
let melbourne2 = Location(suburb: "Melboure", state: "VIC", postcode: 3001)

melbourne.hashValue
melbourne2.hashValue

var locations = Set<Location>()
locations.insert(melbourne)
locations.insert(melbourne2)

/*:
 ### Enum CaseIterable
*/
enum Status: CaseIterable {
    case start
    case running
    case stop
}

Status.allCases

/*:
 ### Randomly
*/

var greetings = [1, 2, 3]
let randomItem = greetings.randomElement()

Int.random(in: 1...5)
Float.random(in: 1...2)
Bool.random()

greetings.shuffle()
greetings.shuffle()

/*:
 ### New markers
*/
//#warning("Don't use it")
//#error("Ops... can not support Linux")

/*:
 ### Boolean
 - toggle(): this is a mutating method
*/
var isMarked = false
isMarked.toggle()
isMarked

/*:
 ### Array
*/
// https://github.com/apple/swift-evolution/blob/master/proposals/0207-containsOnly.md
let scores = [85, 86, 95]
scores.allSatisfy { $0 > 85 }
scores.allSatisfy { $0 > 90 }

var pythons = ["John", "Michael", "Graham", "Terry", "Eric", "Terry"]
pythons.removeAll { $0.hasPrefix("Terry") }


/*:
 ### Dynamic Member Lookup
 - https://github.com/apple/swift-evolution/blob/master/proposals/0195-dynamic-member-lookup.md
 - https://github.com/apple/swift-evolution/blob/master/proposals/0216-dynamic-callable.md
 
 Inorder to make Swift protable with Python, Ruby, Javascript etc language
*/

@dynamicMemberLookup
struct Person {
    subscript(dynamicMember member: String) -> String {
        let properties = ["name": "Taylor Swift", "city": "Nashville"]
        return properties[member, default: ""]
    }
    
    subscript(dynamicMember member: String) -> Int {
        let properties = ["age": 26, "height": 178]
        return properties[member, default: 0]
    }
    
    subscript(dynamicMember member: String) -> (_ input: String) -> Void {
        let myName: String = self.name
        return {
            print("Hello! I'm \(myName), I live at here: \($0)")
        }
    }
}

let p = Person()
let name: String = p.name
let city: String = p.city
let age: Int = p.age
p.printAddress("555 Taylor Swift Avenue")

@dynamicMemberLookup
class Configuration {
    private var dict: [String: String] = [:]
    
    subscript(dynamicMember member: String) -> String {
        get {
            return dict[member, default: ""]
        }
        set {
            dict[member] = newValue
          
        }
    }
}

var config = Configuration()
config.url = "http://www.google.com"
config.url
config.name = "NiuX"


//: [Next](@next)
