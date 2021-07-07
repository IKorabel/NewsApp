//
//  Connectivity.swift
//  NewsApp
//
//  Created by Игорь Корабельников on 28.06.2021.
//

import Foundation
import Foundation
import Alamofire

class Connectivity {
    class var isConnectedToInternet: Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
}
