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
import AVKit
import AVFoundation

final class MainViewController: UIViewController, StoryboardInitializable {

    // MARK: - Outlets
    @IBOutlet weak var callButton: UIButton!
    @IBOutlet weak var localVideoView: UIView!
    @IBOutlet weak var remoteVideoView: QBRTCRemoteVideoView!
    @IBOutlet weak var hideCamera: UIButton!
    @IBOutlet weak var rejectCallButton: UIButton!

    var user: QBUUser?
    fileprivate var videoCapture: QBRTCCameraCapture?
    fileprivate var currentSession: QBRTCSession?
    private let disposeBag = DisposeBag()

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        QBRTCClient.initializeRTC()
        QBRTCClient.instance().add(self)
        QBRTCAudioSession.instance().addDelegate(self)
        self.callButton.isEnabled = false
        //createNewSession()
        setupAudio()
        setup()

        callButton.rx.tap
            .bindNext(startCall)
            .disposed(by: disposeBag)

        hideCamera.rx.tap
            .bindNext(hideCameraView)
            .disposed(by: disposeBag)

        rejectCallButton.rx.tap
            .bindNext(rejectCall)
            .disposed(by: disposeBag)
    }

    func hideCameraView() {
        localVideoView.isHidden = !localVideoView.isHidden
        if localVideoView.isHidden {
            hideCamera.setTitle("show", for: .normal)
        } else {
            hideCamera.setTitle("hide", for: .normal)
        }
    }

    func rejectCall() {
        currentSession?.hangUp(nil)
        rejectCallButton.isHidden = true
        callButton.isHidden = false
    }

    func createNewSession() {
        let user = Constant.secondUser
        currentSession = QBRTCClient.instance().createNewSession(withOpponents: [user.id], with: QBRTCConferenceType.video)
        self.callButton.isEnabled = true
    }

    func startCall() {
        guard let session = currentSession else {
            showInfoAlert(message: "session is nil")
            return
        }
        session.startCall(nil)
        rejectCallButton.isHidden = false
        callButton.isHidden = true
    }

    func showCallAlertController(with session: QBRTCSession) {

        let alert = UIAlertController(title: "VideoChat", message: "You did receive new session", preferredStyle: .alert)
        let accept = UIAlertAction(title: "Accept", style: .default, handler: { _ in
            self.currentSession = session
            self.setupAudio()
            self.setup()
            session.acceptCall(nil)
            self.rejectCallButton.isHidden = false
            self.callButton.isHidden = true
        })
        let decline = UIAlertAction(title: "Decline", style: .cancel, handler: { _ in
            session.rejectCall(nil)
        })
        alert.addAction(accept)
        alert.addAction(decline)
        self.present(alert, animated: true, completion: nil)
    }

    func showInfoAlert(with title: String = "VideoChat", message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }

    func hangUP() {
        self.currentSession?.hangUp(nil)
    }

    func setupAudio() {
        QBRTCAudioSession.instance().initialize { (configuration) in

            if (self.currentSession?.conferenceType == QBRTCConferenceType.video) {
                configuration.mode = AVAudioSessionModeVideoChat
            }
        }
        QBRTCAudioSession.instance().currentAudioDevice = QBRTCAudioDevice.speaker
    }
}

extension MainViewController: QBRTCClientDelegate {

    func didReceiveNewSession(_ session: QBRTCSession, userInfo: [String : String]? = nil) {
        if self.currentSession == nil {
            showCallAlertController(with: session)
        } else {
            session.rejectCall(nil)
        }
    }

    func session(_ session: QBRTCBaseSession, receivedRemoteVideoTrack videoTrack: QBRTCVideoTrack, fromUser userID: NSNumber) {
        self.remoteVideoView.setVideoTrack(videoTrack)
    }

    func setup() {

        let videoFormat = QBRTCVideoFormat.init()
        videoFormat.frameRate = 30
        videoFormat.pixelFormat = QBRTCPixelFormat.format420f
        videoFormat.width = 640
        videoFormat.height = 480

        self.videoCapture = QBRTCCameraCapture.init(videoFormat: videoFormat, position: AVCaptureDevicePosition.front)
        guard let videoCapture = self.videoCapture else { return }
        guard let session = self.currentSession else { return }

        session.localMediaStream.videoTrack.videoCapture = videoCapture
        videoCapture.previewLayer.frame = self.localVideoView.bounds
        videoCapture.startSession()
        self.localVideoView.layer.insertSublayer(videoCapture.previewLayer, at: 0)
    }

    func session(_ session: QBRTCSession, userDidNotRespond userID: NSNumber) {
        showInfoAlert(message: "\(userID) did not respond")
    }

    func session(_ session: QBRTCSession, rejectedByUser userID: NSNumber, userInfo: [String : String]? = nil) {
        showInfoAlert(message: "\(userID) rejected call")
    }

    func session(_ session: QBRTCSession, acceptedByUser userID: NSNumber, userInfo: [String : String]? = nil) {
        print("Accepted")
    }
}

extension MainViewController: QBRTCAudioSessionDelegate {
    func audioSession(_ audioSession: QBRTCAudioSession, didFailToChangeAudioDeviceWithError error: Error) {
        print(error.localizedDescription)
    }
}
