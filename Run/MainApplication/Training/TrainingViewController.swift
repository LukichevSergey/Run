//
//  TrainingViewController.swift
//  Run
//
//  Created by Лукичев Сергей on 26.08.2023.
//  
//

import UIKit
import OrderedCollections

// MARK: Protocol - TrainingPresenterToViewProtocol (Presenter -> View)
protocol TrainingPresenterToViewProtocol: ActivityIndicatorProtocol {
    func setTrainingData(data: [TrainingCellViewModel])
    func setTrainingProgressKm(km: Float, kmLabel: String)
    func setTrainingProgressStep(step: Float, stepLabel: String)
}

// MARK: Protocol - TrainingRouterToViewProtocol (Router -> View)
protocol TrainingRouterToViewProtocol: AnyObject {
    func presentView(view: UIViewController)
    func pushView(view: UIViewController)
}

final class TrainingViewController: UIViewController {
    
    
    // MARK: - Property
    var presenter: TrainingViewToPresenterProtocol!
    
    private var diffableDataSource: UITableViewDiffableDataSource<SectionTraining, TrainingCellViewModel>?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = PaletteApp.black
        label.text = Tx.Training.information
        label.font = OurFonts.fontPTSansBold32
        
        return label
    }()
    
    private let activityLabel: UILabel = {
        let label = UILabel()
        label.textColor = PaletteApp.black
        label.text = Tx.Training.activity
        label.font = OurFonts.fontPTSansBold20
        
        return label
    }()
    
    private let allActivityButton: UIButton = {
        let button = UIButton()
        button.setTitle(Tx.Training.allActivity, for: .normal)
        button.setTitleColor(PaletteApp.black, for: .normal)
        button.titleLabel?.font = OurFonts.fontPTSansBold16

        return button
    }()
    
    private let stepLabel: UILabel = {
        let label = UILabel()
        label.textColor = PaletteApp.black
        label.text = Tx.Training.step
        label.font = OurFonts.fontPTSansBold20
        
        return label
    }()
    
    private let lvlLabelStep: UILabel = {
        let label = UILabel()
        label.text = "Lvl 1"
        label.textColor = PaletteApp.black
        label.layer.borderWidth = 2
        label.layer.borderColor = PaletteApp.black.cgColor
        label.layer.cornerRadius = 15
        label.backgroundColor = PaletteApp.white
        label.textAlignment = .center
        label.font = OurFonts.fontPTSansBold16
        
        return label
    }()
    
    private let detailLvlLabelStep: UILabel = {
        let label = UILabel()
        label.text = "80 Run"
        label.textColor = PaletteApp.black
        label.backgroundColor = PaletteApp.white
        label.textAlignment = .center
        label.font = OurFonts.fontPTSansBold14
        
        return label
    }()
    
    private let willBeChargedST: UILabel = {
        let label = UILabel()
        label.textColor = PaletteApp.black
        label.text = Tx.Training.willBeCharged
        label.font = OurFonts.fontPTSansBold14
        
        return label
    }()
    
    private let kilometresLabel: UILabel = {
        let label = UILabel()
        label.textColor = PaletteApp.black
        label.text = Tx.Training.kilomertes
        label.font = OurFonts.fontPTSansBold20
        
        return label
    }()
        
    private let lvlLabelKm: UILabel = {
        let label = UILabel()
        label.text = "Lvl 100"
        label.textColor = PaletteApp.black
        label.layer.borderWidth = 2
        label.layer.borderColor = PaletteApp.black.cgColor
        label.layer.cornerRadius = 15
        label.backgroundColor = PaletteApp.white
        label.textAlignment = .center
        label.font = OurFonts.fontPTSansBold16
        
        return label
    }()
    
    private let detailLvlLabelKm: UILabel = {
        let label = UILabel()
        label.text = "400 Run"
        label.textColor = PaletteApp.black
        label.backgroundColor = PaletteApp.white
        label.textAlignment = .center
        label.font = OurFonts.fontPTSansBold14
        
        return label
    }()
    
    private let willBeChargedKM: UILabel = {
        let label = UILabel()
        label.textColor = PaletteApp.black
        label.text = Tx.Training.willBeCharged
        label.font = OurFonts.fontPTSansBold14
        
        return label
    }()
    
    private let progressBarStep = TrainingProgressBarStep()

    private let progressBarKm = TrainingProgressBarViewKm()
    
    private lazy var trainingDataTable: UITableView = {
        let table = UITableView()
        table.tintColor = PaletteApp.black
        table.backgroundColor = .clear
        table.showsVerticalScrollIndicator = false
        table.separatorStyle = .none
        
        return table
    }()
    
    // MARK: - init
    
    override func viewWillAppear(_ animated: Bool) {
        logger.log("\(#fileID) -> \(#function)")
        presenter.viewDidLoad()
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        logger.log("\(#fileID) -> \(#function)")
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        logger.log("\(#fileID) -> \(#function)")
        commonInit()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logger.log("\(#fileID) -> \(#function)")
        view.backgroundColor = PaletteApp.white
        configureUI()
        presenter.viewDidLoad()
        trainingDataTable.delegate = self
        trainingDataTable.register(TrainingDataTableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func setupDiffableDataSource() {
        logger.log("\(#fileID) -> \(#function)")
        diffableDataSource = UITableViewDiffableDataSource(tableView: trainingDataTable) { tableView, indexPath, item in
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TrainingDataTableViewCell
            
            let viewModel = TrainingCellViewModel(killometrs: item.killometrs, image: item.image, data: item.data, title: item.title)
            cell?.configure(with: viewModel)
            
            return cell
        }
        diffableDataSource?.defaultRowAnimation = .fade
    }
    
    // MARK: - private func
    private func commonInit() {
        setupDiffableDataSource()
    }
    
    private func configureUI() {
        logger.log("\(#fileID) -> \(#function)")
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(50)
            make.leading.equalToSuperview().inset(10)
            make.height.equalTo(40)
            make.width.equalTo(150)
        }
        
        view.addSubview(activityLabel)
        activityLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel).inset(50)
            make.leading.equalToSuperview().inset(30)
            make.height.equalTo(40)
        }
        
        view.addSubview(allActivityButton)
        allActivityButton.snp.makeConstraints { make in
            make.top.equalTo(titleLabel).inset(50)
            make.trailing.equalToSuperview().inset(30)
            make.height.equalTo(40)
        }
        
        view.addSubview(stepLabel)
        stepLabel.snp.makeConstraints { make in
            make.top.equalTo(allActivityButton).inset(50)
            make.leading.equalToSuperview().inset(50)
            make.height.equalTo(30)
        }
        
        view.addSubview(willBeChargedST)
        willBeChargedST.snp.makeConstraints { make in
            make.top.equalTo(stepLabel).inset(70)
            make.leading.equalToSuperview().inset(50)
            make.height.equalTo(20)
        }
        
        view.addSubview(kilometresLabel)
        kilometresLabel.snp.makeConstraints { make in
            make.top.equalTo(allActivityButton).inset(160)
            make.leading.equalToSuperview().inset(50)
            make.height.equalTo(30)
        }
        
        view.addSubview(willBeChargedKM)
        willBeChargedKM.snp.makeConstraints { make in
            make.top.equalTo(kilometresLabel).inset(70)
            make.leading.equalToSuperview().inset(50)
            make.trailing.equalToSuperview()
            make.height.equalTo(20)
        }
        
        view.addSubview(progressBarStep)
        progressBarStep.snp.makeConstraints { make in
            make.top.equalTo(stepLabel).inset(35)
            make.leading.equalToSuperview().inset(50)
        }
        
        view.addSubview(lvlLabelStep)
        lvlLabelStep.snp.makeConstraints { make in
            make.top.equalTo(stepLabel).inset(35)
            make.leading.equalTo(progressBarStep.snp.trailing).offset(10)
            make.trailing.equalToSuperview().inset(40)
            make.width.equalTo(90)
            make.height.equalTo(30)
        }
        
        view.addSubview(detailLvlLabelStep)
        detailLvlLabelStep.snp.makeConstraints { make in
            make.top.equalTo(lvlLabelStep).inset(35)
            make.width.equalTo(60)
            make.height.equalTo(20)
            make.centerX.equalTo(lvlLabelStep)
        }
        
        view.addSubview(progressBarKm)
        progressBarKm.snp.makeConstraints { make in
            make.top.equalTo(kilometresLabel).inset(35)
            make.leading.equalToSuperview().inset(50)
        }
        
        view.addSubview(lvlLabelKm)
        lvlLabelKm.snp.makeConstraints { make in
            make.top.equalTo(kilometresLabel).inset(35)
            make.leading.equalTo(progressBarKm.snp.trailing).offset(10)
            make.trailing.equalToSuperview().inset(40)
            make.width.equalTo(90)
            make.height.equalTo(30)
        }
        
        view.addSubview(detailLvlLabelKm)
        detailLvlLabelKm.snp.makeConstraints { make in
            make.top.equalTo(lvlLabelKm).inset(35)
            make.width.equalTo(60)
            make.height.equalTo(20)
            make.centerX.equalTo(lvlLabelKm)
        }
        
        view.addSubview(trainingDataTable)
        trainingDataTable.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(400)
            make.bottom.equalToSuperview().inset(100)
            make.horizontalEdges.equalToSuperview().inset(10)
        }
    }
}

