//
//  CounterViewControllerTests.swift
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

class CounterViewControllerTests: XCTestCase {
    var scheduler: TestScheduler!
    var disposeBag: DisposeBag!
    var sut: CounterViewController!
    var viewModelMock: CounterViewModelProtocol!

    override func setUp() {
        super.setUp()
        viewModelMock = CounterViewModelMock(numberValidator: TrueValidator())
        sut = CounterViewController(viewModel: viewModelMock)
        scheduler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()
    }

    override func tearDown() {
        super.tearDown()
        viewModelMock = nil
        disposeBag = nil
        sut = nil
        scheduler = nil
    }

    func testInit_WithViewModel_ShouldHaveViewModel() {
        XCTAssertNotNil(sut.viewModel)
    }

    func testLabelText_WithNoEvents_LabelTextShouldBeZero() {
        _ = sut.view
        XCTAssertEqual(sut.counterLabel.text, "0")
    }

}
