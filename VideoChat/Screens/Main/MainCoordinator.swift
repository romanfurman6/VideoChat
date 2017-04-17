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
    private var startCall = PublishSubject<Void>()
    private let user: QBUUser

    // MARK: - Lifecycle

    init(navigationController: UINavigationController, user: QBUUser) {
        self.user = user
        self.navigationController = navigationController
    }

    // MARK: - Coordinator Methods

    func start() {
        
        let viewController = MainViewController.initFromStoryboard()
        viewController.user = user

        self.navigationController.pushViewController(viewController, animated: true)
    }

    func finish() {}
    
}
