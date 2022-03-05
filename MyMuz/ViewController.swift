//
//  ViewController.swift
//  MyMuz
//
//  Created by Garnik on 3/4/22.
//

import UIKit

struct Song {
    let name: String
    let albumName: String
    let artistName: String
    let imageName: String
    let trackName: String
}
class ViewController: UIViewController {
   
    @IBOutlet weak var tableView: UITableView!
    
    var songs = [Song]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
        configureSongs()
    }
    
    func configureSongs() {
        songs.append(Song(name: "The Next Episode",
                          albumName: "Dre",
                          artistName: "Dr Dre, Snoop Dog",
                          imageName: "cover1",
                          trackName: "song1"))
        songs.append(Song(name: "Obraz",
                          albumName: "Love",
                          artistName: "Idris, Leos",
                          imageName: "cover2",
                          trackName: "song2"))
        songs.append(Song(name: "Love the way you lie",
                          albumName: "Slim Shady",
                          artistName: "Rihanna, Eminem",
                          imageName: "cover3",
                          trackName: "song"))
        songs.append(Song(name: "We don't talk anymore",
                          albumName: "We",
                          artistName: "Sabrina",
                          imageName: "cover4",
                          trackName: "song4"))
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let position = indexPath.row
        
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "PlayerViewController") as? PlayerViewController else {
            return
        }
        vc.songs = songs
        vc.position = position
        present(vc, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let song = songs[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as? TableViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: song)
        cell.backgroundColor = .tertiaryLabel
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
