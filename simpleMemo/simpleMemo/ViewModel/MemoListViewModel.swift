//
//  MemoListViewModel.swift
//  simpleMemo
//
//  Created by 김태훈 on 2020/08/19.
//  Copyright © 2020 kimtaehoon. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Action
import RxDataSources
//뷰모델의 구성요소
//1. 의존성 주입 - 셍성자
//2. 바인딩 - 속성/ 메서드

typealias MemoSectionModel = AnimatableSectionModel<Int, Memo>

class MemoListViewModel : CommonViewModel{
  
  let dataSource : RxTableViewSectionedAnimatedDataSource<MemoSectionModel> = {
    let ds = RxTableViewSectionedAnimatedDataSource<MemoSectionModel>(configureCell: {(dataSource, tableView, indexPath,memo) -> UITableViewCell in
      let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for : indexPath) as! TableViewCell
      cell.textLabel?.text = memo.content
      if memo.favorate {
        cell.favorateBtn.setImage(UIImage.init(named: "storeDetailIcStarActive"), for: .normal)
      }
      else {
        cell.favorateBtn.setImage(UIImage.init(named: "storeDetailIcStarInactive"), for: .normal)
      }
      cell.Title.text = memo.content
      cell.thumbNail.image = memo.thumbnail
//      cell.favorateBtn.rx.action = toggleFavorate(memo: memo)
      return cell
    })
    ds.canEditRowAtIndexPath = { _, _ in return true}
    return ds
  }()
  var memoList : Observable<[MemoSectionModel]> {
    return storage.memoList()
  }
  
  func performUpdate(memo : Memo) -> Action<String, Void> {
    return Action { input in
      return self.storage.update(memo: memo, content: input).map{_ in}
    }
  }
  func performCancel(memo : Memo) -> CocoaAction{
    return Action {
      return self.storage.delete(memo: memo).map{_ in}
    }
  }
  func toggleFavorate(memo : Memo) -> CocoaAction{
    return Action {
      return self.storage.favorateToggle(memo: memo, toggle: !memo.favorate).map{_ in}
    }
  }
  func makeCreateAction() -> CocoaAction {
    return CocoaAction { _ in
      return self.storage.createMemo(content: "")
        .flatMap {memo -> Observable<Void> in
          let composeViewModel = MemoComposeViewModel(title: "메모 편집", content:memo.content, sceneCoordinator: self.sceneCoordinator, storage: self.storage, saveAction: self.performUpdate(memo: memo), cancelAction: self.performCancel(memo: memo))
          let composeScene = Scene.compose(composeViewModel)
          return self.sceneCoordinator.transition(to: composeScene, using: .modal, animated: true).asObservable().map{_ in}
      }
    }
  }
  lazy var detailAction : Action<Memo, Void> = {
    return Action { memo in
      let detailViewModel = MemoDetailViewModel(memo: memo, title: "메모 보기", sceneCoordinator: self.sceneCoordinator, storage: self.storage)
      let detailScene = Scene.detail(detailViewModel)
      return self.sceneCoordinator.transition(to: detailScene, using: .push, animated: true).asObservable().map {_ in }
    }
  }()
  
  lazy var deleteAction : Action<Memo, Swift.Never> = {
    return Action { memo in
      return self.storage.delete(memo: memo).ignoreElements()
    }
  }()
  
//  lazy var composeAction : Action<Memo, Void> = {
//    return Action { memo in
//      let composeViewModel = MemoComposeViewModel(title: <#String#>, sceneCoordinator: <#SceneCoordinatorType#>, storage: <#MemoStorageType#>)
//      let composeScene = Scene.compose(composeViewModel)
//      return self.sceneCoordinator.transition(to: composeScene, using: .modal, animated: true).asObservable().map{_ in}
//    }
//  }()

}

  
