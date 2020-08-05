//
//  ViewController.swift
//  MVVMExample
//
//  Created by 김태훈 on 2020/08/05.
//  Copyright © 2020 kimtaehoon. All rights reserved.
//

import UIKit
import RxSwift
class ViewController: UIViewController {
  @IBOutlet weak var idTfLen: UILabel!
  @IBOutlet weak var pwTf: UITextField!
  @IBOutlet weak var idTf: UITextField!
  @IBOutlet weak var loginBtn: UIButton!
  
  let viewModel = LogInViewModel()
  let disposeBag = DisposeBag()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    bindViewModel()
  }
  func bindViewModel(){
    self.idTf.rx.text.orEmpty
      .bind(to: viewModel.idTfChanged)
      .disposed(by: disposeBag)
    self.pwTf.rx.text.orEmpty
      .bind(to: viewModel.pwTfChanged)
      .disposed(by: disposeBag)
    self.loginBtn.rx.tap
      .bind(to: viewModel.logInBtnTouched)
      .disposed(by: disposeBag)
    
    viewModel.result.emit(onNext: { (result) in
      switch result {
      case .success(let user) :
        print(user)
        self.moveToMain()
      case .failure(let err) :
        print(err)
        self.showErr()
      }
    })
    .disposed(by: disposeBag)
  }
  func moveToMain() {
    print("로그인 성공")
  }
  func showErr(){
    print("로그인 실패")
  }

}
