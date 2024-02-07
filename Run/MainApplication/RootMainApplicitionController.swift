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
        logger.log("\(#fileID) -> \(#function)")
        view.backgroundColor = .blue
        modalPresentationStyle = .fullScreen
        modalTransitionStyle = .coverVertical

        let stopwatchViewController = StopwatchConfigurator().configure()
        let trainingViewController = UINavigationController(rootViewController: TrainingConfigurator().configure())
        let profileViewController = UINavigationController(rootViewController: ProfileConfigurator().configure())

        stopwatchViewController.title = Tx.Timer.title
        trainingViewController.title = Tx.Training.title
        profileViewController.title = Tx.Profile.title

        viewControllers = [stopwatchViewController, trainingViewController, profileViewController]
        guard let items = self.tabBar.items else { return }

        items[0].image = UIImage(systemName: "clock.arrow.circlepath")
        items[1].image = UIImage(systemName: "figure.walk.circle")
        items[2].image = UIImage(systemName: "person.crop.circle")

        tabBar.tintColor = .black
        tabBar.backgroundColor = .white
        tabBar.frame.size.height = 90
        selectedIndex = 0
    }
}
