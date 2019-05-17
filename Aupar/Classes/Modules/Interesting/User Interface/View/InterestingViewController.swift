//
//  InterestingViewController.swift
//  Aupar
//
//  Created by Denis Vásquez on 5/16/19.
//  Copyright © 2019 Denis Vásquez. All rights reserved.
//

import UIKit

final class InterestingViewController: UIViewController {
    var presenter: InterestingPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
}

extension InterestingViewController: InterestingViewProtocol {
    
}
