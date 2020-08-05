import UIKit

//DispatchQueue.global().async {
//  for i in 1...5 {
//    print("\(i)🐱")
//  }
//  print ("=================")
//}
//
//
//DispatchQueue.global().async {
//  for i in 1...5 {
//    print("\(i)🐶")
//  }
//  print ("=================")
//}

let myQueue = DispatchQueue(label: "내큐")
myQueue.async {
  for i in 1...5 {
     print("\(i)🐶")
   }
   print ("=================")
}
myQueue.async {
  for i in 1...5 {
     print("\(i)🐱")
   }
   print ("=================")
}

for i in 100...105{
  print("\(i)🐰")
}


let myWorkItem = DispatchWorkItem {
  for i in 1...5 {
    print("DispatchWorkItem \(i)")
  }
}

DispatchQueue.global().async(execute: myWorkItem)
