//
//  UIStoryBoard.swift
//  IOSCodeSample
//
//  Created by Dhaval Soni on 20/06/22.
//  Copyright © 2022 Solution Analysts Pvt. Ltd. All rights reserved.
//

import Foundation
import UIKit

extension UIStoryboard {
    /// The uniform place where we state all the storyboard we have in our application

    // MARK: - Convenience Initializers

    convenience init(storyboard: Storyboard) {
        self.init(name: storyboard.filename, bundle: nil)
    }

    // MARK: - Class Functions

    class func storyboard(_ storyboard: Storyboard) -> UIStoryboard {
        return UIStoryboard(name: storyboard.filename, bundle: nil)
    }

    // MARK: - View Controller Instantiation from Generics

    func instantiate<T: UIViewController>() -> T {
        if #available(iOS 13.0, *) {
            guard let viewController = self.instantiateViewController(identifier: T.storyboardIdentifier) as? T else {
                fatalError("Couldn't instantiate view controller with identifier \(T.storyboardIdentifier) ")
            }

            return viewController
        } else {
            guard let viewController = self.instantiateViewController(withIdentifier: T.storyboardIdentifier) as? T else {
                fatalError("Couldn't instantiate view controller with identifier \(T.storyboardIdentifier) ")
            }

            return viewController
        }
    }
}

protocol StoryboardIdentifiable {
    static var storyboardIdentifier: String { get }
}

extension StoryboardIdentifiable where Self: UIViewController {
    static var storyboardIdentifier: String {
        return String(describing: self)
    }
}

extension UIViewController: StoryboardIdentifiable { }
