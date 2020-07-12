import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

let queue = DispatchQueue(label: "queue", attributes: .concurrent)
let group = DispatchGroup()

queue.async(group: group) {
    for i in 0...10 {
        if i == 10 {
            print(i)
        }
    }
}

queue.async(group: group) {
    for i in 0...20 {
        if i == 20 {
            print(i)
        }
    }
}

group.notify(queue: .main) { //этот метод выполняется только после того, как закончат выполнение ВСЕ блоки кода с группами (двже последующие)
    print("The end in group \(group)")
}

let secondGroup = DispatchGroup()
secondGroup.enter()
queue.async(group: group) {
    for i in 0...30 {
        if i == 30{
            print(i)
            sleep(2)
            secondGroup.leave()
        }
    }
}

let result = secondGroup.wait(timeout: .now() + .seconds(3))
print(result)

secondGroup.notify(queue: .main) {
    print("The end in 2nd group")
}

print("Inpedendent print")

secondGroup.wait() //код далее не будет выполняться, пока не выполнится код из 2й группы

print("Inpedendent print2")
