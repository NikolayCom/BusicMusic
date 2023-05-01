import Core
import Models
import Resources
import AVFoundation
import MediaPlayer

// MARK: - PlayerUseCase

public protocol PlayerUseCase {
    var isPlaying: Bool { get }
    var duration: TimeInterval { get }
    var currentTime: TimeInterval { get }

    func getArtist(name: String, completion: @escaping UICompletionResult<Artist>)

    func playThisSong(activeSong: String)
    func getNowPlayingInfo() -> Song

    func slide(with interval: TimeInterval)
    func playPause()

    func setupSongs()
    func prepareSong()
    func setUpRemoteTransparentControls()
}

// MARK: - PlayerUseCaseImpl

public class PlayerUseCaseImpl: NSObject, BaseUseCase {
    private let musicRequestService: MusicRequestService?

    private lazy var audioPlayer = AVAudioPlayer()

    private var playingInfo: [String: Any] = [:]
    private lazy var activeSong: String? = songsList.first
    private var songImage: UIImage?

    private var songsList: [String] = []

    public var isPlaying: Bool {
        audioPlayer.isPlaying
    }

    public var duration: TimeInterval {
        audioPlayer.duration
    }

    public var currentTime: TimeInterval {
        audioPlayer.currentTime
    }

    public init(
        musicRequestService: MusicRequestService
    ) {
        self.musicRequestService = musicRequestService

        super.init()

        setupNotifications()
    }

    private func setupNotifications() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(handleInterruption), name: AVAudioSession.interruptionNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(handleRouteChange), name: AVAudioSession.routeChangeNotification, object: nil)
    }

    private func setCoverImage() {
        if let image = self.songImage {
            playingInfo[MPMediaItemPropertyArtwork] = MPMediaItemArtwork(boundsSize: image.size) { _ in
                return image
            }
        }
    }

    @objc func handleInterruption(notification: Notification ) {
        guard let userInfo = notification.userInfo,
              let typeValue = userInfo[AVAudioSessionInterruptionTypeKey] as? UInt,
              let type = AVAudioSession.InterruptionType(rawValue:  typeValue)
        else { return }

        if type == .began {
            print("began")
        } else if type == .ended {
            if let optionsValue = userInfo[AVAudioSessionInterruptionOptionKey] as? UInt {

                let options = AVAudioSession.InterruptionOptions(rawValue: optionsValue)
                if options.contains(.shouldResume) {
                    playThisSong(activeSong: activeSong.orEmpty)
                } else {
                    print("end")
                }
            }
        }
    }

    @objc func handleRouteChange (notificaiton :Notification) {
        guard let userInfo = notificaiton.userInfo,
              let reasonValue = userInfo[AVAudioSessionRouteChangeReasonKey] as? UInt,
              let reason = AVAudioSession.RouteChangeReason(rawValue: reasonValue)
        else { return }

        switch reason {
        case .newDeviceAvailable:
            let session = AVAudioSession.sharedInstance()
            for outPut in session.currentRoute.outputs where outPut.portType == AVAudioSession.Port.headphones {
                print("headphone connected")
                DispatchQueue.main.sync {
                    self.playThisSong(activeSong: activeSong.orEmpty)
                }
            }
            break

        case .oldDeviceUnavailable:
            if let previusChange = userInfo[AVAudioSessionRouteChangePreviousRouteKey] as? AVAudioSessionRouteDescription {
                for output in previusChange.outputs where output.portType == AVAudioSession.Port.headphones{
                    print("headphones disconnected")
                    DispatchQueue.main.sync {
                        if audioPlayer.isPlaying {
                            audioPlayer.pause()
                        }
                    }
                }
            }

            break

        default:
            ()
        }
    }

    @objc func changeThumbSlider (_ event: MPChangePlaybackPositionCommandEvent) -> MPRemoteCommandHandlerStatus {
        slide(with: event.positionTime)

        return .success
    }
}

// MARK: - PlayerUseCase

