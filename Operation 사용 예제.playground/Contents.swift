import UIKit

class MyOperation : Operation{
  let iterations:Int
  let tag:String
  
  init(iterations:Int, tag:String){
    self.iterations = iterations
    self.tag = tag
  }
  override func main() {
    performCalculation(iterations,tag: tag)
  }
  
  func doCalc(){
    var x = 100
    var y = x*x
    _ = y/x
  }
  func performCalculation(_ iterations:Int, tag : String) {
    let start = CFAbsoluteTimeGetCurrent()
    for _ in 0..<iterations {
      self.doCalc()
    }
    let end = CFAbsoluteTimeGetCurrent()
    print("time for \(tag):\(end - start)")
  }
}

let op1 = MyOperation(iterations: 100, tag: "Operation 1")
let op2 = MyOperation(iterations: 1000, tag: "Operation 2")
let op3 = MyOperation(iterations: 10000, tag: "Operation 3")
op1.addDependency(op2)
op1.addDependency(op3)
print(op1.queuePriority.rawValue)

op2.queuePriority = .high
op3.queuePriority = .veryHigh
print(op2.queuePriority.rawValue)
print(op3.queuePriority.rawValue)
op2.start() // 이게 실행되기 전에는 op1은 start를 못함
print(op1.dependencies.first?.isFinished)
print(op1.dependencies.last?.isFinished)
//op1.start()
//let operationQueue = OperationQueue()
//operationQueue.maxConcurrentOperationCount = 1 // 한번에 수행할 수 있는 operation을 1개로 제한하면서 순차적으로 수행한다.
//operationQueue.addOperation(MyOperation(iterations: 100000, tag: "Operation 1"))
//operationQueue.addOperation(MyOperation(iterations: 1000, tag: "Operation 2"))
//operationQueue.addOperation(MyOperation(iterations: 10000, tag: "Operation 3"))
