//
//  DiscoverViewController.swift
//  Aupar
//
//  Created by Denis Vásquez on 5/16/19.
//  Copyright © 2019 Denis Vásquez. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

final class DiscoverViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SwipeTableViewCellDelegate,
UISearchBarDelegate {
    
    @IBOutlet weak var tableView : UITableView!
    @IBOutlet weak var searchField: UISearchBar!
    var presenter: DiscoverPresenterProtocol?
    var interactions: [Interaccion] = []
    let disposeBag = DisposeBag()
    @IBOutlet weak var noContent: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let pautaNib = UINib(nibName: "pautaTVC", bundle: nil)
        self.tableView.register(pautaNib, forCellReuseIdentifier: "PTVC")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.searchField.textField?.borderStyle = .none
        self.searchField.textField?.layer.borderWidth = 2.0
        self.searchField.textField?.layer.borderColor = UIColor.white.cgColor
        self.searchField.textField?.backgroundColor = UIColor.white
        self.searchField.textField?.layer.cornerRadius = 18.0
        self.searchField.textField?.layer.masksToBounds = true
        self.searchField.textField?.clipsToBounds = true
        self.searchField.delegate = self
        
        presenter?.viewDidLoad()
        self.configureView()
    }
    
    func configureView() {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 112
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        if orientation == .right {
            
            if let celda = self.tableView.cellForRow(at: indexPath) as? SwipeTableViewCell{
                if let objeto = celda.objeto{
                    if !objeto.favorito{
                        let favAction = SwipeAction(style: .default, title: nil) { action, indexPath in
                            
                        }
                        favAction.image = UIImage(named: "banda-interesante")
                        favAction.backgroundColor = Utilities.shared.azul
                        return [favAction]
                    }else{
                        return nil
                    }
                }else{
                    return nil
                }
            }else{
                return nil
            }
        }else if orientation == .left{
            if let celda = self.tableView.cellForRow(at: indexPath) as? SwipeTableViewCell{
                if let _ = celda.objeto{
                    let reportarAction = SwipeAction(style: .default, title: nil) { action, indexPath in
                        
                    }
                    reportarAction.image = UIImage(named: "banda-reportar")
                    reportarAction.backgroundColor = Utilities.shared.reporting
                    
                    let descartarAction = SwipeAction(style: .default, title: nil) { action, indexPath in
                        self.interactions.remove(at: indexPath.row)
                    }
                    descartarAction.image = UIImage(named: "banda-descartar")
                    descartarAction.backgroundColor = Utilities.shared.descarting
                    return [descartarAction,reportarAction]
                }else{
                    return nil
                }
            }else{
                return nil
            }
        }else{
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeTableOptions {
        var options = SwipeTableOptions()
        if orientation == .right{
            options.expansionStyle = .selection
        }else{
            options.expansionStyle = .destructive
        }
        options.transitionStyle = .border
        return options
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let total = self.interactions.count
        if total == 0{
            UIView.animate(withDuration: 0.2, delay: 0, animations:{
                self.noContent.alpha = 1
            })
        }else if (self.noContent.alpha  > 0){
            UIView.animate(withDuration: 0.2, delay: 0, animations:{
                self.noContent.alpha = 0
            })
        }
        return total
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PTVC", for: indexPath) as! SwipeTableViewCell
        cell.delegate = self
        cell.setObjeto(objeto: self.interactions[indexPath.row])
        return cell
    }
    
    func search(){
        if let txt = self.searchField.text{
            self.presenter?.filterDiscover(name: txt)
        }else{
            self.presenter?.filterDiscover(name: "")
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        search()
    }
}

extension DiscoverViewController: DiscoverViewProtocol {
    func showInteractions(interacciones: [Interaccion]) {
        self.interactions = interacciones
        self.tableView.reloadData()
    }
}
