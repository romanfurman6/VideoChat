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
    @IBOutlet weak var loginButton: UIButton!

    // MARK: - Private Properties
    private let disposeBag = DisposeBag()

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        nameTextField.text = viewModel.login
        passwordTextField.text = "******"

        self.navigationController?.isNavigationBarHidden = true

        loginButton.rx.tap
            .bindNext {
                self.viewModel.signIn()
            }
            .disposed(by: disposeBag)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        nameTextField.resignFirstResponder()
    }
}
