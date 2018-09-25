//
//  CounterViewModel.swift
//  testingMvvmRx
//
//  Created by Marko Aras on 09/08/2018.
//  Copyright © 2018 arsfutura. All rights reserved.
//

import RxSwift

protocol CounterViewModelProtocol {
    var increaseButtonTaps: PublishSubject<Void> { get }
    var counterValue: Observable<String>! { get }
    var numberValidator: Validateable { get }
}

class CounterViewModel: CounterViewModelProtocol {
    private var counter: Int = 0

    var increaseButtonTaps = PublishSubject<Void>()
    var counterValue: Observable<String>!

    var numberValidator: Validateable

    init(numberValidator: Validateable) {
        self.numberValidator = numberValidator

        counterValue = increaseButtonTaps
            .filter({ [weak self] _ in
                guard let `self` = self else { return false }
                return numberValidator.validate(self.counter)
            })
            .do(onNext: { [weak self] (_) in
                self?.counter += 1
            })
            .flatMap({ [weak self] (_) -> Observable<String> in
                guard let `self` = self else { return Observable.empty() }
                return Observable.just("\(self.counter)")
            })
            .startWith("\(counter)")
    }
}

class NumberValidator: Validateable {
    func validate(_ value: Int) -> Bool {
        // complex logic
        /// ...
        /// ...
        return value < 100
    }
}

protocol Validateable {
    func validate(_ value: Int) -> Bool
}

