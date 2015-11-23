//
//  InstagramViewController.swift
//  instagram
//
//  Created by Stacey Gennoy on 11/22/15.
//  Copyright © 2015 Stacey Gennoy. All rights reserved.
//

import UIKit
import AFNetworking

class InstagramViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {

    @IBOutlet weak var tableView: UITableView!
    
    var photos: [NSDictionary]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photos = []
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // Do any additional setup after loading the view.
        
        let url = NSURL(string: "")!
        
        let request = NSURLRequest(URL: url)
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (respons: NSURLResponse?, data: NSData?, error: NSError?) -> Void in
            
            let dictionary = try! NSJSONSerialization.JSONObjectWithData(data!, options:[])
            
            //reach into the file cabinet and find the tab movies
            self.photos = dictionary["data"] as! [NSDictionary]
            
            // hey tableview, ask me that question again, about how many rows
            self.tableView.reloadData()

        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return photos.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("PhotoCell") as! PhotoCell
        
        let photo = photos[indexPath.row]
        
        let urlString = photo.valueForKeyPath("images.low_resolution.url") as! String
        
        cell.photoImageView.setImageWithURL(NSURL(string: urlString)!)
        
        print (urlString)
        
        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
