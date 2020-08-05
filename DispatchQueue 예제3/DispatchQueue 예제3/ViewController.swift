//
//  ViewController.swift
//  DispatchQueue 예제3
//
//  Created by 김태훈 on 2020/08/05.
//  Copyright © 2020 kimtaehoon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var randImg: UIImageView!
  @IBOutlet weak var duration: UILabel!
  
  var counter : Int = 0
  let IMG_URL = "https://picsum.photos/1280/720/?random"
  override func viewDidLoad() {
    super.viewDidLoad()
    Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true){ _ in
      self.counter += 1
      self.duration.text = "시간 : \(self.counter)"
    }
    // Do any additional setup after loading the view.
  }

  @IBAction func syncBtn(_ sender: Any) {
    let image = loadImg(from: IMG_URL)
    randImg.image = image
  }
  
  @IBAction func asyncBtn(_ sender: Any) {
    DispatchQueue.global().async {
      //global dispatch queue 
      let image = self.loadImg(from: self.IMG_URL)
      DispatchQueue.main.async {
        // UI를 변경하는 경우 main thread에서만 사용이 가능하다.
        self.randImg.image = image
      }
    }
  }
  private func loadImg(from imageUrl:String) -> UIImage? {
    guard let url = URL(string: imageUrl) else {
      return nil
    }
    guard let data = try? Data(contentsOf: url) else {return nil}
    let image = UIImage(data: data)
    return image
  }
}

