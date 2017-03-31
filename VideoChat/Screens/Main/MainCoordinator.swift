//
//  MainCoordinator.swift
//  VideoChat
//
//  Created Mac First UPTech on 3/31/17.
//  Copyright © 2017 Mac First UPTech. All rights reserved.
//
// Required implementation
// CoordinatorProtocol.swift

import UIKit
import RxSwift
import Quickblox
import QuickbloxWebRTC

class MainCoordinator: CoordinatorProtocol {

  // MARK: - Public Properties

  var finished: Observable<Void> { return finishedSubject.asObservable() }

  // MARK: - Private Properties

  private var finishedSubject = PublishSubject<Void>()
  private let navigationController: UINavigationController
  private let disposeBag = DisposeBag()
  private var callCoordinator: CoordinatorProtocol?

  // MARK: - Lifecycle

  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }

  // MARK: - Coordinator Methods

  func start() {
    QBRTCClient.initializeRTC()
    let viewController = MainViewController.initFromStoryboard()
    viewController.didPressCallButton
      .observeOn(MainScheduler.instance)
      .subscribe(onNext: { session in
        self.showCall(with: session)
      })
      .disposed(by: disposeBag)
    self.navigationController.setViewControllers([viewController], animated: true)
  }

  func finish() {}

  func showCall(with session: QBRTCSession) {
    callCoordinator = CallCoordinator(navigationController: self.navigationController, session: nil)
    callCoordinator?.start()
  }

}
