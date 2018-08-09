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
}

class CounterViewModel: CounterViewModelProtocol {
    private var counter: Int = 0

    var increaseButtonTaps = PublishSubject<Void>()
    var counterValue: Observable<String>!

    init() {
        counterValue = increaseButtonTaps
            .debug()
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
