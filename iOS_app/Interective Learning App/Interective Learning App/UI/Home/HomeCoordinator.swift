//
//  HomeCoordinator.swift
//  Interective Learning App
//
//  Created by Prefect on 10.09.2021.
//

import Foundation
import UIKit

class HomeCoordinator: NSObject {
    
    private var navigationController: UINavigationController?
    
    init(_ navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func start() {
        guard let viewController = makeViewController() else { return }
        navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: - Private
private extension HomeCoordinator {
    
    func makeViewController() -> UIViewController? {
        let viewController = R.storyboard.homeViewController.instantiateInitialViewController()
        viewController?.configure(self)
        return viewController
    }
}

extension HomeCoordinator {
    
    func startCustomizeFlow() {
        let customizeCoordinator = CustomizeCoordinator(navigationController)
        customizeCoordinator.start()
    }
}

