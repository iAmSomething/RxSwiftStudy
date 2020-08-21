//
//  MomoComposeViewController.swift
//  simpleMemo
//
//  Created by 김태훈 on 2020/08/19.
//  Copyright © 2020 kimtaehoon. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Action
import NSObject_Rx


class MomoComposeViewController: UIViewController , ViewModelBindableType{
  @IBOutlet weak var cancelBtn: UIBarButtonItem!
  @IBOutlet weak var saveBtn: UIBarButtonItem!
  @IBOutlet weak var contentTextView: UITextView!
  var viewModel : MemoComposeViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
  func bindViewModel() {
    viewModel.title
      .drive(navigationItem.rx.title)
      .disposed(by: rx.disposeBag)
    
    viewModel.initialText
      .drive(contentTextView.rx.text)
      .disposed(by: rx.disposeBag)
    
    cancelBtn.rx.action = viewModel.cancelAction
    saveBtn.rx.tap
      .throttle(.milliseconds(500), scheduler: MainScheduler.instance)
      .withLatestFrom(contentTextView.rx.text.orEmpty)
      .bind(to : viewModel.saveAction.inputs)
      .disposed(by: rx.disposeBag)
  }
  
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    contentTextView.becomeFirstResponder()
  }
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    if contentTextView.isFirstResponder {
      contentTextView.resignFirstResponder()
    }
  }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
