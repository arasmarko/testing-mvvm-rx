//
//  CounterViewModelTests.swift
//  testingMvvmRxTests
//
//  Created by Marko Aras on 09/08/2018.
//  Copyright © 2018 arsfutura. All rights reserved.
//

import RxSwift
import RxCocoa
import RxTest
import XCTest
@testable import testingMvvmRx

class CounterViewModelTests: XCTestCase {
    var scheduler: TestScheduler!
    var disposeBag: DisposeBag!
    var sut: CounterViewModel!

    override func setUp() {
        super.setUp()
        sut = CounterViewModel()
        scheduler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()
    }

    override func tearDown() {
        super.tearDown()
        disposeBag = nil
        sut = nil
        scheduler = nil
    }

    func testIncreaseButtonTaps_WithNoEvents_LabelTextShouldBeZero() {
        let observer: TestableObserver<String> = scheduler.createObserver(String.self)
        let correctResult: [Recorded<Event<String>>] = [next(0, "0")]

        sut.counterValue
            .subscribe(observer)
            .disposed(by: disposeBag)

        scheduler.start()
        XCTAssertEqual(correctResult, observer.events)
    }

    func testIncreaseButtonTaps_WithOneTapEvent_LabelTextShouldBeOne() {
        let observer: TestableObserver<String> = scheduler.createObserver(String.self)
        let correctResult: [Recorded<Event<String>>] = [next(0, "0"), next(1, "1")]

        sut.counterValue
            .subscribe(observer)
            .disposed(by: disposeBag)

        let allEvents = scheduler.createHotObservable([next(1, ())])

        allEvents
            .bind(to: sut.increaseButtonTaps)
            .disposed(by: disposeBag)

        scheduler.start()
        XCTAssertEqual(correctResult, observer.events)
    }

}

