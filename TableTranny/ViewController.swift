//
//  ViewController.swift
//  TableTranny
//
//  Created by Zel Marko on 02/04/15.
//  Copyright (c) 2015 Zel Marko. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var earthTable: UITableView!
    @IBOutlet weak var earthLabel: UILabel!
    
    let world: [(String, [String])] = [("North America", ["Canada", "United States"]), ("Africa", ["Nigeria", "Democratic Republic of the Congo", "South Africa", "Mali", "Libya"]), ("Europe", ["Austria", "Croatia", "Belgium", "Spain", "Slovenia", "Germany", "Island", "United Kingdom"]), ("Asia", ["Japan", "North Korea", "China", "Thailand", "Myanmar (Burma)"])]
    
    var selectedCell: EarthTableCell?
    let transitionManager = TransitionManager()

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        earthTable.contentInset = UIEdgeInsets(top: 70, left: 0, bottom: 0, right: 0)
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return world.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ContinentCell") as EarthTableCell
        
        cell.continentNameLabel.text = world[indexPath.row].0
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let detail = segue.destinationViewController as DetailViewController
        
        if let cell = sender as? EarthTableCell {
            selectedCell = cell
            let index = earthTable.indexPathForCell(cell)
            detail.continent = world[index!.row]
            earthTable.deselectRowAtIndexPath(index!, animated: true)
        }
        detail.transitioningDelegate = transitionManager
                
    }
    
    @IBAction func unwindFromDetail(segue: UIStoryboardSegue) {
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

