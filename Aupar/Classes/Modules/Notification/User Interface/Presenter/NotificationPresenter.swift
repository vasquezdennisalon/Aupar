//
//  NotificationPresenter.swift
//  Aupar
//
//  Created by Denis Vásquez on 5/16/19.
//  Copyright © 2019 Denis Vásquez. All rights reserved.
//

import Foundation

class NotificationPresenter: NotificationPresenterProtocol {
    weak var view: NotificationViewProtocol?
    var interactor: NotificationInteractorInputProtocol?
    var wireFrame: NotificationWireFrameProtocol?
    
    func viewDidLoad() {
        
    }
}

extension NotificationPresenter: NotificationInteractorOutputProtocol {
    
}
