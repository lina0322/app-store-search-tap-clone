//
//  ViewController.swift
//  App-Store-Search-Tap-Clone
//
//  Created by 최원석 on 2021/08/22.
//

import UIKit

class ViewController: UIViewController {

    var parameters: [String: String] = ["term" : "카카오톡", "country" : "kr", "media" : "software"]

    override func viewDidLoad() {
        super.viewDidLoad()

        ServiceProvider.shared.getDataTest(parameters: self.parameters) { responseObjects in
            print(responseObjects)
        }
    }
}
