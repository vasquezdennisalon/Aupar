//
//  NotificationInteractor.swift
//  Aupar
//
//  Created by Denis Vásquez on 5/16/19.
//  Copyright © 2019 Denis Vásquez. All rights reserved.
//

import Foundation

class NotificationInteractor: NotificationInteractorInputProtocol {
    
    var localDatamanager: NotificationLocalDataManagerInputProtocol?
    weak var presenter: NotificationInteractorOutputProtocol?
    var remoteDatamanager: NotificationRemoteDataManagerInputProtocol?
}
