//
//  CounterViewTests.swift
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

class CounterViewTests: XCTestCase {
    var scheduler: TestScheduler!
    var disposeBag: DisposeBag!
    var sut: CounterViewController!
    var viewModel: CounterViewModelProtocol!

    override func setUp() {
        super.setUp()
        viewModel = CounterViewModel(numberValidator: TrueValidator())
        sut = CounterViewController(viewModel: viewModel)
        scheduler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()
    }

    override func tearDown() {
        super.tearDown()
        disposeBag = nil
        viewModel = nil
        sut = nil
        scheduler = nil
    }

    func testLabelText_WithNoEvents_LabelTextShouldBeZero() {
        _ = sut.view
        XCTAssertEqual(sut.counterLabel.text, "0")
    }

    func testLabelText_WithOneTap_LabelTextShouldBeOne() {
        _ = sut.view

        scheduler.createHotObservable([next(1, ())])
            .bind(to: sut.viewModel.increaseButtonTaps)
            .disposed(by: disposeBag)

        scheduler.start()
        XCTAssertEqual(sut.counterLabel.text, "1")
    }
}

