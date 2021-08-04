//
//  Utils.swift
//  
//
//  Created by Alex Rodriguez on 02/08/21.
//

import Foundation
import UIKit

extension UIViewController {
    
    // Not using static as it wont be possible to override to provide custom storyboardID then
    class var storyboardID : String {
        return "\(self)"
    }
    
    static func instantiate(fromAppStoryboard appStoryboard: AppStoryboards) -> Self {
        return appStoryboard.viewController(self)
    }
}

enum AppStoryboards : String {
    
    case Access, Category, EpisodeDetails, MovieDetails, WKWebView
    
    
    weak var instance : UIStoryboard? {
        
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
    
    func viewController<T : UIViewController>(_ viewControllerClass : T.Type) -> T {
        let storyboardID = (viewControllerClass as UIViewController.Type).storyboardID
        guard let scene = instance?.instantiateViewController(withIdentifier: storyboardID) as? T else {
            fatalError("ViewController with identifier \(storyboardID), not found in \(self.rawValue) Storyboard")
        }
        return scene
    }
    
    func initialViewController() -> UIViewController? {
        
        return instance?.instantiateInitialViewController()
    }
}
