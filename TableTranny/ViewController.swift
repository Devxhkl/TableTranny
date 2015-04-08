//
//  ViewController.swift
//  TableTranny
//
//  Created by Zel Marko on 02/04/15.
//  Copyright (c) 2015 Zel Marko. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, EarthSectionDelegate {
    
    @IBOutlet weak var earthTable: UITableView!
    @IBOutlet weak var earthLabel: UILabel!
    
    let world: [(String, [String])] = [("North America", ["Canada", "United States"]), ("Africa", ["Nigeria", "Democratic Republic of the Congo", "South Africa", "Mali", "Libya"]), ("Europe", ["Austria", "Croatia", "Belgium", "Spain", "Slovenia", "Germany", "Island", "United Kingdom"]), ("Asia", ["Japan", "North Korea", "China", "Thailand", "Myanmar (Burma)"])]
    
    var selectedCell: EarthTableCell?
    let transitionManager = TransitionManager()
    var sectionInfoArray = [SectionInfo]()

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        earthTable.contentInset = UIEdgeInsets(top: 70, left: 0, bottom: 0, right: 0)
        
        if sectionInfoArray.count == 0 || sectionInfoArray.count != self.numberOfSectionsInTableView(earthTable) {
            for continent in world {
                let sectionInfo = SectionInfo()
                sectionInfo.continent = continent
                sectionInfo.isOpen = false
                sectionInfoArray.append(sectionInfo)
            }
        }
    }
    
    // MARK: - EarthTable
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return sectionInfoArray.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionInfo = sectionInfoArray[section]
        
        return sectionInfo.isOpen ? 1 : 0
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableCellWithIdentifier("EarthHeader") as EarthTableHeader
        header.sectionDelegate = self
        header.frame = CGRect(x: header.frame.origin.x, y: header.frame.origin.y, width: earthTable.bounds.width, height: header.bounds.height)
        
        let sectionInfo = sectionInfoArray[section]
        sectionInfo.headerView = header
        
        header.continentInfoLabel.text = sectionInfo.continent.0
        header.section = section
        
        let view = UIView(frame: header.frame)
        view.addSubview(header)
        
        return view
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ContinentCell") as EarthTableCell
        
        let sectionInfo = sectionInfoArray[indexPath.section]
        
        cell.continentNameLabel.text = "Countries: \(sectionInfo.continent.1.count)"
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44
    }
    
    func openSection(sectionHeaderCell: EarthTableHeader, section: Int) {
        let sectionInfo = sectionInfoArray[section]
        sectionInfo.isOpen = true
        
        var indexPathsToInsert = [NSIndexPath]()
        let indexPath = NSIndexPath(forRow: 0, inSection: section)
        indexPathsToInsert.append(indexPath)
        
        earthTable.insertRowsAtIndexPaths(indexPathsToInsert, withRowAnimation: .Top)
    }
    
    func closeSection(sectionHeaderCell: EarthTableHeader, section: Int) {
        let sectionInfo = sectionInfoArray[section]
        sectionInfo.isOpen = false
        
        var indexPathsToRemove = [NSIndexPath]()
        let indexPath = NSIndexPath(forRow: 0, inSection: section)
        indexPathsToRemove.append(indexPath)
        
        earthTable.deleteRowsAtIndexPaths(indexPathsToRemove, withRowAnimation: .Top)
    }

    // MARK: - ViewController
    
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

