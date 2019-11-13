//
//  ViewController.swift
//  DemoApp
//
//  Created by Ashmika Gujarathi on 12/11/19.
//  Copyright © 2019 Ashmika. All rights reserved.
//

import UIKit
import AlamofireSwiftyJSON
import Alamofire

class ViewController: UIViewController , UITableViewDataSource, UITableViewDelegate {
    
    
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var globalArray = Array<AnyObject>()
    
    @IBOutlet weak var posttableView: UITableView!
    
    var currentPage: Int = 1
    
    

    override func viewDidLoad()
    
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
       //// self.navigationController?.navigationBar.barTintColor = .purple
        
        getPost(pageNumber: 1)
        
    }
    
    
    func getPost(pageNumber : Int)
        
    {
        
        self.activityIndicator.startAnimating()
        
        let url = String(format: "https://hn.algolia.com/api/v1/search_by_date?tags=story&page=%@",String(pageNumber))
        print(url)
        Alamofire.request(url).responseJSON { (response) in
            
            
            
            
            if let json = response.result.value
            {
                
                let Dict = json as! Dictionary<String,AnyObject>
                let newArray = Dict["hits"] as! Array<AnyObject>
               
                
                for (index, element) in newArray.enumerated()
               {

                let newElement =  newArray[index] as! Dictionary<String,AnyObject>
              

                self.globalArray.append(newElement as AnyObject)
                

                self.navigationItem.title = String(self.globalArray.count)
                
                }
                
                self.activityIndicator.stopAnimating()
                self.posttableView.reloadData()
            }
        }
    }


    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
    
        return globalArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PostCell
        
        if globalArray.count > 0
        {
          
           
           
            let rowArray = globalArray[indexPath.row] as! [String : AnyObject]
            cell.lblPostTitle.text =  rowArray["title"] as! String
            cell.lblCreatedAt.text = rowArray["created_at"] as! String
            cell.lblAuthor.text = rowArray["author"] as! String
            
            
        }
        
       
        
        return cell
        
    }
    
   
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let lastSection = tableView.numberOfSections - 1
        let lastIndex = tableView.numberOfRows(inSection: lastSection) - 1
        if ((indexPath.section == lastSection) && (indexPath.row == lastIndex)) {
            // This is the last cell
            
        
        if  (lastIndex > 1)
        {
            if currentPage < 50
                
            {
                currentPage += 1;
                
             
                
                getPost(pageNumber: currentPage)
                
            }
        }
           

        }
        
    }
    
    
}

