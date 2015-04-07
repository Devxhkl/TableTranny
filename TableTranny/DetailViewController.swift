//
//  DetailViewController.swift
//  TableTranny
//
//  Created by Zel Marko on 02/04/15.
//  Copyright (c) 2015 Zel Marko. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var continentTable: UITableView!
    @IBOutlet weak var continentLabel: UILabel!
    
    var continent: (String, [String])!

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        continentTable.contentInset = UIEdgeInsets(top: 70, left: 0, bottom: 0, right: 0)
        continentLabel.text = continent.0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return continent.1.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CoutryCell") as UITableViewCell
        
        cell.textLabel?.text = continent.1[indexPath.row]
        
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
