//
//  LoginCoordinator.swift
//  VideoChat
//
//  Created Mac First UPTech on 3/31/17.
//  Copyright © 2017 Mac First UPTech. All rights reserved.
//

import UIKit
import RxSwift

protocol LoginCoordinatorProtocol: CoordinatorProtocol {
  var didRegistered: PublishSubject<Void> { get }
}

class LoginCoordinator: LoginCoordinatorProtocol {

  // MARK: - Public Properties

  var finished: Observable<Void> { return finishedSubject.asObservable() }
  let didRegistered = PublishSubject<Void>()

  // MARK: - Private Properties

  private var finishedSubject = PublishSubject<Void>()
  private let navigationController: UINavigationController
  private let disposeBag = DisposeBag()

  // MARK: - Lifecycle

  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }

  // MARK: - Coordinator Methods

  func start() {
    let viewController = LoginViewController.initFromStoryboard()
    let viewModel = LoginViewModel()
    viewController.viewModel = viewModel
    self.navigationController.setViewControllers([viewController], animated: true)
  }

  func finish() {}

}
