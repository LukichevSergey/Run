//
//  StopwatchViewController.swift
//  Run
//
//  Created by Лукичев Сергей on 24.08.2023.
//  
//

import UIKit
import Combine

// MARK: Protocol - StopwatchPresenterToViewProtocol (Presenter -> View)
protocol StopwatchPresenterToViewProtocol: AnyObject {
    func setTimer(with time: Double)
}

// MARK: Protocol - StopwatchRouterToViewProtocol (Router -> View)
protocol StopwatchRouterToViewProtocol: AnyObject {
    func presentView(view: UIViewController)
    func pushView(view: UIViewController)
}

class StopwatchViewController: UIViewController {
    
    // MARK: - Property
    var presenter: StopwatchViewToPresenterProtocol!
    
    private lazy var timerLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 72)
        label.textAlignment = .center
        label.numberOfLines = 1
        
        return label
    }()
    
    private lazy var startButton: RoundButton = {
        let button = RoundButton(status: .startButton(isStarted: false))
        button.delegate = self
        
        return button
    }()
    
    private lazy var mainVStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [timerLabel, startButton])
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 8
        
        return stack
    }()

    // MARK: - init
    init() {
        super.init(nibName: nil, bundle: nil)

        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        commonInit()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGreen
        configureUI()
        presenter.viewDidLoad()
    }
    
    // MARK: - private func
    private func commonInit() {
        timerLabel.text = "0 : 00 : 00"
    }

    private func configureUI() {
        view.addSubview(mainVStack)
        mainVStack.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}

// MARK: Extension - StopwatchPresenterToViewProtocol 
extension StopwatchViewController: StopwatchPresenterToViewProtocol{
    func setTimer(with time: Double) {
        timerLabel.text = time.formatTime()
    }
}

// MARK: Extension - StopwatchRouterToViewProtocol
extension StopwatchViewController: StopwatchRouterToViewProtocol{
    func presentView(view: UIViewController) {
        present(view, animated: true, completion: nil)
    }

    func pushView(view: UIViewController) {
        navigationController?.pushViewController(view, animated: true)
    }
}

// MARK: RoundButtonDelegate
extension StopwatchViewController: RoundButtonDelegate {
    func roundButtonTapped(with type: RoundButton.RoundButtonStatus) {
        presenter.roundButtonTapped(with: type)
    }
}