extension PlayerUseCaseImpl: PlayerUseCase {
    public func prepareSong() {
        do {
            let audioPath = Bundle.main.path(forResource: activeSong, ofType: ".mp3")
            try audioPlayer = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath!) as URL)
            audioPlayer.prepareToPlay()
            audioPlayer.delegate = self
        } catch{
            print(error.localizedDescription)
        }
    }

    public func setupSongs() {
        let folderUrl = URL(fileURLWithPath: Bundle.main.resourcePath!)
        do {
            let path = try FileManager.default.contentsOfDirectory(at: folderUrl,includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
            path.forEach { song in
                var songName = song.absoluteString
                if songName.contains(".mp3")
                {
                    let findString = songName.components(separatedBy: "/")
                    songName = findString[findString.count - 1]
                    songName = songName.replacingOccurrences(of: "%20", with: " ")
                    songName = songName.replacingOccurrences(of: ".mp3", with: "")
                    songsList.append(songName)
                }
            }
        } catch {
            print("unknown path")
        }
    }

    public func playPause() {
        if audioPlayer.isPlaying {
            audioPlayer.pause()
        }else{
            audioPlayer.play()
        }
    }

    public func slide(with interval: TimeInterval) {
        audioPlayer.currentTime =  interval
    }

    public func getNowPlayingInfo() -> Song {
        var songTitle: String = ""
        var artistImage: UIImage?
        var artistName: String = ""

        let audioPath = Bundle.main.path(forResource: activeSong, ofType: ".mp3")
        let playerItem = AVPlayerItem(url: NSURL(fileURLWithPath: audioPath!) as URL)
        let metaDataList = playerItem.asset.commonMetadata
        metaDataList.forEach { item in
            if item.commonKey!.rawValue == "title" {
                songTitle = item.stringValue!
                artistImage = UIImage(named: item.stringValue!)
            }

            if item.commonKey!.rawValue == "artist" {
                artistName = item.stringValue!
            }
        }

        playingInfo[MPMediaItemPropertyArtist] = artistName
        playingInfo[MPMediaItemPropertyTitle] = activeSong
        playingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = audioPlayer.currentTime
        playingInfo[MPNowPlayingInfoPropertyPlaybackRate] = audioPlayer.rate
        playingInfo[MPMediaItemPropertyPlaybackDuration] = audioPlayer.duration

        MPNowPlayingInfoCenter.default().nowPlayingInfo = playingInfo
        self.songImage = artistImage

        return .init(artistImage: artistImage ?? .init(), songTitle: songTitle, artistName: artistName)
    }

    public func getArtist(name: String, completion: @escaping UICompletionResult<Artist>) {
        self.musicRequestService?.getArtist(with: name) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .value(let value):
                guard let artist = value.artists.first else { return }
                completion(.value(artist))

            case .error(let error):
                completion(.error(.serverError))
            }
        }
    }

    public func playThisSong(activeSong: String) {
        self.activeSong = activeSong

        do {
            let audioPath = Bundle.main.path(forResource: activeSong, ofType: ".mp3")
            try audioPlayer = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath!) as URL)
            audioPlayer.prepareToPlay()
        }
        catch {
            print(error.localizedDescription)
        }
    }
}

extension PlayerUseCaseImpl: AVAudioPlayerDelegate {}


extension PlayerUseCaseImpl {
    public func setUpRemoteTransparentControls() {
        let commandCenter = MPRemoteCommandCenter.shared()
        commandCenter.playCommand.addTarget{
            event in
            if !self.audioPlayer.isPlaying{
                self.playPause()
                self.setCoverImage()

                return .success
            }
            return .commandFailed
        }

        commandCenter.pauseCommand.addTarget{
            event in
            if self.audioPlayer.isPlaying {
                self.audioPlayer.pause()

                return .success
            }
            return .commandFailed
        }

        commandCenter.nextTrackCommand.addTarget{
            event in
            if self.audioPlayer.isPlaying {
                // self._next()
                self.setCoverImage()
                return .success
            }
            return .commandFailed
        }

        commandCenter.previousTrackCommand.addTarget{
            event in
            if self.audioPlayer.isPlaying {
                // self._back()
                self.setCoverImage()

                return .success
            }
            return .commandFailed
        }

        commandCenter.changePlaybackPositionCommand.addTarget(self, action: #selector(changeThumbSlider(_:)))
    }
}
