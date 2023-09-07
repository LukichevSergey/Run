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
    func setTimer(with data: TimerViewModel)
    func resetStartButton()
    func setCircleResult(with data: CircleViewModel)
}

// MARK: Protocol - StopwatchRouterToViewProtocol (Router -> View)
protocol StopwatchRouterToViewProtocol: AnyObject {
    func presentView(view: UIViewController)
    func pushView(view: UIViewController)
}

final class StopwatchViewController: UIViewController {
    
    // MARK: - Property
    var presenter: StopwatchViewToPresenterProtocol!
    
    private var arrayCircleResult = [CircleViewModel]()
        
    private lazy var gradientLayer = PaletteApp.timerBackgroundGradient()
    
    private lazy var dataView: TimerDataView = {
        let view = TimerDataView()
        
        return view
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
    
    private lazy var resultTable: UITableView = {
        let table = UITableView()
        table.tintColor = PaletteApp.black
        table.backgroundColor = .clear
        table.showsVerticalScrollIndicator = false
        
        return table
    }()
    
    private let headerLabel: UILabel = {
        let headerLabel = UILabel()
        headerLabel.textColor = PaletteApp.black
        headerLabel.font = OurFonts.fontPTSansBold16
        headerLabel.backgroundColor = PaletteApp.white
        
        return headerLabel
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
        resultTable.delegate = self
        resultTable.dataSource = self
        configureUI()
        presenter.viewDidLoad()
        resultTable.register(CircleTableViewCell.self, forCellReuseIdentifier: "cell")
        
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayer.frame = view.bounds
    }
    
    // MARK: - private func
    private func commonInit() { }

    private func configureUI() {
        view.layer.insertSublayer(gradientLayer, at: 0)
        view.addSubview(dataView)
        dataView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.directionalHorizontalEdges.equalToSuperview().inset(16)
        }
        
        view.addSubview(mainVStack)
        mainVStack.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        view.addSubview(resultTable)
        resultTable.snp.makeConstraints { make in
            make.top.equalTo(dataView).offset(70)
            make.bottom.equalTo(timerLabel).inset(80)
            make.horizontalEdges.equalToSuperview().inset(30)
        }
    }
}

// MARK: Extension - StopwatchPresenterToViewProtocol 
extension StopwatchViewController: StopwatchPresenterToViewProtocol{
    
    func setCircleResult(with data: CircleViewModel) {
        arrayCircleResult.append(data)
        resultTable.reloadData()
        let lastIndex = IndexPath(row: arrayCircleResult.count - 1, section: 0)
        resultTable.scrollToRow(at: lastIndex, at: .bottom, animated: true)
    }
    
    func resetStartButton() {
        startButton.resetButton()
        arrayCircleResult.removeAll()
        resultTable.reloadData()
    }
    
    func setTimer(with data: TimerViewModel) {
        dataView.configure(with: data)
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

extension StopwatchViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayCircleResult.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CircleTableViewCell
        guard let cell = cell else { return UITableViewCell() }
        
        let circle = arrayCircleResult[indexPath.row]
        
        cell.configure(with: CircleViewModel(circle: circle.circle, distance: circle.distance, time: circle.time))
        cell.backgroundColor = UIColor.clear
        
        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = PaletteApp.white
        let headerTitles = ["Круг", "Дистанция", "Время"]
        let separator = "       "
        let labelText = headerTitles.joined(separator: separator)
        let attributedText = NSMutableAttributedString(string: labelText)
        attributedText.addAttribute(.kern, value: 0, range: NSRange(location: 0, length: labelText.count))
        
        let label = UILabel()
        label.attributedText = attributedText
        label.font = OurFonts.fontPTSansBold16
        label.textColor = PaletteApp.black
        headerView.addSubview(label)

        label.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().offset(16)
            make.verticalEdges.equalToSuperview()
        }

        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50 
    }
}



