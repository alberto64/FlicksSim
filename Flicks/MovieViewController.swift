//
//  MovieViewController.swift
//  Flicks
//
//  Created by Karla on 1/23/16.
//  Copyright © 2016 Alberto J. De Jesus. All rights reserved.
//


import UIKit
import AFNetworking
import MBProgressHUD

class MovieViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var TableView: UITableView!
    var movies: [NSDictionary]?
    var endPoint: String!
    var selectionStyle: UITableViewCellSelectionStyle!
    var selectedBackgroundView: UIView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
            // Initialize a UIRefreshControl
            let refreshControl = UIRefreshControl()
        
        // Initialize a UIRefreshControl
        refreshControl.addTarget(self, action: "refreshControlAction:", forControlEvents: UIControlEvents.ValueChanged)
        TableView.insertSubview(refreshControl, atIndex: 0)
        
        TableView.dataSource = self
        TableView.delegate = self

        // Do any additional setup after loading the view.
        
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        let url = NSURL(string: "https://api.themoviedb.org/3/movie/\(endPoint)?api_key=\(apiKey)")
        let request = NSURLRequest(URL: url!)
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate: nil,
            delegateQueue: NSOperationQueue.mainQueue()
        )
        
        let task: NSURLSessionDataTask = session.dataTaskWithRequest(request,
            completionHandler: { (dataOrNil, response, error) in
                if let data = dataOrNil {
                    if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(
                        data, options:[]) as? NSDictionary {
                            NSLog("response: \(responseDictionary)")
                            
                            self.movies = responseDictionary["results"] as! [NSDictionary]
                            self.loadDataFromNetwork()
                        
                            // Reload the tableView now that there is new data
                            self.TableView.reloadData()
                        
                            
                            
                    }
                }
        })
        task.resume()
        
    }
    func refreshControlAction(refreshControl: UIRefreshControl) {
        
        // ... Create the NSURLRequest (myRequest) ...
        
        // Configure session so that completion handler is executed on main UI thread
        
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        let url = NSURL(string: "https://api.themoviedb.org/3/movie/\(endPoint)?api_key=\(apiKey)")
        let request = NSURLRequest(URL: url!)

        
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate:nil,
            delegateQueue:NSOperationQueue.mainQueue()
        )
        
        let task : NSURLSessionDataTask = session.dataTaskWithRequest(request,
            completionHandler: { (data, response, error) in
                
                // ... Use the new data to update the data source ...
                
                // Reload the tableView now that there is new data
                self.TableView.reloadData()
              
                
                // Tell the refreshControl to stop spinning
                refreshControl.endRefreshing()	
        });
        task.resume()
    }
    
    func loadDataFromNetwork() {
        
        // ... Create the NSURLRequest (myRequest) ...
        
        
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        let url = NSURL(string: "https://api.themoviedb.org/3/movie/\(endPoint)?api_key=\(apiKey)")
        let request = NSURLRequest(
            URL: url!,
            cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData,
            timeoutInterval: 10)
        
            
            // ... Create the NSURLRequest (myRequest) ...
            
            // Configure session so that completion handler is executed on main UI thread
            let session = NSURLSession(
                configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
                delegate:nil,
                delegateQueue:NSOperationQueue.mainQueue()
            )
            
            // Display HUD right before the request is made
            MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            
            let task : NSURLSessionDataTask = session.dataTaskWithRequest(request,
                completionHandler: { (data, response, error) in
                    
                    // Hide HUD once the network request comes back (must be done on main UI thread)
                    MBProgressHUD.hideHUDForView(self.view, animated: true)
                
                    // ... Remainder of response handling code ...
                    
            });
            task.resume()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let movies = movies{
            return movies.count
        }
        else{
            return 0
        }
    }
    

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("MovieCell", forIndexPath: indexPath) as! TableViewCell
        
        
        let movie = movies![indexPath.row]
        let title = movie["title"] as! String
        let overView = movie["overview"] as! String
        let posterpath = movie["poster_path"] as! String
        
        let baseUrl = "http://image.tmdb.org/t/p/w500"
        let image = NSURL(string: baseUrl + posterpath)
        cell.TitleLabel.text = title
        cell.OverLabel.text = overView
        cell.PosterView.setImageWithURL(image!)
        
        
        
        print("\(indexPath)")
        return cell
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let cell = sender as! UITableViewCell
        let indexPath = TableView.indexPathForCell(cell)
        let movie = movies![indexPath!.row]
        
        let detailViewController = segue.destinationViewController as! DetailViewController
        detailViewController.movie = movie
       
        
        let backgroundView = UIView()
        cell.selectionStyle = .None
        backgroundView.backgroundColor = UIColor.redColor()
        cell.selectedBackgroundView = backgroundView
        
        
        
        
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }


}
