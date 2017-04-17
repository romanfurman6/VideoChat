//
//  LoginCoordinator.swift
//  VideoChat
//
//  Created Mac First UPTech on 3/31/17.
//  Copyright © 2017 Mac First UPTech. All rights reserved.
//

import UIKit
import RxSwift
import Quickblox


protocol LoginCoordinatorProtocol: CoordinatorProtocol {

}

class LoginCoordinator: LoginCoordinatorProtocol {

    // MARK: - Public Properties

    var finished: Observable<Void> { return finishedSubject.asObservable() }

    // MARK: - Private Properties

    private var finishedSubject = PublishSubject<Void>()
    private let navigationController: UINavigationController
    private let disposeBag = DisposeBag()
    private var mainCoordinator: CoordinatorProtocol?
    private let currentUser = Constant.firstUser

    // MARK: - Lifecycle

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    // MARK: - Coordinator Methods

    func start() {

        let viewController = LoginViewController.initFromStoryboard()
        let viewModel = LoginViewModel(user: currentUser)
        viewController.viewModel = viewModel

        viewModel.user.asObservable()
            .subscribe(onNext: { user in
                self.showMain(with: user)
            })
            .disposed(by: disposeBag)
        self.navigationController.setViewControllers([viewController], animated: true)
    }

    func showMain(with user: QBUUser) {
        mainCoordinator = MainCoordinator(navigationController: navigationController, user: user)
        
        mainCoordinator?.start()
    }
    
    func finish() {}
    
}
