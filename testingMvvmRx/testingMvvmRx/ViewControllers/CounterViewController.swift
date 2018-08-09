//
//  CounterViewController.swift
//  testingMvvmRx
//
//  Created by Marko Aras on 09/08/2018.
//  Copyright © 2018 arsfutura. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class CounterViewController: UIViewController {
    private let counterLabel = UILabel()
    private let increaseCounterButton = UIButton()
    private let disposeBag = DisposeBag()

    let viewModel: CounterViewModelProtocol

    init(viewModel: CounterViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        render()
        setupObservables()
    }

    private func setupObservables() {
        increaseCounterButton.rx
            .tap
            .bind(to: viewModel.increaseButtonTaps)
            .disposed(by: disposeBag)

        viewModel.counterValue
            .bind(to: counterLabel.rx.text)
            .disposed(by: disposeBag)
    }
}

// MARK - UI
extension CounterViewController {
    private func render() {
        view.addSubview(counterLabel)
        counterLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-30)
        }

        increaseCounterButton.setTitle("+", for: UIControlState())
        increaseCounterButton.setTitleColor(.black, for: UIControlState())
        view.addSubview(increaseCounterButton)
        increaseCounterButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(30)
        }
    }
}
