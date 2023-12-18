//
//  CurrencyUseCase.swift
//  CurrencyCalculatorApp
//
//  Created by Gordon Choi on 12/14/23.
//

import Combine

protocol CurrencyUseCase {
    /// Repository로부터 환율 정보를 받아와서 반환하는 메서드입니다.
    /// 추후 정책이나 비즈니스 로직이 추가되면 이곳에 추가할 수 있습니다.
    func getCurrencyInfo() -> AnyPublisher<Currency, FetchingError>
    
    /// 사용자가 입력한 값을 토대로, 이 앱에서 유효한지 검증하는 메서드입니다.
    func verifyCurrencyValue(_ value: String?) -> Double?
}

final class CurrencyUseCaseImpl: CurrencyUseCase {
    private let repository: CurrencyRepository
    
    init(repository: CurrencyRepository = CurrencyRepositoryImpl()) {
        self.repository = repository
    }
    
    func getCurrencyInfo() -> AnyPublisher<Currency, FetchingError> {
        return repository.getCurrencyInfo()
    }
    
    func verifyCurrencyValue(_ value: String?) -> Double? {
        guard let value,
              let number = Double(value),
              (0...10000) ~= number else {
            return nil
        }
        
        return number
    }
}
