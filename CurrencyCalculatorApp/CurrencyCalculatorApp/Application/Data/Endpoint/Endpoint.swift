//
//  Endpoint.swift
//  CurrencyCalculatorApp
//
//  Created by Gordon Choi on 23/12/13.
//

import Foundation

typealias Headers = [String: String]
typealias Queries = [String: String]

/// 현재 앱에서 사용하는 HTTP Method입니다.
/// GET만 사용합니다.
enum HTTPMethod: String {
    case GET
}

/// HTTP 요청을 보낼 때 사용할 부가 정보입니다.
/// GET 요청만 보내므로, URL에 붙는 쿼리만을 받습니다.
enum HTTPRequestParameter {
    case queries(Queries)
}

/// HTTP 요청을 보낼 때 사용할 엔드포인트입니다.
protocol Endpoint {
    var baseURL: URL? { get }
    var httpMethod: HTTPMethod { get }
    var headers: Headers { get }
    var path: String { get }
    var parameters: HTTPRequestParameter? { get }
    
    func toURLRequest() throws -> URLRequest
}

/// 엔드포인트 기본구현입니다.
/// 요청을 보낼 때 기본적으로 필요한 헤더가 저장되어 있습니다.
/// 또 엔드포인트에서 URLRequest를 반환하는 메서드가 구현되어 있습니다.
extension Endpoint {    
    func toURLRequest() throws -> URLRequest {
        guard let url = configureURL() else {
            throw FetchingError.failedToCreateRequest
        }
        
        return URLRequest(url: url)
            .setMethod(httpMethod)
            .appendingHeaders(headers)
    }
    
    private func configureURL() -> URL? {
        baseURL?
            .appendingPath(path)
            .appendingQueries(at: parameters)
    }
}

private extension URL {
    func appendingQueries(at parameter: HTTPRequestParameter?) -> URL {
        var components = URLComponents(string: self.absoluteString)
        
        if case .queries(let queries) = parameter {
            components?.queryItems = queries.map {
                URLQueryItem(name: $0, value: $1)
            }
        }
        
        return components?.url ?? self
    }
}

private extension URLRequest {
    func setMethod(_ method: HTTPMethod) -> URLRequest {
        var urlRequest = self
        urlRequest.httpMethod = method.rawValue
        
        return urlRequest
    }
    
    func appendingHeaders(_ headers: Headers) -> URLRequest {
        var urlRequest = self
        headers.forEach {
            urlRequest.addValue($1, forHTTPHeaderField: $0)
        }
        
        return urlRequest
    }
}
