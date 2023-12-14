//
//  CurrencyViewModel.swift
//  CurrencyCalculatorApp
//
//  Created by Gordon Choi on 12/14/23.
//

import Combine
import Foundation

final class CurrencyViewModel {
    private let useCase: CurrencyUseCase
    private var cancellables = Set<AnyCancellable>()
    
    init(useCase: CurrencyUseCase = CurrencyUseCaseImpl()) {
        self.useCase = useCase
        
        fetchCurrencyInfo()
    }
    
    func fetchCurrencyInfo() {
        useCase.getCurrencyInfo()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: {
                switch $0 {
                case .finished:
                    print("Finished")
                case .failure(let error):
                    print("Failure \(error)")
                }
            }) {
                print($0)
            }
            .store(in: &cancellables)
    }
}
