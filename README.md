# SyncAsync
swift에서 동기/비동기 처리를 다루는 경우 RxSwift등의 외부 라이브러리를 사용하여 간단하게 처리할 수 있다는 것을 알게 되었습니다. 더 나아가 MVC 패턴에서 MVVM 방식으로의 변화에 대해서 공부하기 위해 동기/비동기 방식의 프로그래밍에 관심을 가져야 겠다고 생각해 공부를 시작하게 되었습니다. 비동기 프로그래밍에 도움을 주는 라이브러리나 프레임워크는 사용하기는 쉽지만, 결과적으로 더 low level에서 동작하는 원리를 이해하는게 중요하다고 생각되어 RxSwift에 국한되지 않고 여러 방식으로 코드를 작성해보려고 합니다.

## 개념

운영체제를 공부하며 혹은 데이터통신을 공부하며 이미 많은 분들이 배웠듯, 동기 방식과 비동기 방식이 있습니다. 간단하게 설명을 해보자면 다음과 같습니다.

##### 동기 방식

- client에서 server로 요청을 할 경우 응답을 받아야지 다음 동작이 이루어지는 방식입니다.

- server에서 응답하는 데이터가 client의 다음 요청에 영향을 주는 경우? 쉽게 말해 순서가 있는 경우에 사용될 수 있습니다.

#####  비동기 방식

-  client에서 server로 요청을 할 경우 응답 여부와 상관 없이 다음 요청을 하는 경우입니다.

- 요청의 응답 대기 시간에 다른 요청을 하면서 처리 속도가 올라갑니다. 일부 데이터만 변경한다던지, 다음 요청에 영향을 주지 않는 경우 비동기식을 사용할 수 있습니다.

작업 큐에 프로세서를 넣어 다른 스레드에서 작업을 수행시키고 필요에 따라 메인 스레드를 호출하여 수행시키면서 병렬적으로 프로세스를 진행시키는 방식이 비동기 프로그래밍이라고 볼 수 있을 것 같습니다.

# Swift에서 

## Operation, OperationQueue

#### Operation

**Operation객체**는 앱에서 수행 할 작업을 캡슐화하는데 사용하는 **Foundation프레임워크**의 **NSOperation클래스**의 인스턴스입니다. 

Operation객체는 다음과 같은 주요 기능을 지원합니다.

- Operation객체간의 그래프 기반 종속성 설정 지원, 종속된 모든 작업이 실행을 완료할 때 까지 주어진 Operation이 실행되는 것을 방지합니다.
- Operation의 main task가 완료된 후에 실행되는 optional completion블록을 지원합니다.
- KVO알림을 사용하여 operation의 실행 상태 변경 모니터링을 지원합니다.
- Operation우선 순위 지정을 지원하여 실행 순서에 영향을 줍니다.
- 실행 중 조작을 정지할 수 있는 canceling semantics기능을 지원합니다.

Operation은 앱의 동작을 캡슐화하는 좋은 방법입니다. 앱의 main thred에서 코드를 실행하는 대신 여러 operation을 큐에 제출하고 여러 쓰레드에서 작업을 비동기적으로 수행할 수 있습니다. 일반적으로 OperationQueue 클래스의 인스턴스에 작업을 추가하여 작업을 실행합니다.

만약 OperationQueue를 사용하지 않는다면 코드에서 직접 start()메서드를 호출하여 직접적으로 작업을 실행시킬 수 있습니다. 작업을 수동으로 실행하면 여러가지 예외사항이 발생할 수 있으므로 코드에 많은 부담이 갈 수 있습니다. isReady 프로퍼티는 Operation의 준비 상태에 대해 보고함으로써 Operation이 준비 상태일 경우에 작업을 수행하도록 돕습니다.

##### Operation 종속성

종속성을 이용하여 작업을 특정 순서대로 수행할 수 있습니다. **addDependency(_ :)**와 **removeDependency(_ :)** 등 종속성을 관리하기 위한 여러 메서드들이 있습니다. 

기본적으로 종속성을 가진 작업 개체는 모든 종속 Operations가 실행을 완료할 때 까지 준비되지 않은 것으로 간주됩니다. 마지막 종속 Operation이 끝나면 Operation이 준비되고 실행될 수 있습니다.

##### Asynchronous Versus Synchronous Operations

수동으로 Operation 객체를 실행할 경우 비동기식으로 실행하도록 작업을 설계할 수 있습니다. Operation객체는 기본적으로는 동기식입니다. (default : Synchronous) 동기식 연산에서는 작업을 실행할 별도의 스레드를 만들지 않습니다. 코드에서 start()메소드를 호출하면 즉시 시행됩니다. start 메소드가 caller에게 반환할때 작업이 끝납니다.

