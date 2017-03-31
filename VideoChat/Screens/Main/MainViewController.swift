//
//  MainViewController.swift
//  VideoChat
//
//  Created Mac First UPTech on 3/31/17.
//  Copyright © 2017 Mac First UPTech. All rights reserved.
//
// Required implementation
// StoryboardInitializable.swift
// MainViewModel.swift


import UIKit
import RxSwift
import RxCocoa
import Quickblox
import QuickbloxWebRTC

final class MainViewController: UIViewController, StoryboardInitializable {

  var didPressCallButton = PublishSubject<QBRTCSession>()
  private let disposeBag = DisposeBag()

  // MARK: - Outlets
  @IBOutlet weak var callButton: UIButton!

  // MARK: - View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    callButton.rx.tap
      .bindNext {
        self.didPressCallButton.onNext(self.createSession(with: 25796780))
      }
      .disposed(by: disposeBag)

  }

  func createSession(with id: NSNumber) -> QBRTCSession {
    return QBRTCClient.instance().createNewSession(withOpponents: [id], with: QBRTCConferenceType.video)
  }
}
