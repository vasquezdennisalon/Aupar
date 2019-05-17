//
//  TabBarModulePresenter.swift
//  Aupar
//
//  Created by Denis Vásquez on 5/16/19.
//  Copyright © 2019 Denis Vásquez. All rights reserved.
//

import Foundation

class TabBarModulePresenter: TabBarModulePresenterProtocol, TabBarModuleInteractorOutputProtocol
{
    weak var view: TabBarModuleViewProtocol?
    var interactor: TabBarModuleInteractorInputProtocol?
    var wireFrame: TabBarModuleWireFrameProtocol?
    
    init() {}
}
