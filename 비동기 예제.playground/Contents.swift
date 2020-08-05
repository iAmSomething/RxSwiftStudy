import UIKit
import Foundation
let block = BlockOperation{
  var res = 0
  for i in 1...10{
    print("block1 : \(i)")
    res += i
  }
  print(res)
}

block.addExecutionBlock {
  var res = 0
  for i in 1...50 {
    if i % 2 == 1 {
      print("block2 : \(i)")
      res += i
    }
  }
  print(res)
}
block.start()
print(block.isAsynchronous)

block.waitUntilFinished()


//let block2 = BlockOperation {
//  var res = 0
//  for i in 1...50 {
//    if i % 2 == 1 {
//      print("block2 : \(i)")
//      res += i
//    }
//  }
//  print(res)
//}
//
//let queue = OperationQueue()
//queue.addOperations([block, block2], waitUntilFinished: true)
