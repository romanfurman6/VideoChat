//
//  AppCoordinator.swift
//  VideoChat
//
//  Created by Mac First UPTech on 3/31/17.
//  Copyright © 2017 Mac First UPTech. All rights reserved.
//

import RxSwift

class AppCoordinator: CoordinatorProtocol {

    var finished: Observable<Void> { return Observable.just() }

    private var loginCoordinator: CoordinatorProtocol?
    private let window = UIWindow()
    private let navigationController: UINavigationController
    private let disposeBag = DisposeBag()

    init() {
        self.navigationController = UINavigationController()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }

    func start() {
        showLogin()
    }

    func showLogin() {
        loginCoordinator = LoginCoordinator(navigationController: navigationController)
        loginCoordinator?.start()
    }
    
    func finish() {}
}
