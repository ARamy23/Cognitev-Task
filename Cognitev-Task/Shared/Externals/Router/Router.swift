//
//  Router.swift
//  Cognitev-Task
//
//  Created by Ahmed Ramy on 11/27/19.
//  Copyright © 2019 Ahmed Ramy. All rights reserved.
//

import UIKit
import SwiftMessages
import PKHUD

class Router: RouterProtocol {
    
    var presentedView: UIViewController!
    
    func present(view: UIViewController) {
        presentedView.present(view, animated: true, completion: nil)
    }
    
    func push(view: UIViewController) {
        presentedView.navigationController?.pushViewController(view, animated: true)
    }
    
    func startActivityIndicator() {
        HUD.show(.systemActivity)
    }
    
    func stopActivityIndicator() {
        HUD.hide(animated: true)
    }
    
    func dismiss() {
        presentedView.dismiss(animated: true, completion: nil)
    }
    
    func pop() {
        _ = presentedView.navigationController?.popViewController(animated: true)
    }
    
    func segue(storyboard: AppStoryboard, vc: UIViewController.Type) {
        presentedView
            .navigationController?
            .pushViewController(storyboard.viewController(viewControllerClass: vc), animated: true)
    }
    
    func alert(title: String, message: String, actions: [(title: String, style: UIAlertAction.Style)]) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        actions.map({UIAlertAction(title: $0.title, style: $0.style, handler: nil)}).forEach({alert.addAction($0)})
        presentedView.present(alert, animated: true)
    }
    
    func alertWithAction(title: String, message: String, actions: [(title: String, style: UIAlertAction.Style, action: () -> Void)]) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        actions.map { action in
                UIAlertAction(title: action.title, style: action.style, handler: { (_) in
                    action.action()
                })
            }.forEach {
                alert.addAction($0)
            }
        presentedView.present(alert, animated: true)
    }
    
    func toast(title: String, message: String) {
        let view = MessageView.viewFromNib(layout: .messageView)
        view.configureTheme(.error)
        view.configureContent(title: title, body: message)
        view.configureDropShadow()
        view.button?.isHidden = true
        
        var config = SwiftMessages.Config()
        config.presentationStyle = .top
        config.presentationContext = .window(windowLevel: .statusBar)
        config.duration = .seconds(seconds: 3)
        config.interactiveHide = true
        
        
        SwiftMessages.show(config: config, view: view)
    }
}

