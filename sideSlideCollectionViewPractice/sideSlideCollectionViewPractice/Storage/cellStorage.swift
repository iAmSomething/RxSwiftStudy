//
//  cellStorage.swift
//  sideSlideCollectionViewPractice
//
//  Created by 김태훈 on 2020/08/21.
//  Copyright © 2020 kimtaehoon. All rights reserved.
//

import Foundation
import RxSwift

class cellStorage : CellStorageType {
  private var list : [CellModel] = [
    CellModel(cellImg:UIImage(), cellName: "첫번째 셀", cellSubText: "셀입니다"),
    CellModel(cellImg:UIImage(),cellName: "두번째 셀", cellSubText: "ㅇㅇㅇㅇㅇ"),
  CellModel(cellImg:UIImage(),cellName: "세 번째 셀", cellSubText: "ㅌㅌㅌㅌㅌㅌ")]
  
  private lazy var store = BehaviorSubject<[CellModel]>(value: list)
  @discardableResult
  func createCell(cellImg: UIImage, text: String, subText: String) -> Observable<CellModel> {
    let cell = CellModel(cellName: text, cellSubText: subText)
    list.insert(cell, at: 0)
    list.sort()
    store.onNext(list)
    return Observable.just(cell)
  }
  @discardableResult
  func cellList() -> Observable<[CellModel]> {
    return store
  }
  @discardableResult
  func deleteCell(cell: CellModel) -> Observable<CellModel> {
    if let index = list.firstIndex(where : {$0 == cell}){
      list.remove(at: index)
    }
    store.onNext(list)
    return Observable.just(cell)
  }
}
