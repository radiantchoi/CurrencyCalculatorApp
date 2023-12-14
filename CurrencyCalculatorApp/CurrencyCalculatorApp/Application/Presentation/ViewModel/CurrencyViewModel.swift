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
    
    @Published private(set) var USDtoKRW: Double = 0
    @Published private(set) var USDtoJPY: Double = 0
    @Published private(set) var USDtoPHP: Double = 0
    
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
                
                self.USDtoKRW = $0.toKRW
                self.USDtoJPY = $0.toJPY
                self.USDtoPHP = $0.toPHP
            }
            .store(in: &cancellables)
    }
}
