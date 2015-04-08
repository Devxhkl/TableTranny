//
//  EarthTableHeader.swift
//  TableTranny
//
//  Created by Zel Marko on 07/04/15.
//  Copyright (c) 2015 Zel Marko. All rights reserved.
//

import UIKit

protocol EarthSectionDelegate {
    func openSection(sectionHeaderCell: EarthTableHeader, section: Int)
    func closeSection(sectionHeaderCell: EarthTableHeader, section: Int)
}

class EarthTableHeader: UITableViewCell, UIGestureRecognizerDelegate {

    @IBOutlet weak var continentInfoLabel: UILabel!
    
    var isOpen = false
    var sectionDelegate: EarthSectionDelegate?
    var section: Int!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let openCloseGesture = UITapGestureRecognizer(target: self, action: ("openCloseSection"))
        openCloseGesture.delegate = self
        
        self.addGestureRecognizer(openCloseGesture)
    }
    
    func openCloseSection() {
        if isOpen {
            isOpen = !isOpen
            sectionDelegate?.closeSection(self, section: section)
            
        }
        else {
            isOpen = !isOpen
            sectionDelegate?.openSection(self, section: section)
            
        }
    }
}
