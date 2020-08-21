//
//  MemoStrorageType.swift
//  simpleMemo
//
//  Created by 김태훈 on 2020/08/19.
//  Copyright © 2020 kimtaehoon. All rights reserved.
//

import Foundation
import RxSwift
protocol MemoStorageType {
  @discardableResult // 결과물이 필요없을수도 있을때
  func createMemo(content:String) -> Observable<Memo>
  
  @discardableResult
  func memoList() -> Observable<[MemoSectionModel]>
  
  @discardableResult
  func update(memo : Memo , content :String) -> Observable<Memo>
  
  @discardableResult
  func favorateToggle(memo : Memo, toggle : Bool) -> Observable<Memo>
  
  @discardableResult
  func delete(memo : Memo) -> Observable<Memo>
}
