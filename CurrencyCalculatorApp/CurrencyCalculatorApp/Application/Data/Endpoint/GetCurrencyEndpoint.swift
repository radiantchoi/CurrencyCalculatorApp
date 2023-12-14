//
//  GetCurrencyEndpoint.swift
//  CurrencyCalculatorApp
//
//  Created by Gordon Choi on 12/14/23.
//

import Foundation

enum GetCurrencyEndpoint: Endpoint {
    case getRecentCurrency
    
    var baseURL: URL? { URL(string: BaseURL.urlString) }
    
    var httpMethod: HTTPMethod { .GET }
    
    var headers: Headers { [:] }
    
    var path: String { "live" }
    
    var parameters: HTTPRequestParameter? {
        return .queries(
            [
                "access_key": "bd9bd75624cbe4e1cb66d7f69ad4f55a",
                "currencies": "KRW,JPY,PHP",
                "source": "USD",
            ]
        )
    }
}
