//
//  CategoryViewController.swift
//  Rappi iOS Test
//
//  Created by Alex Rodriguez on 04/08/21.
//  Copyright © 2021 Alex Rodriguez. All rights reserved.
//

import Foundation
import UIKit

class CategoryViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    let spinnerFooter = UIActivityIndicatorView()
    var page = 1
    var cSearchPopular = [Any]()
    var cSearchTopRated = [Any]()
    var cSearchUpcoming = [Any]()
    var cSearchList = [Any]()
    var searchTimer: Timer?
    var totalPages = 0
    var totalResults = 0
    var workItem: DispatchWorkItem?
    var areMovie = true
    @IBOutlet weak var loading: UIActivityIndicatorView!
    @IBOutlet weak var viewContainerCollections: UIView!
    @IBOutlet weak var lblNoData: UILabel!
    @IBOutlet weak var swPopular: UISwitch!
    @IBOutlet weak var swToprated: UISwitch!
    @IBOutlet weak var swUpcoming: UISwitch!
    
    @IBOutlet var btnMovies: UIButton!
    @IBOutlet var btnSeries: UIButton!
    @IBOutlet var searchTextField: UITextField!
    @IBOutlet var categoriesContainer: UIView!
    @IBOutlet var viewPopularContainer: UIView!
    @IBOutlet var viewUpcomingContainer: UIView!
    @IBOutlet var viewTopRatedContainer: UIView!
    @IBOutlet var cvPopular: UICollectionView!
    @IBOutlet var cvTopRated: UICollectionView!
    @IBOutlet var cvUpcoming: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchTextField.isEnabled = false
        self.searchTextField.autocorrectionType = .no
        self.searchTextField.clearButtonMode = .always
        if self.areMovie{
            self.getMedia("Upcoming")
        }
        self.getMedia("Popular")
        self.getMedia("Top_Rated")
        
        self.searchTextField.rightViewMode = .unlessEditing
        let img = UIImageView(image: UIImage(named: "search"))
        img.tintColor = UIColor.lightGray
        self.searchTextField.rightView = img
        self.viewContainerCollections.isHidden = true
        self.lblNoData.isHidden = true
    }
    
    @IBAction func setAreMovie(_ sender: AnyObject) {
        clearView()
        self.searchTextField.text = ""
        if sender.tag == 0{
            areMovie = true
            swUpcoming.isOn = true
            viewUpcomingContainer.isHidden = false
            self.getMedia("Upcoming")
        }
        else{
            viewUpcomingContainer.isHidden = true
            areMovie = false
        }
        swPopular.isOn = true
        swToprated.isOn = true
        self.getMedia("Popular")
        self.getMedia("Top_Rated")
    }
    
    func clearView(){
        self.page = 1
        workItem?.cancel()
        viewContainerCollections.isHidden = false
        cSearchList.removeAll(keepingCapacity: false)
        cSearchPopular.removeAll(keepingCapacity: false)
        cSearchTopRated.removeAll(keepingCapacity: false)
        cSearchUpcoming.removeAll(keepingCapacity: false)
    }
    
    func getMedia(_ type: String) {
        if cSearchTopRated.count == 0 && cSearchUpcoming.count == 0 && cSearchPopular.count == 0 && page == totalPages{
            self.lblNoData.isHidden = false
            self.btnMovies.isEnabled = true
            self.btnSeries.isEnabled = true
            self.searchTextField.isEnabled = true
            self.loading.stopAnimating()
            self.loading.isHidden = true
        }
        else{
            self.btnMovies.isEnabled = true
            self.btnSeries.isEnabled = true
            self.searchTextField.isEnabled = true
            self.loading.stopAnimating()
            self.loading.isHidden = true
            self.viewContainerCollections.isHidden = false
            self.lblNoData.isHidden = true
        }
        headers = [
            "Authorization": "Bearer " + (currentAccessToken),
            "Accept": "application/json;charset=utf-8"
        ]
        self.cSearchList.removeAll(keepingCapacity: false)
        if type == "Popular"{
            cSearchList = self.cSearchPopular
        }
        else if type == "Top_Rated"{
            cSearchList = self.cSearchTopRated
        }
        else if type == "Upcoming"{
            cSearchList =  self.cSearchUpcoming
        }
        workItem = DispatchWorkItem{
            NetConnection.getMedia(self.page, type: type, movie: self.areMovie , response: ResponseHandler(startHandler: nil , success: { [self] response in
                self.processResponse(response, type: type, connected: true)
                return nil
            } , failure: {(_ error: NSError, data: Data?) in
                DispatchQueue.main.async(execute: {() -> Void in
                    self.processResponse(nil, type: type, connected: false)
                })
            }))
        }
        DispatchQueue.main.asyncAfter(deadline: .now() , execute: workItem!)
    }
    
    func processResponse(_ response: JSON?, type: String, connected: Bool){
        var media = Array<Any>()
        if connected{
            self.totalPages = response?["total_pages"] as! Int
            self.totalResults = response?["total_results"] as! Int
            for item in response?["results"] as! [JSON]{
                media.append(createAndStoreFromResponse(item)!)
            }
        }
        else{
            media.append(contentsOf: createAndRestoreFromDB())
        }
            
        self.processMedia(type, media: media, connected: connected)
    }
    
    func createAndRestoreFromDB() -> Array<Any>{
        var media = Array<Any>()
        if areMovie{
            do {
                let results = realm?.objects(Movie.self)
                if results != nil && results!.count > 0{
                    for i in 0...results!.count - 1{
                        media.append(results![i])
                    }
                }
            }
        }
        else{
            do {
                let results = realm?.objects(Serie.self)
                if results != nil && results!.count > 0{
                    for i in 0...results!.count - 1{
                        media.append(results![i])
                    }
                }
            }
        }
        return media
    }

    
    func createAndStoreFromResponse(_ item: JSON) -> Any?{
        let data = AppDelegate.jsonToNSData(item as AnyObject)
        let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        if areMovie{
            do {
                let currentMedia = try decoder.decode(Movie.self, from: data!)
                try realm?.write {
                    realm?.add(currentMedia, update: .modified)
                }
                return currentMedia
            } catch {print (error) }
        }
        else{
            do {
                let currentMedia = try decoder.decode(Serie.self, from: data!)
                try realm?.write {
                    realm?.add(currentMedia, update: .modified)
                }
                return currentMedia
            } catch {print (error) }
        }
        return nil
    }
    
    func processMedia(_ type: String, media: Array<Any>, connected: Bool){
        self.cSearchList.removeAll(keepingCapacity: false)
        if self.searchTextField.text! != ""{
            
            if areMovie{
                self.cSearchList.append(contentsOf: (media as! Array<Movie>).filter({ ($0.title != nil && $0.title!.lowercased().contains(self.searchTextField.text!.lowercased()))}))
            }
            else{
                self.cSearchList.append(contentsOf: (media as! Array<Serie>).filter({ ($0.name != nil && $0.name!.lowercased().contains(self.searchTextField.text!.lowercased()))}))
            }
        }
        else{
            self.cSearchList.append(contentsOf: media)
        }
        if type == "Popular"{
            self.cSearchPopular.append(contentsOf: self.cSearchList)
        }
        else if type == "Top_Rated"{
            self.cSearchTopRated.append(contentsOf: self.cSearchList)
        }
        else if type == "Upcoming"{
            self.cSearchUpcoming.append(contentsOf: self.cSearchList)
        }
        processSearchList(type, connected: connected)
    }
    
    func processSearchList(_ type: String, connected: Bool){
        if cSearchTopRated.count == 0 && cSearchUpcoming.count == 0 && cSearchPopular.count == 0 && page == totalPages{
            self.lblNoData.isHidden = false
            self.btnMovies.isEnabled = true
            self.btnSeries.isEnabled = true
            self.searchTextField.isEnabled = true
            self.loading.stopAnimating()
            self.viewContainerCollections.isHidden = true
            self.loading.isHidden = true
        }
        else{
            self.btnMovies.isEnabled = true
            self.btnSeries.isEnabled = true
            self.searchTextField.isEnabled = true
            self.loading.stopAnimating()
            self.loading.isHidden = true
            self.viewContainerCollections.isHidden = false
            self.lblNoData.isHidden = true
        }
        if self.cSearchList.count != 0{
            if (type == "Popular" && self.cSearchPopular.count < totalResults / totalPages) || (type == "Top_Rated" && self.cSearchTopRated.count < totalResults / totalPages) || (type == "Upcoming" && self.cSearchUpcoming.count < totalResults / totalPages){
                if connected{
                    self.loadOthers(type)
                }
            }
            self.assignByType(type)
            if page == 1{
                let indexPath = IndexPath(row: 0, section: 0)
                if type == "Popular"{
                    self.cvPopular.scrollToItem(at: indexPath, at: .left, animated: true)
                }
                else if type == "Top_Rated"{
                    self.cvTopRated.scrollToItem(at: indexPath, at: .left, animated: true)
                }
                else if type == "Upcoming"{
                    self.cvUpcoming.scrollToItem(at: indexPath, at: .left, animated: true)
                }
            }
        }
        else{
            
            if page == self.totalPages {
                
            }
            else{
                if areMovie{
                    let blankList = Movie(-1)
                    self.cSearchList.append(blankList)
                }
                else{
                    let blankList = Serie(-1)
                    self.cSearchList.append(blankList)
                }
                if connected{
                    self.loadOthers(type)
                }
                self.assignByType(type)
            }
        }
    }
    
    func assignByType(_ type: String){
        if type == "Popular"{
            self.cvPopular.reloadData()
        }
        else if type == "Top_Rated"{
            self.cvTopRated.reloadData()
        }
        else if type == "Upcoming"{
            self.cvUpcoming.reloadData()
        }
    }
    
    @IBAction func editChange(_ sender: UITextField) {
        clearView()
        if searchTimer != nil {
            searchTimer?.invalidate()
            searchTimer = nil
        }
        self.searchTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { [weak self] _ in
            self?.searchTextField.isEnabled = false
            if self!.areMovie && self!.swUpcoming.isOn{
                self!.viewUpcomingContainer.isHidden = false
                self!.getMedia("Upcoming")
            }
            else if !self!.areMovie{
                self!.viewUpcomingContainer.isHidden = true
            }
            if self!.swPopular.isOn{
                self!.getMedia("Popular")
            }
            if self!.swToprated.isOn{
                self!.getMedia("Top_Rated")
            }
            
        }
        
    }
    
    // MARK: - Collection view data source
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == cvPopular{
            return self.cSearchPopular.count
        }
        else if collectionView == cvTopRated{
            return self.cSearchTopRated.count
        }
        else if collectionView == cvUpcoming{
            return self.cSearchUpcoming.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) ->
    UICollectionViewCell {
        let movieSerieCell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieSerieCell", for: indexPath ) as? MovieSerieCell
        if collectionView == cvPopular && self.cSearchPopular.count > 0{
            if areMovie{
                if (self.cSearchPopular[indexPath.item] as! Movie).poster_path != nil{
                    let urlImage = "https://image.tmdb.org/t/p/w185/" + (self.cSearchPopular[indexPath.item] as! Movie).poster_path!
                    movieSerieCell?.photo.setImageWith(URL(string: urlImage)!, placeholderImage: UIImage(named:"star"))
                }
                movieSerieCell?.name.text = (self.cSearchPopular[indexPath.item] as! Movie).title
            }
            else{
                if (self.cSearchPopular[indexPath.item] as! Serie).poster_path != nil{
                    let urlImage = "https://image.tmdb.org/t/p/w185/" + (self.cSearchPopular[indexPath.item] as! Serie).poster_path!
                    movieSerieCell?.photo.setImageWith(URL(string: urlImage)!, placeholderImage: UIImage(named:"star"))
                }
                movieSerieCell?.name.text = (self.cSearchPopular[indexPath.item] as! Serie).original_name
            }
        }
        if collectionView == cvTopRated && self.cSearchTopRated.count > 0{
            if areMovie{
                if (self.cSearchTopRated[indexPath.item] as! Movie).poster_path != nil{
                    let urlImage = "https://image.tmdb.org/t/p/w185/" + (self.cSearchTopRated[indexPath.item] as! Movie).poster_path!
                    movieSerieCell?.photo.setImageWith(URL(string: urlImage)!, placeholderImage: UIImage(named:"star"))
                }
                movieSerieCell?.name.text = (self.cSearchTopRated[indexPath.item] as! Movie).title
            }
            else{
                if (self.cSearchTopRated[indexPath.item] as! Serie).poster_path != nil{
                    let urlImage = "https://image.tmdb.org/t/p/w185/" + (self.cSearchTopRated[indexPath.item] as! Serie).poster_path!
                    movieSerieCell?.photo.setImageWith(URL(string: urlImage)!, placeholderImage: UIImage(named:"star"))
                }
                movieSerieCell?.name.text = (self.cSearchTopRated[indexPath.item] as! Serie).original_name
            }
        }
        if collectionView == cvUpcoming && self.cSearchUpcoming.count > 0{
            if areMovie {
                if (self.cSearchUpcoming[indexPath.item] as! Movie).poster_path != nil{
                    let urlImage = "https://image.tmdb.org/t/p/w185/" + (self.cSearchUpcoming[indexPath.item] as! Movie).poster_path!
                    movieSerieCell?.photo.setImageWith(URL(string: urlImage)!, placeholderImage: UIImage(named:"star"))
                }
                movieSerieCell?.name.text = (self.cSearchUpcoming[indexPath.item] as! Movie).title
            }
            else{
                if (self.cSearchUpcoming[indexPath.item] as! Serie).poster_path != nil{
                    let urlImage = "https://image.tmdb.org/t/p/w185/" + (self.cSearchUpcoming[indexPath.item] as! Serie).poster_path!
                    movieSerieCell?.photo.setImageWith(URL(string: urlImage)!, placeholderImage: UIImage(named:"star"))
                }
                movieSerieCell?.name.text = (self.cSearchUpcoming[indexPath.item] as! Serie).original_name
            }
        }
        return movieSerieCell!
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetX = scrollView.contentOffset.x
        let contentWidth = scrollView.contentSize.width
        if (offsetX == 0)
        {
            self.btnMovies.isEnabled = true
            self.btnSeries.isEnabled = true
        }
        else{
            self.btnMovies.isEnabled = false
            self.btnSeries.isEnabled = false
        }
        
        if offsetX > contentWidth - scrollView.frame.size.width{
            if scrollView.tag == 0{
                loadOthers("Popular")
            }
            else if scrollView.tag == 1{
                loadOthers("Top_Rated")
            }
            else if scrollView.tag == 2{
                loadOthers("Upcoming")
            }
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.btnMovies.isEnabled = true
        self.btnSeries.isEnabled = true
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == cvPopular{
            if areMovie && cSearchPopular.count > 0{
                let element = cSearchPopular[indexPath.row] as! Movie
                AppDelegate.goElementDetails(viewController: self, element: element, type: "Movie")
            }
            else if cSearchPopular.count > 0{
                let element = cSearchPopular[indexPath.row] as! Serie
                AppDelegate.goElementDetails(viewController: self, element: element, type: "Serie")
            }
        }
        if collectionView == cvTopRated{
            if areMovie && cSearchTopRated.count > 0{
                let element = cSearchTopRated[indexPath.row] as! Movie
                AppDelegate.goElementDetails(viewController: self, element: element, type: "Movie")
            }
            else if cSearchTopRated.count > 0{
                let element = cSearchTopRated[indexPath.row] as! Serie
                AppDelegate.goElementDetails(viewController: self, element: element, type: "Serie")
            }
        }
        if collectionView == cvUpcoming{
            
            if areMovie && cSearchUpcoming.count > 0{
                let element = cSearchUpcoming[indexPath.row] as! Movie
                AppDelegate.goElementDetails(viewController: self, element: element, type: "Movie")
            }
            else if cSearchUpcoming.count > 0{
                let element = cSearchUpcoming[indexPath.row] as! Serie
                AppDelegate.goElementDetails(viewController: self, element: element, type: "Serie")
            }
        }
    }
    
    func loadOthers(_ type: String){
        if page < totalPages{
            self.page = self.page + 1
            self.getMedia(type)
        }
        else{
            spinnerFooter.stopAnimating()
        }
    }
    
    func createTableViewFooter(_ tableView: UITableView){
        spinnerFooter.startAnimating()
        spinnerFooter.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
        tableView.tableFooterView? = spinnerFooter
        tableView.tableFooterView?.isHidden = false
    }
    
}
