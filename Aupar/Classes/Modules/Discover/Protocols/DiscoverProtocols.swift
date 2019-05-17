//
//  DiscoverProtocols.swift
//  Aupar
//
//  Created by Denis Vásquez on 5/16/19.
//  Copyright © 2019 Denis Vásquez. All rights reserved.
//

import UIKit
import SwiftyJSON
import RxDataSources

/**** Methods for communication PRESENTER -> VIEW ****/
protocol DiscoverViewProtocol: class {
    var presenter: DiscoverPresenterProtocol? { get set }
    func showInteractions(interacciones: [Interaccion])
}

/**** Methods for communication PRESENTER -> WIREFRAME ****/
protocol DiscoverWireFrameProtocol: class {

}

/**** Methods for communication VIEW -> PRESENTER ****/
protocol DiscoverPresenterProtocol: class {
    var view: DiscoverViewProtocol? { get set }
    var interactor: DiscoverInteractorInputProtocol? { get set }
    var wireFrame: DiscoverWireFrameProtocol? { get set }
    
    func viewDidLoad()
    func filterDiscover(name:String)
}

/**** Methods for communication INTERACTOR -> PRESENTER ****/
protocol DiscoverInteractorOutputProtocol: class {
    func getDiscover(_ interacciones: [Interaccion])
}

/**** Methods for communication PRESENTER -> INTERACTOR ****/
protocol DiscoverInteractorInputProtocol: class {
    var presenter: DiscoverInteractorOutputProtocol? { get set }
    var localDatamanager: DiscoverLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: DiscoverRemoteDataManagerInputProtocol? { get set }
    
    func getDiscover()
    func filterInteraccion(withName name: String) -> [Interaccion]
}

/**** Methods for communication INTERACTOR -> LOCALDATAMANAGER ****/
protocol DiscoverLocalDataManagerInputProtocol: class {
    
}

/**** Methods for communication INTERACTOR -> REMOTEDATAMANAGER ****/
protocol DiscoverRemoteDataManagerInputProtocol: class {
    func getImplementation(callback: @escaping (JSON) -> ())
    func getDiscover(callback: @escaping (JSON) -> ())
}
