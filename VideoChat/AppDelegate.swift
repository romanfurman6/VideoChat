//
//  AppDelegate.swift
//  VideoChat
//
//  Created by Mac First UPTech on 3/31/17.
//  Copyright © 2017 Mac First UPTech. All rights reserved.
//

import UIKit
import Quickblox

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private var appCoordinator: CoordinatorProtocol?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        setupQBSetting()
        startAppCoordinator()

        return true
    }

    private func startAppCoordinator() {
        appCoordinator = AppCoordinator()
        appCoordinator?.start()
    }

    private func setupQBSetting() {
        QBSettings.setAuthKey(Constant.QBAuthKey)
        QBSettings.setAuthSecret(Constant.QBAuthSecret)
        QBSettings.setAccountKey(Constant.QBAccountKey)
        QBSettings.setApplicationID(Constant.QBApplicationID)
        QBSettings.setLogLevel(QBLogLevel.debug)
    }
    
}

