//
//  DiscoverInteractor.swift
//  Aupar
//
//  Created by Denis Vásquez on 5/16/19.
//  Copyright © 2019 Denis Vásquez. All rights reserved.
//

import Foundation
import SwiftyJSON
import RxSwift
import RxCocoa
import RxDataSources

class DiscoverInteractor: DiscoverInteractorInputProtocol {
    
    var localDatamanager: DiscoverLocalDataManagerInputProtocol?
    weak var presenter: DiscoverInteractorOutputProtocol?
    var remoteDatamanager: DiscoverRemoteDataManagerInputProtocol?
    
    var interacciones: [Interaccion] = []
    
    func getDiscover() {
        _ = remoteDatamanager?.getDiscover(){
            json_descubre in
            let _interacciones = json_descubre["interacciones"].array
            var interaccionesArray:[Interaccion] = []
            if let interacciones = _interacciones{
                for interaccion in interacciones{
                    let in_id = interaccion["id"].stringValue
                    let in_titulo = interaccion["titulo"].stringValue
                    let in_beacon_id = interaccion["beaconId"].stringValue
                    let in_enfasis = interaccion["enfasis"].stringValue
                    let sector_Id = interaccion["sectorId"].stringValue
                    let in_cupones_sin_canjear = interaccion["cuponesSinCanjear"].intValue
                    let in_cupones_canjeados = interaccion["cuponesCanjeados"].intValue
                    let in_texto = interaccion["texto"].stringValue
                    let in_fecha = interaccion["fecha"].stringValue
                    let in_favorito = interaccion["favorito"].boolValue
                    let in_env_id = interaccion["envioId"].stringValue
                    let in_cupones_permitidos = interaccion["cuponesCanjeados"].intValue
                    let in_es_cupon = interaccion["esCupon"].boolValue
                    let in_miniatura = interaccion["miniatura"].stringValue
                    
                    let interactionModel = Interaccion(id: in_id, titulo: in_titulo, beaconId: in_beacon_id, enfasis: in_enfasis, sectorId: sector_Id, cuponesSinCanjear: in_cupones_sin_canjear, cuponesCanjeados: in_cupones_canjeados, texto: in_texto, fecha: in_fecha, favorito: in_favorito, envioId: in_env_id, cuponesPermitidos: in_cupones_permitidos, esCupon: in_es_cupon, miniatura: in_miniatura)
                    interaccionesArray.append(interactionModel)
                }
            }
            self.interacciones = interaccionesArray
            self.presenter?.getDiscover(interaccionesArray)
        }
    }
    
    func filterInteraccion(withName name: String) -> [Interaccion] {
        var filterInteractions:[Interaccion] = []
        if(name.count > 0){
            filterInteractions = self.interacciones.filter({
                return $0.titulo.contains("\(name)")
            })
        }else{
            filterInteractions = self.interacciones
        }
        
        return filterInteractions
    }
    
}
