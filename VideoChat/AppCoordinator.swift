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
  private var mainCoordinator: CoordinatorProtocol?
  private var loginCoordinator: LoginCoordinatorProtocol?
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
    //showMain()
  }

  func showMain() {
    mainCoordinator = MainCoordinator(navigationController: navigationController)
    mainCoordinator?.start()
  }

  func showLogin() {
    loginCoordinator = LoginCoordinator(navigationController: navigationController)
    loginCoordinator?.didRegistered
      .subscribe(onNext: { [weak self] in
        self?.showMain()
      })
      .disposed(by: disposeBag)
    loginCoordinator?.start()
  }

  func finish() {}
}
