//: Playground - noun: a place where people can play

import UIKit


// 定义变量
var age = 20// 定义变量
age = 21
let name = "Halo" // 定义常亮

// 指定数据类型
let cash: Float = 1.25
let money: Double = 1.252525
let dollar: String = "USD"
let optionalStr: String? = "This is a optional"

// 字符串操作
let currencies = "AUD, " + dollar
let rmb = "1 \(dollar) is 6 RMB"
let formattedString = String(format: "%.2f \(dollar) is about 600 RMB", 100.0)

let introduceSwift = "We are excited by this new chapter in the story of Swift. " +
    "After Apple unveiled the Swift programming language, it quickly became one of " +
    "the fastest growing languages in history. Swift makes it easy to write software " +
    "that is incredibly fast and safe by design. Now that Swift is open source, you can " +
    "help make the best general purpose programming language available everywhere."

// 定义 tuple
let numbersTuple = (1, 100, 1000)
print("min: \(numbersTuple.0), max: \(numbersTuple.1), sum: \(numbersTuple.2)")

let numbersNamedTuple = (min: 1, max: 100, sum: 1000)
print("min: \(numbersNamedTuple.0), max: \(numbersNamedTuple.1), sum: \(numbersNamedTuple.2)")
print("min: \(numbersNamedTuple.min), max: \(numbersNamedTuple.max), sum: \(numbersNamedTuple.sum)")

// Array
var fruits = ["apple", "banana", "oranage"]
fruits[0] = "tomato"
fruits

var fruitsPrice = [
    "apple": 4.25,
    "banana": 6.2
]
fruitsPrice[fruits[1]]


var emptyArray = [String]()
var emptyDictionary = [String: Float]()

// set or pass a emtpy collections
fruits = []
fruitsPrice = [:]


//
for score in [1,2,3,4,5,6] {
    score * score * score
}

for (key, val) in ["one": 1, "two": 2] {
    print("\(val) is \(key)")
}


// if-else and Optinal

var optionalString: String? = nil
print(optionalString == nil)
//print(optionalString!)

if optionalString != nil {
    let val = optionalString!
    print("There is a value: \(val)")
} else {
    print("There is no value")
}

if let val = optionalString {
    print("There is a value: \(val)")
} else {
    print("There is no value")
}
var optionalName: String? = "Jian"
print(optionalName!)

var greeting = "Hello!"

if let name = optionalName {
    greeting = "Hello \(name)"
}

let firstName: String = "Jian"
let lastName: String = "Lv"
let fullName = "\(firstName) \(lastName)"


// ?? default value for Optional
let nickName: String? = nil
let displayName = "\(nickName ?? fullName)"


// switch
let vegetable = "red pepper"

switch vegetable {
case "celery":
    print("Add some raisins and make ants on a log.")
case "cucumber", "watercress":
    print("Taht would make a good tea sandwich.")
case let x where x.hasSuffix("pepper"):
    print("Is it a spicy \(x)?")
default:
    print("Everythink tasts good")
}

// for ... in {Dictionary}
let numbersDict = [
    "Prime": [2, 3, 5, 7, 11, 13],
    "Fibonacci": [1, 1, 2, 3, 5, 8],
    "Square": [1, 4, 9, 16, 25]
]

var largest = 0

for (kind, numbers) in numbersDict {
    for number in numbers {
        number
        if number > largest {
            largest = number
        }
    }
}
print(largest)

// while


var n = 1
while n < 100 {
    n += n
}
print(n)

// repeat ... while

var m = 1
repeat {
    m += m
} while m < 100
print(m)

// for .. in {Range}
var total = 0
for i in 0..<4 {
    total += i
}
print(total)


// Functions
// Parameter name as label
func greet(person: String, day: String) -> String {
    return "Hello \(person), today is \(day)."
}
greet(person: "Jian", day: "Friday")

// Use label for argument, _ for no label
func greet(_ person: String, on day: String) -> String {
    return "Hello \(person), today is \(day)."
}
greet("Jian", on: "Friday")

// Return tuple for mutiple return values
func calcStatistics(scores: [Int]) -> (min: Int, max: Int, sum: Int) {
    var min = scores[0]
    var max = scores[0]
    var sum = 0
    
    for score in scores {
        if score > max {
            max = score
        } else if score < min {
            min = score
        }
        
        sum += score
    }
    
    return (min, max, sum)
}

let statistics = calcStatistics(scores: [5, 1, 100, 30, 90])
print(statistics.sum)
print(statistics.2)

