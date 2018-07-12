//: [Previous](@previous)

import UIKit
import PlaygroundSupport

/*:
 ### Playground live view
*/


/*:
 ## Markup support
 
 This is the cool feature for showing something to people.
 it's like a markdown article
 
 1. This is a markdown list
 
 Links
 
 Menue
 [Previous](@previouse)
*/

/*:
 ### Source
 - How to add new swift file?
 - How to add a new library?
 - How to add resources?
*/

"Incremental executing code"
"This is cool"
"Change the lines between blue line, playground won't be reset"

/*:
 The playground support the feature like Lisp REPL
*/
"Shift-Return to run up to current line"

/*:
 - Create a follow-along tutorial for your API
 - Explore data or any thing
 - Play something line by line
*/
"Import Library ?"
"Provide the playground for library presentation"

enum Emotion {
    case hmmm
    case haha
}

extension Emotion: CustomPlaygroundDisplayConvertible {
    
    var playgroundDescription: Any {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 120, height: 80))
        switch self {
        case .hmmm:
            label.text = "呵呵"
        case .haha:
            label.text = "哈哈"
        }
        
        return label
    }
}

let emotion: Emotion = .hmmm


/*:
 ### Idea

 Import workspace to playground, it suppose to be used in exploration of library
 - Let's try with CommonUI playground
*/

//: [Next](@next)
