//
//  CallViewController.swift
//  VideoChat
//
//  Created Mac First UPTech on 3/31/17.
//  Copyright © 2017 Mac First UPTech. All rights reserved.
//
// Required implementation
// StoryboardInitializable.swift
// CallViewModel.swift


import UIKit
import RxSwift
import RxCocoa
import Quickblox
import QuickbloxWebRTC

final class CallViewController: UIViewController, StoryboardInitializable {

  // MARK: - Public Properties
  var viewModel: CallViewModelProtocol!

  // MARK: - Outlets
  @IBOutlet weak var localVideoView: UIView!
  @IBOutlet weak var opponentVideoView: QBRTCRemoteVideoView!
  // MARK: - Private Properties

  var session: QBRTCSession?
  fileprivate var videoCapture: QBRTCCameraCapture?
  private let disposeBag = DisposeBag()

  // MARK: - View Lifecycle
		override func viewDidLoad() {
      super.viewDidLoad()
      if session != nil {
        setup()
      }
  }

  // MARK: - Binding
  func bindViewModel() {}

}

extension CallViewController: QBRTCClientDelegate {
  func setup() {
    QBRTCClient.instance().add(self)

    let videoFormat = QBRTCVideoFormat.init()
    videoFormat.frameRate = 30
    videoFormat.pixelFormat = QBRTCPixelFormat.format420f
    videoFormat.width = 640
    videoFormat.height = 480

    self.videoCapture = QBRTCCameraCapture.init(videoFormat: videoFormat, position: AVCaptureDevicePosition.front)
    guard let videoCapture = self.videoCapture else { return }
    guard let session = self.session else { return }

    session.localMediaStream.videoTrack.videoCapture = videoCapture
    videoCapture.previewLayer.frame = self.localVideoView.bounds
    videoCapture.startSession()
    self.localVideoView.layer.insertSublayer(videoCapture.previewLayer, at: 0)
    startCall()
  }

  func startCall() {
    session?.startCall(nil)
  }


  func didReceiveNewSession(_ session: QBRTCSession, userInfo: [String : String]? = nil) {

    if self.session != nil {
      session.rejectCall(nil)
    } else {
      self.session = session
      startCall()
    }
  }

  private func session(session: QBRTCSession!, receivedRemoteVideoTrack videoTrack: QBRTCVideoTrack!, fromUser userID: NSNumber!) {
    self.opponentVideoView?.setVideoTrack(videoTrack)
  }
}
