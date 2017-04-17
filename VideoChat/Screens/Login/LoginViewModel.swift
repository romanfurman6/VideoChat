//
//  LoginViewModel.swift
//  VideoChat
//
//  Created Mac First UPTech on 3/31/17.
//  Copyright © 2017 Mac First UPTech. All rights reserved.
//

import UIKit
import RxSwift
import Quickblox
import QuickbloxWebRTC

protocol LoginViewModelProtocol {
    func signIn()
    var user: PublishSubject<QBUUser> { get }
    var login: String { get }
    var password: String { get }
}

class LoginViewModel: LoginViewModelProtocol {

    let user = PublishSubject<QBUUser>()
    private let currentUser: User

    var login: String {
        return currentUser.name
    }

    var password: String {
        return currentUser.password
    }

    init(user: User) {
        self.currentUser = user
    }

    func signIn() {
        
        QBRequest.logIn(withUserLogin: login, password: password, successBlock: { (response, user) in
            if response.isSuccess {

                guard let user = user else { return }
                print("LOGIN IS COMPLETED WITH USER ID \(user.id)")
                user.password = self.currentUser.password
                QBChat.instance().connect(with: user, completion: { _ in
                    print("---CONNECTED TO CHAT---")
                    self.user.onNext(user)
                })
            } else {
                print(response.error?.description ?? "error-string")
            }
        }, errorBlock: nil)
    }
}
