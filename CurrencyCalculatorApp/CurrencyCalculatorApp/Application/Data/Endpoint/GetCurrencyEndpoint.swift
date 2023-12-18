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
                "access_key": String.EndpointValues.accessKey,
                "currencies": String.EndpointValues.targetCurrencies,
                "source": String.EndpointValues.sourceCurrency,
            ]
        )
    }
}
