//
//  MovieTrailerController.swift
//  Flix
//
//  Created by Lucy Tran on 11/27/21.
//

import UIKit
import WebKit

class MovieTrailerController: UIViewController{

    @IBOutlet weak var webView: WKWebView!
    
    var movieId: Int!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let id = movieId {
            let url = URL(string:
                            "https://api.themoviedb.org/3/movie/\(String(describing: id))/videos?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        
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
                    // Get the array of videos
                        let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                     
                    // Get the videos related to the movie
                        let videos = dataDictionary["results"] as! [[String: Any]]
                     
                    // Get the movie trailer. If there is no trailer, default to the last Youtube video, assuming that there is one.
                     var trailerID: String!
                     for video in videos {
                         print(video)
                         let site = video["site"] as! String
                         if (site == "YouTube") {
                             trailerID = (video["key"] as! String)
                             let type = video["type"] as! String
                             if (type == "Trailer") {
                                 print("Yes!!!")
                                 break
                             }
                         }
                     }
                     
                     print(trailerID)
                     
                     if let trailerID = trailerID {
                         let trailerUrl = URL(string: "https://www.youtube.com/watch?v=\(String(describing: trailerID))")!
//                         let trailerUrl = URL(string:"https://www.youtube.com/watch?v=cttnRmcr_ME")!
                         
                         print(trailerUrl)
                         let trailerRequest = URLRequest(url: trailerUrl, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
                         
                         self.webView.load(trailerRequest)
                     }
                 }
            }
            task.resume()
            

        }
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
