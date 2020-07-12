import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

let queue = DispatchQueue(label: "name", attributes: .concurrent)

//create timer
let timer = DispatchSource.makeTimerSource(queue: queue)

//set timer
timer.schedule(deadline: .now(), repeating: .seconds(2), leeway: .milliseconds(300)) //repeating - как часто таймер должен повторяться, leeway - возможное запаздывание таймера
timer.setEventHandler {
    print("Hello, World!")
}

//create cancel block
timer.setCancelHandler {
    print("Timer is cancelled")
}

timer.resume()
