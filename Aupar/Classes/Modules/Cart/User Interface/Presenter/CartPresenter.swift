//
//  CartPresenter.swift
//  Aupar
//
//  Created by Denis Vásquez on 5/16/19.
//  Copyright © 2019 Denis Vásquez. All rights reserved.
//

import Foundation

class CartPresenter: CartPresenterProtocol {
    weak var view: CartViewProtocol?
    var interactor: CartInteractorInputProtocol?
    var wireFrame: CartWireFrameProtocol?
    
    func viewDidLoad() {
        
    }
}

extension CartPresenter: CartInteractorOutputProtocol {
    
}
