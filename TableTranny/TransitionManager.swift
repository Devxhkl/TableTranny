//
//  TransitionManager.swift
//  TableTranny
//
//  Created by Zel Marko on 06/04/15.
//  Copyright (c) 2015 Zel Marko. All rights reserved.
//

import UIKit

class TransitionManager: NSObject, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate {
   
    let duration = 0.8
    var presenting = false
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let container = transitionContext.containerView()
        
        let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey)!
        let toView = transitionContext.viewForKey(UITransitionContextToViewKey)!
        fromView.backgroundColor = presenting ? UIColor.whiteColor() : UIColor.clearColor()
        toView.backgroundColor = presenting ? UIColor.clearColor() : UIColor.whiteColor()
        
        let earth = presenting ? transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as ViewController : transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as ViewController
        let continent = presenting ? transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as DetailViewController : transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as DetailViewController
        
        let earthTable = earth.earthTable!
        let earthLabel = earth.earthLabel!
        earthLabel.transform = presenting ? CGAffineTransformIdentity : CGAffineTransformMakeScale(0.01, 0.01)
        let selectedCell = earth.selectedCell!
        
        let rect = earth.view.convertRect(selectedCell.continentNameLabel.frame, fromView: selectedCell)
        let continentSelectedLabel = UILabel(frame: rect)
        continentSelectedLabel.center = presenting ? continentSelectedLabel.center : earthLabel.center
        continentSelectedLabel.text = selectedCell.continentNameLabel.text
        
        let continentTable = continent.continentTable!
        let continentLabel = continent.continentLabel!
        
        let spotlightTable = presenting ? earthTable : continentTable
        spotlightTable.reloadData()
        let backstageTable = presenting ? continentTable : earthTable
        backstageTable.reloadData()
        backstageTable.hidden = true
        
        container.addSubview(fromView)
        container.addSubview(toView)
        container.bringSubviewToFront(presenting ? toView : fromView)
        container.insertSubview(continentSelectedLabel, aboveSubview: presenting ? toView : fromView)
        
        
        UIView.animateWithDuration(duration, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 3, options: nil, animations: {
            
           // UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 2, options: nil, animations: {
            if !self.presenting {
               // spotlightTable.transform = CGAffineTransformMakeTranslation(0, -spotlightTable.bounds.height)
            }
            
            
            var index = 0
            for c in spotlightTable.visibleCells() {
                let cell = c as UITableViewCell
                

                UIView.animateWithDuration(self.duration, delay: 0.05 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 2, options: nil, animations: {
                    
                    cell.transform = CGAffineTransformMakeTranslation(0, spotlightTable.bounds.height)
                    
                    }, completion: nil)
                        index++
                println("SCELL: \(cell.frame)")
            }
            println("SPOT: \(spotlightTable.frame)")
            
            
            
           // }, completion: nil)
            
            if self.presenting {
                continentLabel.hidden = true
                continentSelectedLabel.transform = CGAffineTransformMakeTranslation(fromView.bounds.width / 2 - continentSelectedLabel.center.x, 0)
            }
            
            continentSelectedLabel.font = UIFont(name: earthLabel.font.fontName, size: 25)
            continentSelectedLabel.sizeToFit()
            
            if !self.presenting {
                continentSelectedLabel.transform = CGAffineTransformMakeScale(0.01, 0.01)
                //continentSelectedLabel.center = CGPoint(x: fromView.center.x, y: fromView.center.y / 2)
                continentSelectedLabel.alpha = 0
                earthLabel.transform = CGAffineTransformMakeScale(1, 1)
            }
            
            }, completion: { _ in
                transitionContext.completeTransition(true)
                
                for cell in spotlightTable.visibleCells() {
                    let x = cell as UITableViewCell
                    x.transform = CGAffineTransformIdentity
                }
                continentLabel.hidden = false
                continentLabel.text = "Earth"
                
                backstageTable.hidden = true
                //backstageTable.transform = CGAffineTransformMakeTranslation(0, backstageTable.bounds.height)
                println(backstageTable.frame)
                
                var index = 0
                for c in backstageTable.visibleCells() {
                    let cell = c as UITableViewCell
                    backstageTable.hidden = false
                    cell.transform = CGAffineTransformIdentity
                    println("BACK: \(cell.frame)")
                    cell.transform = CGAffineTransformMakeTranslation(0, backstageTable.bounds.height)
                    
                    
                    UIView.animateWithDuration(self.duration, delay: 0.05 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 2, options: nil, animations: {
                        
                        cell.transform = CGAffineTransformIdentity
                        
                        }, completion: nil)
                    index++
                    
                }
                
                backstageTable.hidden = false
                toView.backgroundColor = UIColor.whiteColor()
                spotlightTable.transform = CGAffineTransformIdentity
                
                UIView.animateWithDuration(self.duration, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 2, options: nil, animations: {
                    
                    continentLabel.transform = CGAffineTransformMakeScale(0.01, 0.01)
                    continentLabel.alpha = 0
                    continentSelectedLabel.transform = self.presenting ? CGAffineTransformMakeTranslation(continentSelectedLabel.frame.origin.x - 6.5, -(continentSelectedLabel.center.y - continentLabel.center.y)) : CGAffineTransformIdentity
                    backstageTable.transform = CGAffineTransformIdentity
                    for c in backstageTable.visibleCells() {
                        println(c.frame)
                    }
                }, completion: nil)
                
        })
        
    }
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        return duration
    }
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.presenting = true
        
        return self
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.presenting = false
        
        return self
    }
}