Start() 메소드를 비동기적으로 불러오면 다른 작업이 완료되기 전에 반환을 할 수가 있습니다. 따라서 비동기 연산 객체는 별도의 스레드에서 작업을 해야 합니다. 예를 들어 새로운 스레드를 직접 시작하거나 비동기식 앙식으로 블럭을 distpatchqueue에 넣음으로써 비동기식으로 작업을 실행할 수 있습니다.

#### OperationQueue

Operation작업 수행을 관리하는? queue입니다.OperationQueue도 마찬가지로 Foundation프레임워크에 작성되어있습니다. 

OperationQueue는 대기중인 Operation객체의 우선순위 및 준비 정도를 기준으로 작업을 수행합니다. OperationQueue에 Operation이 추가되면 작업이 완료할때까지 남아있습니다. 추가한 operation을 직접적으로 제거할 수 없습니다.

##### 작업 순서 결정하기

OperationQueue내의 작업 순서는 준비 정도, 우선순위 레벨, 상호 동작 의존성에 의해 결정됩니다. 큐 안의 모든 operation들이 같은 queuePriority를 가진다면, 그리고 모든 operation들이 준비 상태라면 큐에 들어온 순서대로 실행됩니다. 그렇지 않으면 OperationQueue는 항상 다른 준비된 작업보다 높은 우선순위를 가지는 작업을 먼저 실행합니다.

작업 준비 상태에 따라 실행 순서가 변경될 수 있으므로 특정 실행 순서를 보장하기 위해서 대기열의 의미에 의존해서는 안됩ㄴ다. 상호 의존성은 다른 OperationQueue에 위치하더라도 절대적인 실행 명령을 제공합니다. 모든 종속된 작업이 완료될 때 까지 Operation을 수행할 준비가 되어 있지 않은 것으로 간주합니다.

## Dispatch Queues

**Grand Central Dispatch(GCD)** 의 dispathQueues는 task수행을 위한 강력한 도구입니다. 이걸 이용하면 caller와 관련하여 동기식/비동기식으로 임의의 코드 블록을 수행할 수 있습니다. Thred code보다 task를 실행할 때 효율적으로 사용할 수 있습니다.

모든 dispatch queues는 FIFO 데이터 구조입니다. 따라서 항상 추가된 순서대로 시작됩니다. GCD는 자동으로 일부 dispatchQueue를 제공합니다.

* **Serial** : Serial queue (private dispatch queue)
  * 큐에 추가된 순서대로 한번에 하나의 task를 수행합니다. 현재 실행중인 task는 dispatch queue에서 관리하는 고유한 쓰레드에서 실행됩니다. Serial queue는 특정 자원에 대한 엑세스를 동기화하는데 사용됩니다. 
  * 필요한 만큼 Serial queue를 작성할 수 있으며 각 큐는 다른 모든 큐와 **동시에**작동합니다. Serial queue를 4개 작성하면 최대 4개의 task가 동시에 실행될 수 있습니다.
* **Concurrent** : Concurrent queues(일종의 global dispatch queue)
  * 동시에 하나 이상의 task를 실행하지만 task는 큐에 추가된 순서대로 계속 시작됩니다. 현재 실행중인 task는 dispatch queue에서 관리하는 **고유한 쓰레드**에서 실행됩니다. 특정 시점에서 실행되는 정확한 task의 수는 가변적이며 시스템 조건에 따라 다릅니다.
  * iOS 5이상에서는 큐의 타입으로 DISPATCH_QUEUE_CONCURRENT를 지정하여 사용자가 동시에 dispatch queue을 생성 할 수 있습니다. 또한 앱에 사용할 사전에 정의된 global concurrent queues가 4개 있습니다.
* **Main dispatch queue** : main dispatch queue
  * 앱의 Main쓰레드에서 task를 실행하는, 전역적으로 사용하는 serial queue입니다. 이 큐는 실행루프와 함께 작동하여 큐에 있는 task의 실행을 실행루프에 연결된 다른 이벤트 소스의 실행과 얽힙니다. 
  * 앱의 main쓰레드에서 실행되므로, main queue는 앱의 주요 동기화 지점으로 사용됩니다. 

dispatch queue를 사용하면 쓰레드 생성 및 관리에 대해 걱정할 필요 없이 실제 수행하려는 작업에 집중할 수 있습니다. 시스템이 쓰레드 생성 및 관리를 처리하기 때문입니다. 

