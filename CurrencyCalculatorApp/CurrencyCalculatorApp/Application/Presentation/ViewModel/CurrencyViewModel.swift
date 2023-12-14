//
//  CurrencyViewModel.swift
//  CurrencyCalculatorApp
//
//  Created by Gordon Choi on 12/14/23.
//

import Combine
import Foundation

final class CurrencyViewModel {
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        let repo = CurrencyRepositoryImpl()
        
        repo.getCurrencyInfo()
            .sink(receiveCompletion: {
                switch $0 {
                case .finished:
                    print("Finished")
                case .failure(let error):
                    print("Failed \(error)")
                }
            }) {
                print($0)
            }
            .store(in: &cancellables)
    }
}
