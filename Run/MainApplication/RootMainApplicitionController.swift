//
//  RootMainApplicitionController.swift
//  Run
//
//  Created by Лукичев Сергей on 24.08.2023.
//

import UIKit
import SnapKit

final class RootMainApplicitionController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        modalPresentationStyle = .fullScreen
        modalTransitionStyle = .coverVertical

        let stopwatchViewController = StopwatchConfigurator().configure()
        let trainingViewController = TrainingConfigurator().configure()
        let profileViewController = ProfileConfigurator().configure()

        stopwatchViewController.title = "Секундомер"
        trainingViewController.title = "Тренировки"
        profileViewController.title = "Профиль"

        viewControllers = [stopwatchViewController, trainingViewController, profileViewController]

        guard let items = self.tabBar.items else { return }

        let imageStopwatch = UIImage(systemName: "clock.arrow.circlepath")
        let imageTraining = UIImage(systemName: "figure.walk.circle")
        let imageProfile = UIImage(systemName: "person.crop.circle")
        let views = [imageStopwatch, imageTraining, imageProfile]

        for item in 0..<items.count {
            items[item].image = views[item]
        }

        let customTabBar = UITabBar()
        customTabBar.items = items
        customTabBar.tintColor = .black
        customTabBar.selectedItem = customTabBar.items?.first
        
        selectedIndex = 0

        view.addSubview(customTabBar)
        customTabBar.snp.makeConstraints { make in
            make.bottom.right.left.equalToSuperview()
            make.height.equalTo(90)
        }
    }
}
