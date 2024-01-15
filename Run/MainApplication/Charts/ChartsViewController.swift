//
//  ChartsViewController.swift
//  Run
//
//  Created by Evgenii Kutasov on 02.01.2024.
//

import UIKit
import DGCharts

// MARK: Protocol - ChartsPresenterToViewProtocol (Presenter -> View)
protocol ChartsPresenterToViewProtocol: ActivityIndicatorProtocol {
    func setDataInCharts(dateWeek: String, dataCharts: [BarChartDataEntry], distance: String, time: String, hiddenButton: Int)
    func setDataInChartsSingleColumn(distance: String, time: String)
}

// MARK: Protocol - ChartsRouterToViewProtocol (Router -> View)
protocol ChartsRouterToViewProtocol: AnyObject {
    func presentView(view: UIViewController)
    func pushView(view: UIViewController)
}

final class ChartsViewController: UIViewController {
    
    // MARK: - Property
    var presenter: ChartsViewToPresenterProtocol!
    
    private let titleStatistics = {
        let label = UILabel()
        label.text = Tx.Charts.statistics
        label.textColor = PaletteApp.black
        label.font = OurFonts.fontPTSansBold32
        
        return label
    }()
    
    private lazy var selectPeriod: UISegmentedControl = {
        let segmentControl = UISegmentedControl(items: [Tx.Charts.week, Tx.Charts.month, Tx.Charts.year])
        segmentControl.selectedSegmentIndex = 0
        segmentControl.backgroundColor = PaletteApp.grey
        segmentControl.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: OurFonts.fontPTSansRegular16.pointSize)], for: .normal)
        segmentControl.addTarget(self, action: #selector(reloadSegmentPeriod), for: .valueChanged)
        
        return segmentControl
    }()
    
    private lazy var  backPeriodButton = {
        let button = UIButton()
        button.setTitle("<", for: .normal)
        button.setTitleColor(PaletteApp.black, for: .normal)
        button.backgroundColor = PaletteApp.grey
        button.layer.borderColor = PaletteApp.black.cgColor
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(tappedButtonDown), for: .touchUpInside)
        button.layer.cornerRadius = 15
        
        return button
    }()
    
    private lazy var forwardPeriodButton = {
        let button = UIButton()
        button.setTitle(">", for: .normal)
        button.setTitleColor(PaletteApp.black, for: .normal)
        button.backgroundColor = PaletteApp.grey
        button.layer.borderColor = PaletteApp.black.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(tappedButtonUp), for: .touchUpInside)
        button.isHidden = true
        
        return button
    }()
    
    private let titlePeriod = {
        let label = UILabel()
        label.textColor = PaletteApp.black
        label.font = OurFonts.fontPTSansBold24
        
        return label
    }()
    
    private let titleStep = {
        let label = UILabel()
        label.text = Tx.Training.step
        label.textColor = PaletteApp.black
        label.font = OurFonts.fontPTSansRegular16
        
        return label
    }()
    
    private let countStep = {
        let label = UILabel()
        label.textColor = PaletteApp.black
        label.font = OurFonts.fontPTSansBold20
        
        return label
    }()
    
    private let barChartView: BarChartView = {
        let barChart = BarChartView()
        barChart.gridBackgroundColor = UIColor.white
        
        // Отключаем координаты сетки
        barChart.xAxis.drawGridLinesEnabled = false
        barChart.leftAxis.drawGridLinesEnabled = false
        barChart.rightAxis.drawGridLinesEnabled = false
        barChart.drawGridBackgroundEnabled = false
        
        // Отключаем подписи к осям
        barChart.xAxis.drawLabelsEnabled = true
        barChart.rightAxis.drawLabelsEnabled = false
        
        // Отключаем легенду
        barChart.legend.enabled = false
        
        // Отключаем зум
        barChart.pinchZoomEnabled = false
        barChart.doubleTapToZoomEnabled = false
        
        barChart.xAxis.enabled = true
        barChart.drawBordersEnabled = false
        barChart.minOffset = 0
        barChart.xAxis.labelPosition = .bottom // Расположение меток внизу
        
        return barChart
    }()
    
    private let titleAllDistance = {
        let label = UILabel()
        label.text = Tx.Charts.distance
        label.textColor = PaletteApp.black
        label.font = OurFonts.fontPTSansRegular16
        
        return label
    }()
    
    private let countAllDistance = {
        let label = UILabel()
        label.textColor = PaletteApp.black
        label.font = OurFonts.fontPTSansBold24
        
        return label
    }()
    
    private let titleAllTime = {
        let label = UILabel()
        label.text = Tx.CircleTableResult.time
        label.textColor = PaletteApp.black
        label.font = OurFonts.fontPTSansRegular16
        
        return label
    }()
    
    private let countAllTime = {
        let label = UILabel()
        label.textColor = PaletteApp.black
        label.font = OurFonts.fontPTSansBold24
        
        return label
    }()
    
    // MARK: - init
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
        configureUI()
        presenter.viewDidLoad()
        barChartView.delegate = self
    }
    
    // MARK: - private func
    private func commonInit() {
        logger.log("\(#fileID) -> \(#function)")
    }
    
    private func configureUI() {
        logger.log("\(#fileID) -> \(#function)")
        view.backgroundColor = PaletteApp.white
        view.addSubview(titleStatistics)
        titleStatistics.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.trailing.equalToSuperview().inset(50)
        }
        
        view.addSubview(selectPeriod)
        selectPeriod.snp.makeConstraints { make in
            make.top.equalTo(titleStatistics.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().inset(10)
            make.height.equalTo(40)
        }
        
        view.addSubview(backPeriodButton)
        backPeriodButton.snp.makeConstraints { make in
            make.top.equalTo(selectPeriod.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(10)
            make.width.height.equalTo(50)
        }
        
        view.addSubview(titlePeriod)
        titlePeriod.snp.makeConstraints { make in
            make.top.equalTo(selectPeriod.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
        }
        
        view.addSubview(forwardPeriodButton)
        forwardPeriodButton.snp.makeConstraints { make in
            make.top.equalTo(selectPeriod.snp.bottom).offset(20)
            make.trailing.equalToSuperview().inset(10)
            make.width.height.equalTo(50)
        }
        
        view.addSubview(titleStep)
        titleStep.snp.makeConstraints { make in
            make.top.equalTo(titlePeriod.snp.bottom).offset(20)
            make.leading.equalToSuperview().inset(10)
        }
        
        view.addSubview(countStep)
        countStep.snp.makeConstraints { make in
            make.top.equalTo(titleStep.snp.bottom).offset(5)
            make.leading.equalToSuperview().inset(10)
        }
        
        view.addSubview(barChartView)
        barChartView.snp.makeConstraints { make in
            make.top.equalTo(countStep.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().inset(10)
            make.height.equalTo(200)
        }
        
        view.addSubview(titleAllDistance)
        titleAllDistance.snp.makeConstraints { make in
            make.top.equalTo(barChartView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
        }
        
        view.addSubview(countAllDistance)
        countAllDistance.snp.makeConstraints { make in
            make.top.equalTo(titleAllDistance.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(20)
        }
        
        view.addSubview(titleAllTime)
        titleAllTime.snp.makeConstraints { make in
            make.top.equalTo(barChartView.snp.bottom).offset(20)
            make.centerX.equalToSuperview().offset(20)
        }
        
        view.addSubview(countAllTime)
        countAllTime.snp.makeConstraints { make in
            make.top.equalTo(titleAllTime.snp.bottom).offset(10)
            make.centerX.equalToSuperview().offset(20)
        }
    }
    
    @objc private func tappedButtonDown() {
        logger.log("\(#fileID) -> \(#function)")
        forwardPeriodButton.isHidden = false
        presenter.tappedButtonMoverment(segmentIndex: selectPeriod.selectedSegmentIndex, moverment: "back")
    }
    
    @objc private func tappedButtonUp() {
        logger.log("\(#fileID) -> \(#function)")
        presenter.tappedButtonMoverment(segmentIndex: selectPeriod.selectedSegmentIndex, moverment: "forward")
    }
    
    @objc private func reloadSegmentPeriod() {
        logger.log("\(#fileID) -> \(#function)")
        presenter.tappedButtonMoverment(segmentIndex: selectPeriod.selectedSegmentIndex, moverment: "")
    }
}

// MARK: Extension - ChartsPresenterToViewProtocol
extension ChartsViewController: ChartsPresenterToViewProtocol {
    func setDataInChartsSingleColumn(distance: String, time: String) {
        logger.log("\(#fileID) -> \(#function)")
        countAllDistance.text = distance
        countAllTime.text = time
    }
    
    func setDataInCharts(dateWeek: String, dataCharts: [BarChartDataEntry], distance: String, time: String, hiddenButton: Int) {
        logger.log("\(#fileID) -> \(#function)")
        let chartDataSet = BarChartDataSet(entries: dataCharts, label: "")
        chartDataSet.colors = [UIColor.blue]
        chartDataSet.drawValuesEnabled = false
        let chartData = BarChartData(dataSet: chartDataSet)
        barChartView.data = chartData
        
        countAllDistance.text = distance
        countAllTime.text = time
        titlePeriod.text = dateWeek
        
        switch hiddenButton {
        case 0:
            forwardPeriodButton.isHidden = false
            backPeriodButton.isHidden = true
        case 1:
            forwardPeriodButton.isHidden = true
            backPeriodButton.isHidden = false
        case 2:
            forwardPeriodButton.isHidden = false
            backPeriodButton.isHidden = false
        default:
            break
        }
    }
}

// MARK: Extension - DetailedTrainingRouterToViewProtocol
extension ChartsViewController: ChartsRouterToViewProtocol {
    func presentView(view: UIViewController) {
        logger.log("\(#fileID) -> \(#function)")
        present(view, animated: true, completion: nil)
    }
    
    func pushView(view: UIViewController) {
        logger.log("\(#fileID) -> \(#function)")
        navigationController?.pushViewController(view, animated: true)
    }
}

extension ChartsViewController: ChartViewDelegate {
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        logger.log("\(#fileID) -> \(#function)")
        presenter.tappedXAxis(xAxis: entry.x)
    }
}
