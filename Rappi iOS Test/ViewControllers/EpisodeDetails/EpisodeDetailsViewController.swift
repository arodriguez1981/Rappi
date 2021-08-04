//
//  EpisodeDetailsViewController.swift
//  Rappi iOS Test
//
//  Created by Alex Rodriguez on 04/08/21.
//  Copyright © 2021 Alex Rodriguez. All rights reserved.
//

import UIKit

class EpisodeDetailsViewController: UIViewController {
    
    @IBOutlet var ivbackPhoto: UIImageView!
    @IBOutlet var lblGenres: UILabel!
    @IBOutlet var lblOverview: UILabel!
    @IBOutlet var lblStatus: UILabel!
    @IBOutlet var lblPopularity: UILabel!
    @IBOutlet var lblVoteAverage: UILabel!
    @IBOutlet var lblVoteCounts: UILabel!
    @IBOutlet var lblFirstAirDate: UILabel!
    @IBOutlet var lblName: UILabel!
    @IBOutlet var ivPhoto: UIImageView!

    var elementId = 0
    var workItem: DispatchWorkItem?
    let dateFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        workItem?.cancel()
        getEpisodeDetails()
        // Do any additional setup after loading the view.
    }
    
    
    func getEpisodeDetails() {
        var params = [String: AnyObject]()
        headers = [
            "Authorization": "Bearer " + (accessToken),
            "Accept": "application/json;charset=utf-8"
        ]
        params["redirect_to"] = "http://www.themoviedb.org/" as AnyObject
        NetConnection.getEpisodeDetails(elementId, response: ResponseHandler(startHandler: nil , success: { response in
            DispatchQueue.main.async(execute: {() -> Void in
                let data = AppDelegate.jsonToNSData(response as AnyObject)
                let decoder = JSONDecoder()
                
                self.dateFormatter.dateFormat = "yyyy-MM-dd"
                self.dateFormatter.locale = Locale(identifier: "en_US")
                self.dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
                decoder.dateDecodingStrategy = .formatted(self.dateFormatter)
                do {
                    let episodeDetails = try decoder.decode(EpisodeDetails.self, from: data!)
                    self.fillInfo(episodeDetails)
                } catch {print (error) }
            })
            return nil
        } , failure: {(_ error: NSError, data: Data?) in
            DispatchQueue.main.async(execute: {() -> Void in
            })
        }))
    }
    
    private func fillInfo(_ episodeDetails: EpisodeDetails) {
        lblStatus.text = episodeDetails.status!
        lblPopularity.text = "\(episodeDetails.popularity)"
        lblVoteCounts.text = "\(episodeDetails.vote_count)"
        lblVoteAverage.text = "\(episodeDetails.vote_average)".appending(" / 10")
        lblOverview.text = episodeDetails.overview!
        lblName.text = episodeDetails.name!
        lblFirstAirDate.text = dateFormatter.string(from: episodeDetails.first_air_date!)
        var genres = ""
        for genre in episodeDetails.genres!{
            if genres.isEmpty {
                genres = genre.name!
            } else {
                genres += " , \(genre.name!)"
            }
        }
        lblGenres.text = genres
        if episodeDetails.poster_path != nil{
            let urlImage = "https://image.tmdb.org/t/p/w185/" + episodeDetails.poster_path!
            ivPhoto.setImageWith(URL(string: urlImage)!, placeholderImage: UIImage(named:"star"))
        }
        if episodeDetails.backdrop_path != nil{
            let urlImageBack = "https://image.tmdb.org/t/p/w185/" + episodeDetails.backdrop_path!
            ivbackPhoto.setImageWith(URL(string: urlImageBack)!, placeholderImage: UIImage(named:"star"))
        }
        
        
    }
    
    
    
}

