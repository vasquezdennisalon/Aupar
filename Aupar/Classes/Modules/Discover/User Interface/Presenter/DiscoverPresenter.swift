//
//  DiscoverPresenter.swift
//  Aupar
//
//  Created by Denis Vásquez on 5/16/19.
//  Copyright © 2019 Denis Vásquez. All rights reserved.
//

import Foundation
import SwiftyJSON
class DiscoverPresenter: DiscoverPresenterProtocol {
    weak var view: DiscoverViewProtocol?
    var interactor: DiscoverInteractorInputProtocol?
    var wireFrame: DiscoverWireFrameProtocol?
    
    func viewDidLoad() {
        self.interactor?.getDiscover()
    }
    
    func filterDiscover(name:String){
        let interaccionFilter = self.interactor?.filterInteraccion(withName: name)
        self.view?.showInteractions(interacciones: interaccionFilter!)
    }
}

extension DiscoverPresenter: DiscoverInteractorOutputProtocol {
    func getDiscover(_ interacciones: [Interaccion]) {
        self.view?.showInteractions(interacciones: interacciones)
    }
}
