//
//  StageCoordinator.swift
//  Interective Learning App
//
//  Created by Prefect on 12.09.2021.
//

import UIKit

class StageCoordinator {

    private var window: UIWindow?
    private var navigationController: UINavigationController?
    
    init(_ window: UIWindow?) {
        self.window = window
    }
    
    func start() {
        guard let viewController = makeViewController() else { return }
        navigationController = UINavigationController(rootViewController: viewController)
        window?.rootViewController = navigationController
    }
}

extension StageCoordinator {
    
    func makeViewController() -> UIViewController? {
        let viewController = R.storyboard.stageViewController.instantiateInitialViewController()
        viewController?.configure(self)
        return viewController
    }
    
    func showHomeFlow() {
        HomeCoordinator(navigationController).start()
    }
}
