//
//  Interaccion.swift
//  Aupar
//
//  Created by Denis Vásquez on 5/17/19.
//  Copyright © 2019 Denis Vásquez. All rights reserved.
//

import Foundation

class Interaccion{
    var id: String!
    var titulo: String!
    var beaconId: String!
    var enfasis: String!
    var sectorId: String!
    var cuponesSinCanjear: Int!
    var cuponesCanjeados: Int!
    var texto: String!
    var fecha: String!
    var favorito: Bool!
    var envioId: String!
    var cuponesPermitidos: Int!
    var esCupon: Bool!
    var miniatura: String!
    
    init(id: String?, titulo: String?, beaconId: String?, enfasis: String?, sectorId: String?, cuponesSinCanjear: Int?, cuponesCanjeados: Int?, texto: String?, fecha: String?, favorito: Bool?, envioId: String?, cuponesPermitidos: Int?, esCupon: Bool?, miniatura: String?) {
        self.id = id
        self.titulo = titulo
        self.beaconId = beaconId
        self.enfasis = enfasis
        self.sectorId = sectorId
        self.cuponesSinCanjear = cuponesSinCanjear
        self.cuponesCanjeados = cuponesCanjeados
        self.texto = texto
        self.fecha = fecha
        self.favorito = favorito
        self.envioId = envioId
        self.cuponesPermitidos = cuponesPermitidos
        self.esCupon = esCupon
        self.miniatura = miniatura
    }
}
