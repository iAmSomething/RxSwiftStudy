//
//  Memo.swift
//  simpleMemo
//
//  Created by 김태훈 on 2020/08/19.
//  Copyright © 2020 kimtaehoon. All rights reserved.
//

import Foundation
import UIKit
import RxDataSources

struct Memo : Equatable, Comparable , IdentifiableType{
  
  static func < (lhs: Memo, rhs: Memo) -> Bool {
    if !((lhs.favorate != rhs.favorate) && rhs.favorate){
      if lhs.favorate == rhs.favorate {
        return lhs.insertDate > rhs.insertDate
      }
      return true
    }
    else {
      return false
    }
  }
  
  var content : String
  var insertDate : Date
  var identity : String // 식별자 역할
  var thumbnail : UIImage
  var favorate : Bool
  
  init(content:String, insertDate:Date = Date(), thumbnail : UIImage = UIImage(), toggle : Bool = false) {
    self.content = content
    self.insertDate = insertDate
    self.identity = "\(insertDate.timeIntervalSinceReferenceDate)" // 타임인터벌 값
    self.thumbnail = thumbnail
    self.favorate = toggle
  }
  init (original : Memo, updateContent :String, thumbnail : UIImage = UIImage()) { // 업데이트된 내용으로 새로운 인스턴스를 생성
    self = original
    self.content = updateContent
    //thumbnail.size.equalTo(CGSize(width: 30, height: 30))
    self.thumbnail = thumbnail
  }
}
