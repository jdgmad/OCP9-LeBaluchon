//
//  ViewController.swift
//  LeBaluchon
//
//  Created by José DEGUIGNE on 18/11/2021.
//

import UIKit

extension UIViewController {
    // These generic functions are used in all our ViewControllers
    func presentAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    // Toggle the display between the UI button and the activityindicator
    func toggleActivityIndicator(visible: Bool, activityIndicator: UIActivityIndicatorView, button: UIButton) {
        activityIndicator.isHidden = !visible
        button.isHidden = visible
    }
}
