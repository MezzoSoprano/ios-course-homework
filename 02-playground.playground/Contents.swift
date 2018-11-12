protocol advancedContainer {
    associatedtype Item
    mutating func removeEl(item: Item) -> Int?
}

extension Array: advancedContainer where Element: Equatable {
    typealias Item = Element
    
    
    mutating func removeEl(item: Element) -> Int? {
        for (index, value) in self.enumerated() {
            if value ==  item {
                self.remove(at: index)
                return index
            }
        }
        return nil
    }
    
    mutating func safeRemove(at position: Int) -> Element? {
        if self.count > position && position >= 0 {
            let temp = self[position]
            self.remove(at: position)
            return temp
        }
        return nil
    }
    
    subscript(safe i: Int) -> Element? {
        if self.count > i && i >= 0 {
            return self[i]
        }
        return nil
    }
    
}

var myArr: Array = [1,34,2,3,6]

//safe getting out of range index
myArr[safe: 5]

//safe deleting elem with index
myArr.safeRemove(at: 5)

//deleting elem by value
myArr.removeEl(item: 34)

