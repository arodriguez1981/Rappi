//
//  MovieDetailsViewController.swift
//  Rappi iOS Test
//
//  Created by Alex Rodriguez on 04/08/21.
//  Copyright © 2021 Alex Rodriguez. All rights reserved.
//

import UIKit


class MovieDetailsViewController: UIViewController {
    
    let dateFormatter = DateFormatter()
    
    @IBOutlet var lblStatus: UILabel!
    @IBOutlet var lblPopularity: UILabel!
    @IBOutlet var lblVoteCount: UILabel!
    @IBOutlet var lblVoteAverage: UILabel!
    @IBOutlet var lblOverview: UILabel!
    @IBOutlet var ivPhoto: UIImageView!
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var lblReleaseDateDuration: UILabel!
    @IBOutlet var lblGenres: UILabel!
    
    var workItem: DispatchWorkItem?
    var elementId = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        workItem?.cancel()
        getMovieDetails()
        
        // Do any additional setup after loading the view.
    }
    
    
    func getMovieDetails() {
        var params = [String: AnyObject]()
        headers = [
            "Authorization": "Bearer " + (accessToken),
            "Accept": "application/json;charset=utf-8"
        ]
        params["redirect_to"] = "http://www.themoviedb.org/" as AnyObject
        NetConnection.getMovieDetails(elementId, response: ResponseHandler(startHandler: nil , success: { response in
            DispatchQueue.main.async(execute: {() -> Void in
                let data = AppDelegate.jsonToNSData(response as AnyObject)
                let decoder = JSONDecoder()
                
                self.dateFormatter.dateFormat = "yyyy-MM-dd"
                self.dateFormatter.locale = Locale(identifier: "en_US")
                self.dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
                decoder.dateDecodingStrategy = .formatted(self.dateFormatter)
                do {
                    
                    let movieDetails = try decoder.decode(MovieDetails.self, from: data!)
                    self.fillInfo(movieDetails)
                } catch {print (error) }
            })
            return nil
        } , failure: {(_ error: NSError, data: Data?) in
            DispatchQueue.main.async(execute: {() -> Void in
            })
        }))
    }
    
    private func fillInfo(_ movieDetails : MovieDetails) {
        lblStatus.text = movieDetails.status!
        lblPopularity.text = "\(movieDetails.popularity)"
        lblVoteCount.text = "\(movieDetails.vote_count)"
        lblVoteAverage.text = "\(movieDetails.vote_average)".appending(" / 10")
        lblOverview.text = movieDetails.overview!
        lblTitle.text = movieDetails.title!
        lblReleaseDateDuration.text = dateFormatter.string(from: movieDetails.release_date!).appending(NSLocalizedString("duration", comment: "duration")).appending("\(movieDetails.runtime)").appending(" min")
        var genres = ""
        for genre in movieDetails.genres!{
            if genres.isEmpty {
                genres = genre.name!
            } else {
                genres += " , \(genre.name!)"
            }
        }
        lblGenres.text = genres
        if movieDetails.poster_path != nil{
            let urlImage = "https://image.tmdb.org/t/p/w185/" + movieDetails.poster_path!
            ivPhoto.setImageWith(URL(string: urlImage)!, placeholderImage: UIImage(named:"star"))
        }
    }
    
    
}

