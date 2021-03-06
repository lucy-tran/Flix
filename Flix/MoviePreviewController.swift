//
//  MoviePreviewController.swift
//  Flix
//
//  Created by Lucy Tran on 11/27/21.
//

import UIKit

class MoviePreviewController: UIViewController {
    var movieId: Int!

    override func viewDidLoad() {
        super.viewDidLoad()

        let url = URL(string:
            "https://api.themoviedb.org/3/movie/\(movieId)/videos?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        
        //url request
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        
        //header
        //body
        
        //Session
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        
        //Data task
        //send task
        let task = session.dataTask(with: request) { (data, response, error) in
             // This will run when the network request returns
             if let error = error {
                    print(error.localizedDescription)
             } else if let data = data {
                    // TODO: Get the array of movies
                    let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                 
                    // TODO: Store the movies in a property to use elsewhere
                    //self.movies = dataDictionary["results"] as! [[String: Any]]
                 
                 // TODO: Reload your grid view data
                   // self.collectionView.reloadData()
                 
             }
        }
        task.resume()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
