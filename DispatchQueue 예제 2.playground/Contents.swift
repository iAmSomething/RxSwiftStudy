import UIKit

//let queue1 = DispatchQueue(label: "queue1", qos: .userInteractive)
//let queue2 = DispatchQueue(label: "queue2", qos: .background)
//
//queue1.async {
//  for i in 1...5 {
//    print("🐻 \(i)")
//  }
//}
//queue2.async {
//  for i in 100...105 {
//    print("🦁 \(i)")
//  }
//}



let myQueue = DispatchQueue(label: "myQueue", attributes: .concurrent)
//let item1 = DispatchWorkItem(qos : .userInitiated){
//  for i in 1...5 {
//    print("🐮 \(i)")
//  }
//}
//let item2 = DispatchWorkItem(qos: .utility){
//  for i in 100...105 {
//    print("🐷 \(i)")
//  }
//}
//
//myQueue.async(execute: item2)
//myQueue.async(execute: item1)

let myGroup = DispatchGroup()

myQueue.async(group: myGroup) {
  for i in 100...105 {
    print("🐰 \(i)")
  }
}
myQueue.async(group: myGroup) {
  for i in 1...5 {
    print("🦊 \(i)")
  }
}
myGroup.notify(queue: myQueue) {
  print("end!")
  myQueue.async(group : myGroup , qos: .default){
    for i in 200...205 {
      print("🐨 \(i)")
    }
  }
  myQueue.async(group:myGroup, qos : .userInitiated){
    for i in 300...305 {
      print("🦉 \(i)")
    }
  }
}
