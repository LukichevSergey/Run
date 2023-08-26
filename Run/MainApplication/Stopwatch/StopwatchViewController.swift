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
    func setTimer(with data: [TimerStatsViewModel])
}

// MARK: Protocol - StopwatchRouterToViewProtocol (Router -> View)
protocol StopwatchRouterToViewProtocol: AnyObject {
    func presentView(view: UIViewController)
    func pushView(view: UIViewController)
}

class StopwatchViewController: UIViewController {
    
    // MARK: - Property
    var presenter: StopwatchViewToPresenterProtocol!
    
    private lazy var gradientLayer = PaletteApp.timerBackgroundGradient()
    
    private lazy var dataHStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .equalSpacing

        return stack
    }()
    
    private lazy var timerLabel: UILabel = {
        let label = UILabel()
        label.textColor = PaletteApp.black
        label.font = OurFonts.fontPTSansBold72
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var timerSubtitle: UILabel = {
        let label = UILabel()
        label.textColor = PaletteApp.black
        label.font = OurFonts.fontPTSansRegular18
        label.textAlignment = .center
        label.text = Tx.Timer.subtitle
        
        return label
    }()
    
    private lazy var startButton: RoundButton = {
        let button = RoundButton(with: .startButton(isStarted: false))
        button.delegate = self
        
        return button
    }()
    
    private lazy var roundButton: RoundButton = {
        let button = RoundButton(with: .roundButton)
        button.delegate = self
        
        return button
    }()
    
    private lazy var endButton: RoundButton = {
        let button = RoundButton(with: .endButton)
        button.delegate = self
        
        return button
    }()
    
    private lazy var buttonsHStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [roundButton, startButton, endButton])
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 16
        stack.alignment = .bottom
        
        return stack
    }()
    
    private lazy var mainVStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [timerLabel, timerSubtitle, buttonsHStack])
        stack.axis = .vertical
        stack.alignment = .center
        stack.setCustomSpacing(50, after: timerSubtitle)
        
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
        configureUI()
        presenter.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        gradientLayer.frame = view.bounds
    }
    
    // MARK: - private func
    private func commonInit() { }

    private func configureUI() {
        view.layer.insertSublayer(gradientLayer, at: 0)
        
        view.addSubview(dataHStack)
        dataHStack.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.directionalHorizontalEdges.equalToSuperview().inset(16)
        }
        
        view.addSubview(mainVStack)
        mainVStack.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}

// MARK: Extension - StopwatchPresenterToViewProtocol 
extension StopwatchViewController: StopwatchPresenterToViewProtocol{
    func setTimer(with data: [TimerStatsViewModel]) {
        data.forEach({ viewModel in
            let view = TimerStatsLabel()
            view.configure(with: viewModel)
            dataHStack.addArrangedSubview(view)
        })
    }
    
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
    func roundButtonTapped(with type: RoundButton.RoundButtonType) {
        presenter.roundButtonTapped(with: type)
    }
}
