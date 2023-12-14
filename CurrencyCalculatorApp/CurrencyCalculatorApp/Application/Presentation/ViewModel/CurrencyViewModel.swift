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
    
    @Published private(set) var timestamp: String = "---"
    @Published private var USDtoKRW: Double = 0
    @Published private var USDtoJPY: Double = 0
    @Published private var USDtoPHP: Double = 0
    
    init(useCase: CurrencyUseCase = CurrencyUseCaseImpl()) {
        self.useCase = useCase
        
//        fetchCurrencyInfo()
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
                self.timestamp = $0.timestamp.formatStamp()
                self.USDtoKRW = $0.toKRW
                self.USDtoJPY = $0.toJPY
                self.USDtoPHP = $0.toPHP
            }
            .store(in: &cancellables)
    }
}
