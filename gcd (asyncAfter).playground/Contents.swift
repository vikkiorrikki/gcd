import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

class SafeArray<Element> {
    private var array = [Element]()
    private let queue = DispatchQueue(label: "DispatchBarrier", attributes: .concurrent)
    
    public func append(element: Element) {
        queue.async(flags: .barrier) { //никакие другие операции не выполняются в очереди, пока выполняется барьер
            self.array.append(element)
        }
    }
    
    public var elements: [Element] {
        var result = [Element]()
        queue.sync { //здесь не нужен барьер, тк синхронно выполняются таски в очереди
            result = self.array
        }
        
        return result
    }
}

var safeArray = SafeArray<Int>()
DispatchQueue.concurrentPerform(iterations: 10) { (index) in //делает параллельные запросы, то есть порядок элементов в массиве от 0 до 9 не гарантирован, но набор будет гарантирован
    safeArray.append(element: index)
}
print("safeArray: \(safeArray.elements)")


var array = [Int]()
DispatchQueue.concurrentPerform(iterations: 10) { (index) in //делает параллельные запросы
    array.append(index)
}
print("array: \(array)")
