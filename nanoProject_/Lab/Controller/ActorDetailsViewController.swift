//
//  ActorDetailsViewController.swift
//  Lab
//
//  Created by Roberto Evangelista da Silva Filho on 14/12/2018.
//  Copyright © 2018 Roberto Evangelista da Silva Filho. All rights reserved.
//

import UIKit

class ActorDetailsViewController: UIViewController {
    
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var birthdayLabel: UILabel!
    @IBOutlet weak var birthplaceLabel: UILabel!
    @IBOutlet weak var biographyLabel: UITextView!
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var relatedMovies: UILabel!
    
    let networkHelper = NetworkHelper()

    let movieCellIdentifier: String = "movieCell"
    
    var imgBuilder = ImageBuilder()
    
    func changeLabelAndHideTableViewShouldActorHasNoMovies() {
        if searchMovies == nil || searchMovies!.isEmpty {
            relatedMovies.text = "Couldn't find any movies :("
            myTableView.isHidden = true
        } else {
            relatedMovies.text = "related movies".uppercased()
            myTableView.isHidden = false
        }
    }
    
    var selectedActor: Actor?
    var fullActor: Actor? {
        didSet {
            nameLabel.text = fullActor?.name
            birthdayLabel.text = "\(fullActor?.birthday ?? "Oops... birthday not found.")"
            birthplaceLabel.text = "\(fullActor?.birthplace ?? "Couldn't find birthplace :/")"
            
            if fullActor?.biography != nil {
                biographyLabel.text = fullActor?.biography
            } else {
                biographyLabel.text = "Who's this again?"
            }
            
            if imgBuilder.isImagePathValid(for: fullActor?.picture) {
                imgBuilder.getImage(imgBuilder.path) { (imageData, error) -> (Void) in
                    self.profilePicture.image = UIImage(data: imageData!)
                }
            } else {
                self.profilePicture.image = UIImage(named: self.imgBuilder.noImageAvailable)
            }
        }
    }
    
    var searchMovies: [Movie]? {
        didSet {
            self.myTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.dataSource = self
        myTableView.delegate = self
        searchActorDetailsRequest()
        searchMoviesRequest()
    }
    
    func searchActorDetailsRequest() {
        guard let actor = selectedActor else {
            print("Não recebi nenhum ator dessa segue")
            return
        }
        let searchRequest = "/person/\(actor.id)"
        let myQueryItems = [
            "api_key": networkHelper.apiKey
        ]
        var urlComponents = URLComponents(string: networkHelper.apiURL + searchRequest)
        urlComponents?.queryItems = networkHelper.queryItems(dictionary: myQueryItems)
        
        let task = URLSession.shared.dataTask(with: urlComponents!.url!) { (data, response, error) in
            guard let dataResponse = data, error == nil else {
                print(error!.localizedDescription)
                return
            }
            do {
                let decode = try JSONDecoder().decode(Actor.self, from: dataResponse)
                DispatchQueue.main.async {
                    self.fullActor = decode
                }
            } catch let parsinError{
                print(parsinError.localizedDescription)
            }
        }
        task.resume()
    }
    
    func searchMoviesRequest() {
        guard let actor = selectedActor else {
            print("Não recebi nenhum ator dessa segue")
            return
        }
        let searchRequest = "/person/\(actor.id)/movie_credits"
        let myQueryItems = [
            "api_key": networkHelper.apiKey
        ]
        var urlComponents = URLComponents(string: networkHelper.apiURL + searchRequest)
        urlComponents?.queryItems = networkHelper.queryItems(dictionary: myQueryItems)
        
        let task = URLSession.shared.dataTask(with: urlComponents!.url!) { (data, response, error) in
            guard let dataResponse = data, error == nil else {
                print(error!.localizedDescription)
                return
            }
            do {
                let decode = try JSONDecoder().decode(MovieSearchResponse.self, from: dataResponse)
                DispatchQueue.main.async {
                    self.searchMovies = decode.cast
                    self.changeLabelAndHideTableViewShouldActorHasNoMovies()
                }
            } catch let parsinError{
                print(parsinError.localizedDescription)
            }
        }
        task.resume()
    }
}

extension ActorDetailsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchMovies?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: movieCellIdentifier, for: indexPath) as! MovieTableViewCell
        
        resetCellProperties(for: cell)
        
        if let movies = searchMovies {
            cell.name.text = movies[indexPath.row].title
            if movies[indexPath.row].releaseDate == "" || movies[indexPath.row].releaseDate == nil {
                 cell.releaseDate.text = "Release date: Not available"
            } else {
                cell.releaseDate.text = "Release date: \(movies[indexPath.row].releaseDate!)"
            }
            
            if imgBuilder.isImagePathValid(for: movies[indexPath.row].poster) {
                imgBuilder.getImage(imgBuilder.path) { (imageData, error) -> (Void) in
                    cell.poster.image = UIImage(data: imageData!)
                }
            } else {
                cell.poster.image = UIImage(named: imgBuilder.noMovieAvailable)
            }
        }
        
        return cell
    }
    
    func resetCellProperties(for cell: MovieTableViewCell) {
        cell.genres.text = nil
        cell.poster.image = nil
        cell.name.text = nil
        cell.duration.text = nil
        cell.releaseDate.text = nil
    }
}
