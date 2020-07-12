import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

let workItem = DispatchWorkItem(qos: .utility, flags: .detached) {
    print("Performing WorkItem")
}

//workItem.perform() //напрямую вызываем напрямую

let queue = DispatchQueue(label: "name of queue", qos: .utility, attributes: .concurrent, autoreleaseFrequency: .workItem, target: DispatchQueue.global(qos: .userInitiated)) //таргет нужен для того, чтобы переназначить очередь для объекта
queue.asyncAfter(deadline: .now() + 1, execute: workItem)

workItem.notify(queue: .main) {
    print("WorkItem is completed!")
}

print(workItem.isCancelled)
workItem.cancel()
print (workItem.isCancelled)

workItem.wait() //код далее не выполняется, пока workItem не выполнит свою работу
