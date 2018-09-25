//
//  CounterViewModelMock.swift
//  testingMvvmRxTests
//
//  Created by Marko Aras on 09/08/2018.
//  Copyright © 2018 arsfutura. All rights reserved.
//

import RxSwift
@testable import testingMvvmRx

class CounterViewModelMock: CounterViewModelProtocol {
    var increaseButtonTaps = PublishSubject<Void>()
    var counterValue: Observable<String>!
    var numberValidator: Validateable

    init(numberValidator: Validateable) {
        self.numberValidator = numberValidator

        counterValue = Observable.just(0)
            .filter({ numberValidator.validate($0) })
            .map({ number in
                return "\(number)"
            })

    }
}

class TrueValidator: Validateable {
    func validate(_ value: Int) -> Bool {
        return true
    }
}

class FalseValidator: Validateable {
    func validate(_ value: Int) -> Bool {
        return false
    }
}
