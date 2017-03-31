//
//  LoginViewController.swift
//  VideoChat
//
//  Created Mac First UPTech on 3/31/17.
//  Copyright © 2017 Mac First UPTech. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Quickblox
import QuickbloxWebRTC

final class LoginViewController: UIViewController, StoryboardInitializable {

  // MARK: - Public Properties

  var viewModel: LoginViewModelProtocol!

  // MARK: - Outlets
  @IBOutlet weak var nameTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  @IBOutlet weak var registerButton: UIButton!

  // MARK: - Private Properties
  private let disposeBag = DisposeBag()

  // MARK: - View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationController?.isNavigationBarHidden = true
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    nameTextField.resignFirstResponder()
  }

  // MARK: - Binding

  func bindViewModel() {
    nameTextField.rx.text.orEmpty
      .asObservable()
      .subscribe(onNext: { name in
        self.viewModel.userName.onNext(name)
      })
      .disposed(by: disposeBag)

    passwordTextField.rx.text.orEmpty
      .asObservable()
      .subscribe(onNext: { pass in
        self.viewModel.userPassword.onNext(pass)
      })
      .disposed(by: disposeBag)

  }

}
