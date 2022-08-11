import UIKit
import Foundation

public extension Array {
    func allTrue(list: [Bool]) -> Bool {
        if list.contains(false) {
            return false
        }
        return true
    }
}


public extension MutableCollection {
    mutating func mutateAll(_ f: (inout Element) throws -> ()) rethrows {
        var i = startIndex
        while i != endIndex {
            try f(&self[i])
            formIndex(after: &i)
        }
    }
}
