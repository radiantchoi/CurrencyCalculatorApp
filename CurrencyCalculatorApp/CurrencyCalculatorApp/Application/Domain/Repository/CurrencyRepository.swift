//
//  CurrencyRepository.swift
//  CurrencyCalculatorApp
//
//  Created by Gordon Choi on 12/14/23.
//

import Combine

protocol CurrencyRepository {
    /// 웹 서비스로부터 환율 정보 json 데이터를 받아 와서, 앱에서 사용하는 모델을 반환하는 메서드입니다.
    func getCurrencyInfo() -> AnyPublisher<Currency, FetchingError>
}
