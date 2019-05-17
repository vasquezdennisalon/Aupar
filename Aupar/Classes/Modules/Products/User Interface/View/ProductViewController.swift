//
//  ProductViewController.swift
//  Aupar
//
//  Created by Denis Vásquez on 5/16/19.
//  Copyright © 2019 Denis Vásquez. All rights reserved.
//

import UIKit

final class ProductViewController: UIViewController {
    var presenter: ProductPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
}

extension ProductViewController: ProductViewProtocol {
    
}
