//
//  SceneCoordinator.swift
//  simpleMemo
//
//  Created by 김태훈 on 2020/08/19.
//  Copyright © 2020 kimtaehoon. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

extension UIViewController {
  var sceneViewController : UIViewController {
    return self.children.first ?? self
  }
}
class SceneCoordinator : SceneCoordinatorType {
  
  private let bag = DisposeBag()
  
  private var window : UIWindow
  private var currentVC : UIViewController
  
  required init (window : UIWindow) {
    self.window = window
    currentVC = window.rootViewController!
  }
  
  @discardableResult
  func transition(to scene: Scene, using style: TransitionStyle, animated: Bool) -> Completable {
    let subject = PublishSubject<Void>()
    
    let target = scene.instantiate()
    
    switch style {
    case .root:
      currentVC = target.sceneViewController
      window.rootViewController = target
      subject.onCompleted()
    case .push:
      guard let navi = currentVC.navigationController else {
        subject.onError(TransitionErr.navigationControllerMissing)
        break
      }
      
      navi.rx.willShow
        .subscribe(onNext : {[unowned self] evt in
          self.currentVC = evt.viewController.sceneViewController
        })
        .disposed(by: bag)
      
      navi.pushViewController(target, animated: animated)
      currentVC = target.sceneViewController
      
      subject.onCompleted()
      
    case .modal :
      currentVC.present(target, animated: animated) {
        subject.onCompleted()
      }
      currentVC = target.sceneViewController
    }
    return subject.ignoreElements()
  }
  @discardableResult
  func close(animated: Bool) -> Completable {
    return Completable.create { [unowned self] completable in
      if let presentingVC = self.currentVC.presentingViewController {
        self.currentVC.dismiss(animated: animated) {
          self.currentVC = presentingVC.sceneViewController
          completable(.completed)
        }
      }
      else if let navi = self.currentVC.navigationController {
        guard navi.popViewController(animated: animated) != nil  else { completable(.error(TransitionErr.connotPop))
          return Disposables.create()
        }
        self.currentVC = navi.viewControllers.last!
        completable(.completed)
      }
      else {
        completable(.error(TransitionErr.unknown))
      }
      return Disposables.create()
    }
  }
}
