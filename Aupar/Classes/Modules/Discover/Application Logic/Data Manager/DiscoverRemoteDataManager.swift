//
//  DescubreRemoteDataManager.swift
//  Aupar
//
//  Created by Denis Vásquez on 5/16/19.
//  Copyright © 2019 Denis Vásquez. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class DiscoverRemoteDataManager: DiscoverRemoteDataManagerInputProtocol {
    func getImplementation(callback: @escaping (JSON) -> ()){
        let method = HTTPMethod.get
        let url = "https://dev-mobile.aupar.gt/api/v1.8/implementations"
        let parameters = ["beacons[0]": "0"]
        let headers = ["Accept":"application/json", "Authorization":"Bearer 01811d7dfeb271ebb3d0af6b7ac8929ba28967ae5889d7e49893c966ba32d699"]
        
        Alamofire.request(url, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) -> Void in
            switch response.result {
            case .success(let data):
                let json_implementation = JSON(data)
                print("Data obtenida \(json_implementation)")
                callback(json_implementation)
                
            case .failure(let error):
                print(error)
                callback(JSON.null)
            }
        }
    }
    func getDiscover(callback: @escaping (JSON) -> ()){
        let method = HTTPMethod.get
        let url = "https://dev-mobile.aupar.gt/api/v1.8/discover"
        let parameters = ["detectedSectors[0]": "4559ad5f-da41-e811-80c3-00155d280898"]
        let headers = ["Authorization": "Bearer bcd3f541be743cc5ebb6671cb7279a06855b5bcf88130f899069ca1744e8157a", "Accept": "application/json"]
        
        Alamofire.request(url, method: method, parameters: parameters, encoding: URLEncoding.default, headers: headers).responseJSON { (response) -> Void in
            switch response.result {
            case .success(let data):
                let json_descubre = JSON(data)
                print("Data obtenida \(json_descubre)")
                callback(json_descubre)
                
            case .failure(let error):
                print(error)
                callback(JSON.null)
            }
        }
    }
}
