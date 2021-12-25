//
//  ViewController.swift
//  MoviesList
//
//  Created by Nabilah Ashriyah on 25/12/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var trackList: [Track] = []
    
    var request = TrackRequest()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self

        // configure view
        tableView.estimatedRowHeight = 64
        tableView.rowHeight = UITableView.automaticDimension
        tableView.sectionHeaderHeight = 28
        tableView.sectionFooterHeight = 28
        
        
        request.searchArtist(artist: "", pageSize: 12, completion: { result in
            switch result {
            case .success(let trackList):
                if let trackList = trackList {
                    self.trackList.removeAll()
                    self.trackList.append(contentsOf: trackList)
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
            
        })
    }
}

extension ViewController {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        request.searchArtist(artist: searchText, pageSize: 12, completion: { result in
            switch result {
            case .success(let trackList):
                if let trackList = trackList {
                    self.trackList.removeAll()
                    self.trackList.append(contentsOf: trackList)
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        })
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

extension ViewController {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TrackTableViewCell", for: indexPath) as! TrackTableViewCell
        cell.artistLabel.text = self.trackList[indexPath.row].artist_name
        cell.songLabel.text = self.trackList[indexPath.row].track_name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trackList.count
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == trackList.count - 1 {
            request.page += 1
            let searchText = searchBar.text ?? ""
            request.searchArtist(artist: searchText, pageSize: 12, completion: { result in
                switch result {
                case .success(let trackList):
                    if let trackList = trackList {
                        self.trackList.append(contentsOf: trackList)
                        self.tableView.reloadData()
                    }
                case .failure(let error):
                    print(error)
                }
            })
        }
    }
}

