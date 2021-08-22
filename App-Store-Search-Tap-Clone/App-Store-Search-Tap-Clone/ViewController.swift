//
//  ViewController.swift
//  App-Store-Search-Tap-Clone
//
//  Created by 최원석 on 2021/08/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()


        ServiceProvider.shared.getDataTest { TestModel in
            print(TestModel)
        }
    }
}