// unlimited args...
func sumOf(numbers: Int...) -> Int {
    return numbers.reduce(0, +)
}
sumOf()
sumOf(numbers: 1, 2, 3, 4, 10)

// nested function
func returnFifteen() -> Int {
    var y = 10
    func add() { y += 5 }
    add()
    return y
}
returnFifteen()

// hight-order function / Functions are a first-class type
// function as return value
func createIncrementer() -> ((Int) -> Int) {
    func plusOne(number: Int) -> Int {
        return 1 + number
    }
    
    return plusOne
}
let incrementer = createIncrementer()
incrementer(10)

// function as parameter
func hasAnyMatches(_ list: [Int], matcher: (Int) -> Bool) -> Bool {
    for item in list {
        if matcher(item) {
            return true
        }
    }
    
    return false
}

func lessThanThen(number: Int) -> Bool {
    return number < 10
}

hasAnyMatches([20, 10, 7, 12], matcher: lessThanThen)

// closure
hasAnyMatches([20, 10, 7, 12]) { (item: Int) -> Bool in
    item < 10
}
[20, 10, 7, 12].map { (item: Int) -> Int in
    return 3 * item
}
[20, 10, 7, 12].map({ item in 3 * item })

// 省略 () 如果 Closure 是唯一的参数
let sortedNumbers = [20, 10, 7, 12].sorted { $0 > $1 }
print(sortedNumbers)

// Objects and Classes
class Shape {
    var numberOfSides = 0
    
    func simpleDescription() -> String {
        return "A shap with \(numberOfSides) sides."
    }
}
let shape = Shape()
shape.numberOfSides = 10
shape.simpleDescription()

// inherit
class NamedShape : Shape {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}

// inherit and override
class Square: NamedShape {
    var sideLength: Double
    
    init(sideLength: Double, name: String) {
        self.sideLength = sideLength
        super.init(name: name)
        numberOfSides = 4
    }
    
    func area() -> Double {
        return sideLength * sideLength
    }
    
    override func simpleDescription() -> String {
        return "A square with sides of length \(sideLength)"
    }
}

let square = Square(sideLength: 10.0, name: "Jian's Square")
square.area()
square.simpleDescription()

// getter setter
class EquilateralTriangle: NamedShape {
    var sideLength: Double = 0.0
    
    init(sideLength: Double, name: String) {
        self.sideLength = sideLength
        super.init(name: name)
        numberOfSides = 3
    }
    
    var perimeter: Double {
        get {
            return 3.0 * sideLength
        }
        set {
            sideLength = newValue / 3.0
        }
    }
    
    override func simpleDescription() -> String {
        return "An equilateral triangle with sides of length \(sideLength)"
    }
}
var triangle = EquilateralTriangle(sideLength: 3.1, name: "A triangle")
print(triangle.perimeter)
print(triangle.perimeter = 9.9)
print(triangle.sideLength)


class TriangleAndSquare {
    var triangle: EquilateralTriangle {
        willSet {
            square.sideLength = newValue.sideLength
        }
    }
    
    var square: Square {
        willSet {
            triangle.sideLength = newValue.sideLength
        }
    }
    
    init(size: Double, name: String) {
        square = Square(sideLength: size, name: name)
        triangle = EquilateralTriangle(sideLength: size, name: name)
    }
}

var triangleAndSquare = TriangleAndSquare(size: 10, name: "other shape")
print(triangleAndSquare.square.sideLength)
print(triangleAndSquare.triangle.sideLength)

triangleAndSquare.square = Square(sideLength: 50, name: "Large square")
print(triangleAndSquare.triangle.sideLength)

let optionalSquare: Square? = Square(sideLength: 2.5, name: "optional square")
let sideLength = optionalSquare?.sideLength
let nilSquare: Square? = nil
let nilLength = nilSquare?.sideLength

// Enumerations and Structures

enum Level: Int {
    case Zero, First, Second
}
Level.Zero.rawValue
Level.First.rawValue

// no rawValue
enum Suit {
    case spades, hearts, diamonds, clubs
    func simpleDescription() -> String {
        switch self {
        case .spades:
            return "spades"
        case .hearts:
            return "hearts"
        case .diamonds:
            return "diamonds"
        case .clubs:
            return "clubs"
        }
    }
}

enum Rank: Int {
    case ace = 1
    case two, three, four, five, six, seven, eight, nine, ten
    case jack, queen, king
    
    func simpleDescription() -> String {
        switch self {
        case .ace:
            return "ace"
        case .jack:
            return "jack"
        case .queen:
            return "queen"
        case .king:
            return "king"
        default:
            return String(self.rawValue)
        }
    }
}
let ace = Rank.ace
let aceRawValue = ace.rawValue

