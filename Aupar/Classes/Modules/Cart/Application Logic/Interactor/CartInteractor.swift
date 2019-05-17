//
//  CartInteractor.swift
//  Aupar
//
//  Created by Denis Vásquez on 5/16/19.
//  Copyright © 2019 Denis Vásquez. All rights reserved.
//

import Foundation

class CartInteractor: CartInteractorInputProtocol {
    
    var localDatamanager: CartLocalDataManagerInputProtocol?
    weak var presenter: CartInteractorOutputProtocol?
    var remoteDatamanager: CartRemoteDataManagerInputProtocol?
}
