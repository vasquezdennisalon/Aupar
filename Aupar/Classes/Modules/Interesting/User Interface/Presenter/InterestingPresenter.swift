//
//  InterestingPresenter.swift
//  Aupar
//
//  Created by Denis Vásquez on 5/16/19.
//  Copyright © 2019 Denis Vásquez. All rights reserved.
//

import Foundation

class InterestingPresenter: InterestingPresenterProtocol {
    weak var view: InterestingViewProtocol?
    var interactor: InterestingInteractorInputProtocol?
    var wireFrame: InterestingWireFrameProtocol?
    
    func viewDidLoad() {
        
    }
}

extension InterestingPresenter: InterestingInteractorOutputProtocol {
    
}