// MARK: Extension - TrainingPresenterToViewProtocol 
extension TrainingViewController: TrainingPresenterToViewProtocol {
    
    func setTrainingProgressStep(step: Float, stepLabel: String) {
        logger.log("\(#fileID) -> \(#function)")
        progressBarStep.updateProgress(step: step, stepLabel: stepLabel)
    }
    
    func setTrainingProgressKm(km: Float, kmLabel: String) {
        logger.log("\(#fileID) -> \(#function)")
        progressBarKm.updateProgress(km: km, kmLabel: kmLabel)
    }
    
    func setTrainingData(data: [TrainingCellViewModel]) {
        logger.log("\(#fileID) -> \(#function)")
        var snapshot = NSDiffableDataSourceSnapshot<SectionTraining, TrainingCellViewModel>()
        snapshot.appendSections([.main])
        snapshot.appendItems(data, toSection: .main)
        diffableDataSource?.apply(snapshot)
    }
}

extension TrainingViewController: UITableViewDelegate  {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .clear
        tableView.sectionHeaderTopPadding = 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.selectionStyle = .none
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        logger.log("\(#fileID) -> \(#function)")
        let headerView = HeaderTrainingTableView()
        headerView.backgroundColor = PaletteApp.white
        headerView.delegate = self
        return headerView
    }
}

// MARK: Extension - TrainingRouterToViewProtocol
extension TrainingViewController: TrainingRouterToViewProtocol{
    func presentView(view: UIViewController) {
        logger.log("\(#fileID) -> \(#function)")
        present(view, animated: true, completion: nil)
    }

    func pushView(view: UIViewController) {
        logger.log("\(#fileID) -> \(#function)")
        navigationController?.pushViewController(view, animated: true)
    }
}

extension TrainingViewController: SenderDetailTrainingDelegate{
    func senderTappedButton() {
        logger.log("\(#fileID) -> \(#function)")
        presenter.detailButtonTapped()
    }
}
