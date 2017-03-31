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
  func createUser()
  var userName: PublishSubject<String> { get }
  var userPassword: PublishSubject<String> { get }
}

class LoginViewModel: LoginViewModelProtocol {

  var userName = PublishSubject<String>()
  var userPassword = PublishSubject<String>()

  func createUser() {

  }


  init() {}

}
