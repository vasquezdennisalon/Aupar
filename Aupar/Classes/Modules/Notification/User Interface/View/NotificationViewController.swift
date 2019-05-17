//
//  NotificationViewController.swift
//  Aupar
//
//  Created by Denis Vásquez on 5/16/19.
//  Copyright © 2019 Denis Vásquez. All rights reserved.
//

import UIKit

final class NotificationViewController: UIViewController {
    var presenter: NotificationPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
}

extension NotificationViewController: NotificationViewProtocol {
    
}
