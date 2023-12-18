//
//  FetchingError.swift
//  CurrencyCalculatorApp
//
//  Created by Gordon Choi on 12/14/23.
//

import Foundation

enum FetchingError: Error, LocalizedError, Equatable {
    case failedToCreateURL
    case failedToCreateRequest
    case failedToGetHTTPResponse
    case failedToGetData
    case invalidNetworkStatusCode(code: Int)
    case failedToDecode
    case unknownError(error: Error? = nil)
    
    var errorDescription: String? {
        switch self {
        case .failedToCreateURL:
            return "URL 생성에 실패했습니다."
        case .failedToCreateRequest:
            return "URL 요청 생성에 실패했습니다."
        case .failedToGetHTTPResponse:
            return "HTTP 응답을 받는 데 실패했습니다."
        case .failedToGetData:
            return "데이터를 받아오는 데 실패했습니다."
        case .invalidNetworkStatusCode(let code):
            return "서버에서 오류를 전송했습니다 (오류 코드: \(code))."
        case .failedToDecode:
            return "디코딩에 실패했습니다."
        case .unknownError(let error):
            return "알 수 없는 오류가 발생했습니다. (\(error?.localizedDescription ?? "unknown"))"
        }
    }
    
    var recoverySuggestion: String? { nil }
    
    var localErrorIndex: Int {
        switch self {
        case .failedToCreateURL:
            return 0
        case .failedToCreateRequest:
            return 1
        case .failedToGetHTTPResponse:
            return 2
        case .failedToGetData:
            return 3
        case .invalidNetworkStatusCode(_):
            return 4
        case .failedToDecode:
            return 5
        case .unknownError(_):
            return 6
        }
    }
    
    static func == (lhs: FetchingError, rhs: FetchingError) -> Bool {
        return lhs.localErrorIndex == rhs.localErrorIndex
    }
}
