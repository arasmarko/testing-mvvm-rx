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

    init() {
        counterValue = Observable.just("0")
    }
}
