//
//  PlayerViewController.swift
//  MyMuz
//
//  Created by Garnik on 3/4/22.
//
import AVFoundation
import UIKit

class PlayerViewController: UIViewController {

    public var position: Int = 0
    public var songs: [Song] = []
    
    @IBOutlet var holder: UIView!
    
    var player: AVAudioPlayer?
    private let albumImageView: UIImageView = {
        let albumImage = UIImageView()
        albumImage.contentMode = .scaleAspectFill
        return albumImage
    }()

    private let songNameLabel: UILabel = {
        let songName = UILabel()
        songName.textAlignment = .center
        songName.numberOfLines = 0
        songName.textColor = .white
        return songName
    }()

    private let artistNameLabel: UILabel = {
        let artistName = UILabel()
        artistName.textAlignment = .center
        artistName.numberOfLines = 0
        artistName.textColor = .white
        return artistName
    }()
    
    let playerPauseButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if holder.subviews.count == 0 {
            configure()
        }
    }
    
    func configure() {
        let song = songs[position]
        let url = Bundle.main.path(forResource: song.trackName, ofType: "mp3")
        do {
            try AVAudioSession.sharedInstance().setMode(.default)
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
            
            guard let urlString = url else { return }
            
            player = try AVAudioPlayer(contentsOf: URL(string: urlString)!)
            guard let player = player else {
                return
            }
            player.volume = 0.5
            
            player.play()
                                       
        }
        catch{
            print("error")
        }
        
        albumImageView.frame = CGRect(x: 10,
                                      y: 10,
                                      width: holder.frame.size.width - 20,
                                      height: holder.frame.size.width - 20)
        artistNameLabel.frame = CGRect(x: 10,
                                      y: albumImageView.frame.size.height + 10 + 70,
                                      width: holder.frame.size.width - 20,
                                      height: 70)
        songNameLabel.frame = CGRect(x: 10,
                                      y: albumImageView.frame.size.height + 10 + 140,
                                      width: holder.frame.size.width - 20,
                                      height: 70)
        albumImageView.image = UIImage(named: song.imageName)
        artistNameLabel.text = song.artistName
        artistNameLabel.font = UIFont(name: "Helvetica-Bold", size: 22)
        songNameLabel.text = song.name
        songNameLabel.font = UIFont(name: "Helvetica-Bold", size: 17)
        
        holder.addSubview(albumImageView)
        holder.addSubview(artistNameLabel)
        holder.addSubview(songNameLabel)
        
        let nextSongButton = UIButton()
        let prevSongButton = UIButton()
        
        playerPauseButton.setBackgroundImage(UIImage(systemName: "pause.fill"), for: .normal)
        nextSongButton.setBackgroundImage(UIImage(systemName: "forward.fill"), for: .normal)
        prevSongButton.setBackgroundImage(UIImage(systemName: "backward.fill"), for: .normal)

        let yPosition = artistNameLabel.frame.origin.y + 150
        let size: CGFloat = 70
        
        playerPauseButton.frame = CGRect(x: (holder.frame.size.width - size) / 2.0,
                                         y: yPosition,
                                         width: size,
                                         height: size)
        nextSongButton.frame = CGRect(x: playerPauseButton.frame.size.width + 40 + 160,
                                       y: yPosition + 15,
                                       width: size / 2,
                                       height: size / 2)
        prevSongButton.frame = CGRect(x: playerPauseButton.frame.size.width + 40,
                                      y: yPosition + 15,
                                      width: size / 2,
                                      height: size / 2)

        playerPauseButton.addTarget(self, action: #selector(didTapPlayPauseButton), for: .touchUpInside)
        nextSongButton.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
        prevSongButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)

        playerPauseButton.tintColor = .white
        nextSongButton.tintColor = .white
        prevSongButton.tintColor = .white

        holder.addSubview(playerPauseButton)
        holder.addSubview(nextSongButton)
        holder.addSubview(prevSongButton)

        let slider = UISlider(frame: CGRect(x: 30,
                                            y: holder.frame.size.height - 60,
                                            width: holder.frame.size.width - 50,
                                            height: 50))
        
        slider.maximumValueImage = UIImage(systemName: "volume.3")
        slider.minimumValueImage = UIImage(systemName: "volume")
        slider.value = 0.5
        slider.tintColor = .white
        slider.addTarget(self, action: #selector(didslideSlider(_:)), for: .valueChanged)
        holder.addSubview(slider)
    }

    @objc func didTapBackButton() {
        if position > 0 {
            position = position - 1
            player?.stop()
            for subview in holder.subviews {
                subview.removeFromSuperview()
            }
            configure()
        }
    }

    @objc func didTapNextButton() {
        if position < (songs.count - 1) {
            position = position + 1
            player?.stop()
            for subview in holder.subviews {
                subview.removeFromSuperview()
            }
            configure()
        }
    }

    @objc func didTapPlayPauseButton() {
        if player?.isPlaying == true {
            player?.pause()
            playerPauseButton.setBackgroundImage(UIImage(systemName: "play.fill"), for: .normal)
            UIView.animate(withDuration: 0.2, animations: {
                self.albumImageView.frame = CGRect(x: 30,
                                                   y: 30,
                                                   width: self.holder.frame.size.width - 60,
                                                   height: self.holder.frame.size.width - 60)
            })
        } else {
            player?.play()
            playerPauseButton.setBackgroundImage(UIImage(systemName: "pause.fill"), for: .normal)
            UIView.animate(withDuration: 0.2, animations: {
                self.albumImageView.frame = CGRect(x: 10,
                                                   y: 10,
                                                   width: self.holder.frame.size.width - 20,
                                                   height: self.holder.frame.size.width - 20)
            })
        }
    }

    @objc func didslideSlider(_ slider: UISlider) {
        let value = slider.value
        player?.volume = value
    }
}
