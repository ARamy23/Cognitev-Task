//
//  ExternalProtocols.swift
//  Cognitev-Task
//
//  Created by Ahmed Ramy on 11/27/19.
//  Copyright © 2019 Ahmed Ramy. All rights reserved.
//

import UIKit
import Moya
import RxSwift

protocol LocationProtocol {
    func startTracking()
    func getCurrentLocation() -> Observable<(long: Double, lat: Double)>
}

protocol CacheProtocol {
    func getData(key: String) -> [Data]?
    func saveData(_ data: Data?, key: String)
    func getObject<T: Codable>(_ object: T.Type, key: String) -> T?
    func saveObject<T: Codable>(_ object: T, key: String)
    func removeObject<T: Codable>(object: T.Type, key: String)
}

protocol NetworkProtocol {
    func callModel<T: Codable, U: BaseService>(model: T.Type, api: U) -> Observable<T>
}

protocol RouterProtocol {
    var presentedView: UIViewController! {set get}
    func present(view: UIViewController)
    func push(view: UIViewController)
    func startActivityIndicator()
    func stopActivityIndicator()
    func dismiss()
    func pop()
    func segue(storyboard: AppStoryboard, vc: UIViewController.Type)
    func alert(title: String, message: String, actions: [(title: String, style: UIAlertAction.Style)])
    func alertWithAction(title: String, message: String, actions: [(title: String, style: UIAlertAction.Style, action: () -> Void)])
    func toast(title: String, message: String)
}
