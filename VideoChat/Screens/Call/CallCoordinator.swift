//
//  CallCoordinator.swift
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

class CallCoordinator: CoordinatorProtocol {

  // MARK: - Public Properties

  var finished: Observable<Void> { return finishedSubject.asObservable() }

  // MARK: - Private Properties

  private var finishedSubject = PublishSubject<Void>()
  private let navigationController: UINavigationController
  private let disposeBag = DisposeBag()
  private let currentSession: QBRTCSession?

  // MARK: - Lifecycle

  init(navigationController: UINavigationController, session: QBRTCSession? = nil) {
    self.navigationController = navigationController
    self.currentSession = session
  }

  // MARK: - Coordinator Methods

  func start() {
    let viewController = CallViewController.initFromStoryboard()
    let viewModel = CallViewModel()
    viewController.viewModel = viewModel
    viewController.session = currentSession
    self.navigationController.pushViewController(viewController, animated: true)
  }

  func finish() {
    self.navigationController.popViewController(animated: true)
  }

}
