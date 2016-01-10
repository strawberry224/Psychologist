//
//  DiagnosedHappinessViewController.swift
//  Psychologist
//
//  Created by Shen Lijia on 16/1/10.
//  Copyright © 2016年 ShenLijia. All rights reserved.
//

import UIKit

class DiagnosedHappinessViewController: HappinessUIViewController, UIPopoverPresentationControllerDelegate {
    
    override var happiness: Int {
        didSet {
            diagnosticHistory += [happiness]        }
    }
    
    private let defaults = NSUserDefaults.standardUserDefaults()
    
    var diagnosticHistory: [Int] {
        get { return defaults.objectForKey(History.DefaultsKey) as? [Int] ?? [] }
        set { defaults.setObject(newValue, forKey: History.DefaultsKey) }
    }
    
    private struct History {
        static let SegueIndentifier = "Show Diagnostic History"
        static let DefaultsKey = "DiagnosedHappinessViewController.History"
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            switch identifier {
            case History.SegueIndentifier:
                if let tvc = segue.destinationViewController as? TextViewController {
                    if let ppc = tvc.popoverPresentationController {
                        ppc.delegate = self
                    }
                    tvc.text = "\(diagnosticHistory)"
                }
            default: break
            }
        }
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.None
    }
}
