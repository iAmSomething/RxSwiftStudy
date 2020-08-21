//
//  MemoryStorage.swift
//  simpleMemo
//
//  Created by 김태훈 on 2020/08/19.
//  Copyright © 2020 kimtaehoon. All rights reserved.
//

import Foundation
import RxSwift

class MemoryStorage : MemoStorageType {
  
  private var list :[Memo] = [
    Memo(content: "hello", insertDate: Date().addingTimeInterval(-20)),
    Memo(content: "hhhhhhaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa", insertDate: Date().addingTimeInterval(-30)),
    Memo(content: "이미지가 들어갈 수 있는지 확인", insertDate: Date().addingTimeInterval(-40), thumbnail: UIImage.init(named: "btnClose") ?? UIImage())
    ]
  
  private lazy var sectionModel = MemoSectionModel(model: 0, items: list)
  private lazy var store = BehaviorSubject<[MemoSectionModel]>(value: [sectionModel])
  // 기본값을 list로 하기 위해 lazy 키워드 사용
  @discardableResult
  func createMemo(content: String) -> Observable<Memo> {
    let memo = Memo(content: content)
    sectionModel.items.insert(memo, at: 0)
    sectionModel.items.sort(by: <)
    store.onNext([sectionModel])
    return Observable.just(memo)
  }
  @discardableResult
  func memoList() -> Observable<[MemoSectionModel]> {
    sectionModel.items.sort(by: <)
    return store // 클래스 외부에서는 항상 이 메소드를 통해 접근합니다.
  }
  @discardableResult
  func update(memo: Memo, content: String) -> Observable<Memo> {
    let updated = Memo(original: memo, updateContent: content) // 업데이트될 메모를 선언
    
    if let index = sectionModel.items.firstIndex(where: { $0 == memo}) { // memo와 같은 메모를 찾는다
      sectionModel.items.remove(at: index) // 메모를 삭제
      sectionModel.items.insert(updated, at: index) // 그 자리에 메모를 삽입
    }
    sectionModel.items.sort(by: <)
    store.onNext([sectionModel])
    return Observable.just(updated)
  }
  
  
  @discardableResult
  func favorateToggle(memo: Memo, toggle: Bool) -> Observable<Memo> {
    var fav = Memo(content: memo.content, toggle: toggle)
    if let index = sectionModel.items.firstIndex(where : { $0 == memo}){
      fav.insertDate = sectionModel.items[index].insertDate
      fav.identity = sectionModel.items[index].identity
      sectionModel.items.remove(at: index)
      sectionModel.items.insert(fav, at: index)
    }
    sectionModel.items.sort(by: <)
    store.onNext([sectionModel])
    return Observable.just(fav)
  }
  @discardableResult
  func delete(memo: Memo) -> Observable<Memo> {
    if let index = sectionModel.items.firstIndex(where: { $0 == memo}) {
      sectionModel.items.remove(at: index)
    }// memo와 같은 메모를 찾는다
    store.onNext([sectionModel])
    return Observable.just(memo)
  }
}
