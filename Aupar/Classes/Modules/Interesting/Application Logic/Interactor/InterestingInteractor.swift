//
//  InterestingInteractor.swift
//  Aupar
//
//  Created by Denis Vásquez on 5/16/19.
//  Copyright © 2019 Denis Vásquez. All rights reserved.
//

import Foundation

class InterestingInteractor: InterestingInteractorInputProtocol {
    
    var localDatamanager: InterestingLocalDataManagerInputProtocol?
    weak var presenter: InterestingInteractorOutputProtocol?
    var remoteDatamanager: InterestingRemoteDataManagerInputProtocol?
}
