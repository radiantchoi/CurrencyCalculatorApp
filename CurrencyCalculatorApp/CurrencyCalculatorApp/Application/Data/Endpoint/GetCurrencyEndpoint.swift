//
//  GetCurrencyEndpoint.swift
//  CurrencyCalculatorApp
//
//  Created by Gordon Choi on 12/14/23.
//

import Foundation

/// 환율 정보를 가져오기 위해 필요한 정보를 지정하는 엔드포인트입니다.
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
