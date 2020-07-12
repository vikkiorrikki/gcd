import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

let queue = DispatchQueue(label: "name", attributes: .concurrent)

let semaphore = DispatchSemaphore(value: 2) //количество потоков, которому разрешаем пройти через секцию

queue.async {
    semaphore.wait(timeout: .distantFuture) //ждать будем бесконечно долго до того, как получим сигнал
    Thread.sleep(forTimeInterval: 4)
    print("Block 1")
    semaphore.signal()
}

queue.async {
    semaphore.wait(timeout: .distantFuture) //ждать будем бесконечно долго до того, как получим сигнал
    Thread.sleep(forTimeInterval: 2)
    print("Block 2")
    semaphore.signal()
}

queue.async {
    semaphore.wait(timeout: .distantFuture) //ждать будем бесконечно долго до того, как получим сигнал
    print("Block 3")
    semaphore.signal()
}

queue.async {
    semaphore.wait(timeout: .distantFuture) //ждать будем бесконечно долго до того, как получим сигнал
    print("Block 4")
    semaphore.signal()
}
// так как для семафора разрешено работать в 2х потоках, то 2 потока пойдут выполнять блок 1 и блок 2, но так как 2й блок будет выполняться 2 секунды, а 1й - 4, то 2й блок кода выполнится раньше и 2й поток пойдет выполнять блоки 3 и 4, получается, что за одно время 2й поток выполнит 3 блока кода (2,3,4), пока 1й поток выполняет 4 секунды 1й блок кода


let semaphore2 = DispatchSemaphore(value: 0) //количество потоков, которому разрешаем пройти через секцию
semaphore2.signal()
queue.async {
    semaphore2.wait(timeout: .distantFuture) //ждать будем бесконечно долго до того, как получим сигнал
    Thread.sleep(forTimeInterval: 4)
    print("Block 1")
    semaphore2.signal()
}

queue.async {
    semaphore2.wait(timeout: .distantFuture) //ждать будем бесконечно долго до того, как получим сигнал
    Thread.sleep(forTimeInterval: 2)
    print("Block 2")
    semaphore2.signal()
}

queue.async {
    semaphore2.wait(timeout: .distantFuture) //ждать будем бесконечно долго до того, как получим сигнал
    print("Block 3")
    semaphore2.signal()
}

queue.async {
    semaphore2.wait(timeout: .distantFuture) //ждать будем бесконечно долго до того, как получим сигнал
    print("Block 4")
    semaphore2.signal()
}

// здесь таски будут выполняться по порядку, так как мы для семафора поставили значение 0, но потом дали 1 сигнал, тем самым давая выполнять задачи в одном потоке
