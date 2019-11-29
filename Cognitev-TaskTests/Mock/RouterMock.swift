//
//  RouterMock.swift
//  Cognitev-TaskTests
//
//  Created by Ahmed Ramy on 11/29/19.
//  Copyright © 2019 Ahmed Ramy. All rights reserved.
//

import Foundation
import UIKit

@testable import Cognitev_Task

enum RoutingAction: Equatable {
    case present(_ vc: UIViewController)
    case push(_ vc: UIViewController)
    case activityStart
    case activityStop
    case dismiss
    case pop
    case segue(_ storyboard: AppStoryboard, _ vc: UIViewController.Type)
    case alert(_ message: String)
    case toast(_ message: String)
    case alertWithAction((title: String, message: String))
    
    static public func ==(lhs: RoutingAction, rhs: RoutingAction) -> Bool {
        switch (lhs, rhs) {
        case let (.push(a), .push(b)): return "\(type(of: a))" == "\(type(of: b))"
        case let (.present(a), .present(b)): return "\(type(of: a))" == "\(type(of: b))"
        case let (.alert(a), .alert(b)): return a == b
        case let (.toast(a), .toast(b)): return a == b
        case let (.segue(a, b), .segue(c, d)): return a == c && b == d
        case let (.alertWithAction(a), .alertWithAction(b)):
            return a.title == b.title && a.message == b.message
        case (.activityStart, .activityStart),
             (.activityStop, .activityStop),
             (.dismiss, .dismiss),
             (.pop, .pop):
            return true
        default:
            return false
        }
    }
}

class RouterMock: RouterProtocol {
    
    var presentedView: UIViewController!
    
    var actions: [RoutingAction] = []
    
    func push(view: UIViewController) {
        actions.append(.push(view))
    }
    
    func present(view: UIViewController) {
        actions.append(.present(view))
    }
    
    func segue(storyboard: AppStoryboard, vc: UIViewController.Type) {
        actions.append(.segue(storyboard, vc))
    }
    
    func alert(title: String, message: String, actions: [(title: String, style: UIAlertAction.Style)]) {
        self.actions.append(.alert(message))
    }
    
    func toast(title: String, message: String) {
        self.actions.append(.toast(message))
    }
    
    func startActivityIndicator() {
        self.actions.append(.activityStart)
    }
    
    func stopActivityIndicator() {
        self.actions.append(.activityStop)
    }
    
    func dismiss() {
        self.actions.append(.dismiss)
    }
    
    func pop() {
        self.actions.append(.pop)
    }
    
    func alertWithAction(title: String, message: String, actions: [(title: String, style: UIAlertAction.Style, action: () -> Void)]) {
        self.actions.append(.alertWithAction((title, message)))
    }
}
