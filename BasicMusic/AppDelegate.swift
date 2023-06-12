//
//  AppDelegate.swift
//  BasicMusic
//
//  Created by Nikolay Pivnik on 15.02.23.
//

import UIKit
import Core
import IQKeyboardManagerSwift
import AVFoundation

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        self.configKeyboard()
        self.configurePlayer()

        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(
        _ application: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options: UIScene.ConnectionOptions
    ) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(
        _ application: UIApplication,
        didDiscardSceneSessions sceneSessions: Set<UISceneSession>
    ) {}

    private func configKeyboard() {
        IQKeyboardManager.shared.enable = true
    }

    private func configurePlayer() {
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(
                AVAudioSession.Category.playback, mode: AVAudioSession.Mode.default
            )
        } catch let error as NSError {
            print("playback failed : \(error)")
        }
    }
}
