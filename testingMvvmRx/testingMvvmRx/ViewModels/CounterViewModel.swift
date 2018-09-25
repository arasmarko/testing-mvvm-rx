//
//  CounterViewModel.swift
//  testingMvvmRx
//
//  Created by Marko Aras on 09/08/2018.
//  Copyright © 2018 arsfutura. All rights reserved.
//

import RxSwift

class CounterViewModel {
    private var counter: Int = 0

    var counterValue: Observable<String>!

    init(increaseButtonTaps: Observable<Void>) {
        counterValue = increaseButtonTaps
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