if let convertedRank = Rank(rawValue: 3) {
    let threeDescription = convertedRank.simpleDescription()
}


enum ServerResponse {
    case result(String, String)
    case failure(String)
}

let success = ServerResponse.result("6:00 am", "8:00 pm")
let failure = ServerResponse.failure("Out of cheese")

switch success {
case let .result(sunrise, sunset):
    print("Sunrise is at \(sunrise) and sunset is at \(sunset)")
case let .failure(message):
    print("Failure ... \(message)")
}

// struct
// structures 和 classes 最重要的区别
// struct: 传递值，总是传递 copy
// class: 传递引用
struct Card {
    var rank: Rank
    var suit: Suit
    
    func simpleDescript() -> String {
        return "The \(rank.simpleDescription()) of \(suit.simpleDescription())"
    }
}
let threeOfSpades = Card(rank: .three, suit: .spades)
print(threeOfSpades.simpleDescript())

// Protocols and Extensions
// class, enumn, struct 都可以实现 protocol
protocol ExampleProtocol {
    var simpleDescription: String { get }
    mutating func adjust()
}

class SimpleClass: ExampleProtocol {
    var simpleDescription: String = "A simple class."
    var moreProperty: Int = 315
    func adjust() {
        simpleDescription += " Now 100% adjusted"
    }
}
var simpleClass = SimpleClass()
simpleClass.adjust()
print(simpleClass.simpleDescription)

// mutating 表示当前方法可以修改 structure
struct SimpleStructure: ExampleProtocol {
    var simpleDescription: String = "A simple structure"
    mutating func adjust() {
        simpleDescription += " (adjusted) "
    }
}

var simpleStruct = SimpleStructure()
simpleStruct.adjust()
print(simpleStruct.simpleDescription)

// Extensions 类似 ruby 的 OpenClass
extension Int: ExampleProtocol {
    var simpleDescription: String {
        return "The number \(self)"
    }
    
    mutating func adjust() {
        self += 10
    }
}

print(7.simpleDescription)

// 类似 Java 的类型系统 向上转型
let protocolValue: ExampleProtocol = simpleStruct
print(protocolValue.simpleDescription)

// Error Handling
enum PointerError: Error {
    case outOfPaper
    case noToner
    case onFire
}

// throw error
func send(job: Int, toPointer printerName: String) throws -> String {
    if printerName == "Never has toner" {
        throw PointerError.noToner
    }
    return "Job sent"
}

// do { try ... } catch {}
do {
    let pointerResp = try send(job: 1024, toPointer: "Never has toner")
    print(pointerResp)
} catch { // catch all errors
    print(error) // use error by default
}

// mutiple catch
do {
    let pointerResponse = try send(job: 1024, toPointer: "Jian")
    print(pointerResponse)
    throw PointerError.onFire
    
} catch PointerError.onFire {
    print("I'll just put shi over here, with the result of the fire.")
} catch let pointerError as PointerError {
    print("Printer error: \(pointerError) .")
} catch {
    print(error)
}

// try? -> Optional
let pointerFailure = try? send(job: 1024, toPointer: "Never has toner")
let pointerSuccess = try? send(job: 2048, toPointer: "Good pointer")

// defer, to write a block of code that is executed after all other code in the function, just before the function returns;  it seems try {} catch {} finally {} in Java, begin {} rescure {} ensure {} in Ruby



// Generics - 泛型
func makeArray<Item>(repeating item: Item, numberOfTimes: Int) -> [Item] {
    var ret = [Item]()
    for _ in 0..<numberOfTimes {
        ret.append(item)
    }
    
    return ret
}
makeArray(repeating: "ha ", numberOfTimes: 4)
makeArray(repeating: 2, numberOfTimes: 4)

// Generic => functions, methods, as well as classes, enum, structures.  it's same as Java
enum OptionalValue<Wrapped> {
    case none
    case some(Wrapped)
}
var possibleInteger: OptionalValue<Int> = .none
possibleInteger = .some(100)

// where to specify a list of requirements
func anyCommonElements<T: Sequence, U: Sequence>(_ lhs: T, _ rhs: U) -> Bool
    where T.Iterator.Element: Equatable, T.Iterator.Element == U.Iterator.Element {
        
        for lhsItem in lhs {
            for rhsItem in rhs {
                if lhsItem == rhsItem {
                    return true
                }
            }
        }
        
        return false
}
anyCommonElements([1,2,3,4,5], [5])






