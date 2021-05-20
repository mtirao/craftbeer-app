//
//  ApiConfiguration.swift
//  Craftbeer
//
//  Created by Marcos Tirao on 26/10/2020.
//

import Foundation
import Alamofire

protocol ApiConfiguration: URLRequestConvertible {
    
    var param: Parameters? {get}
    var method: HTTPMethod {get}
    var path: String {get}
    
}


