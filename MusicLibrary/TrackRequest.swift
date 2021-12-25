//
//  TrackRequest.swift
//  MusicLib
//
//  Created by Nabilah Ashriyah on 25/12/21.
//

import Foundation
import Alamofire
import SwiftyJSON

class TrackRequest {
    var page: Int = 1
    
    func searchArtist(artist: String = "", pageSize: Int = 12, completion: @escaping (Result<[Track]?,Error>) -> Void) {
        let trackSearchAPI = "https://api.musixmatch.com/ws/1.1/track.search?"
        let parameter = "q_artist=\(artist)&page_size=\(pageSize)&page=\(self.page)"
        let apikey = "apikey=4f7549e47cbd524ddda8f7ca760b4277&"
        
        AF.request(trackSearchAPI + apikey + parameter).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let message = json["message"]
                let body = message["body"]
                let result = body["track_list"]
                
                var trackList: [Track] = []
                
                for i in 0 ..< result.count{
                    var track = Track()
                    track.track_name = result[i]["track"]["track_name"].string
                    track.artist_name = result[i]["track"]["artist_name"].string
                    
                    trackList.append(track)
                }
                
                completion(.success(trackList))
                
            case .failure(let error):
                print(error)
                completion(.failure(error))
                return
            }
        }
    }
}
