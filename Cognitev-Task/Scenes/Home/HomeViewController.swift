//
//  HomeViewController.swift
//  Cognitev-Task
//
//  Created by Ahmed Ramy on 11/27/19.
//  Copyright © 2019 Ahmed Ramy. All rights reserved.
//

import UIKit
import SwifterSwift
import RxSwift

class HomeViewController: BaseViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var feedUpdateStyleButton: UIBarButtonItem!
    
    private var viewModel: HomeViewModel!
    private var location: LocationProtocol = AppleLocationManager()
    
    override func viewDidLoad() {
        tableView.register(nibWithCellClass: VenueTableViewCell.self)
        super.viewDidLoad()
    }
    
    override func initialize() {
        viewModel.fetchExploreFeed()
    }
    
    override func bind() {
        viewModel = HomeViewModel(location: location, cache: cache, router: router, network: network)
        
        self.viewModel.fetchStyle.subscribe(onNext: { (fetchStyle) in
            let currentFetchingStyle = self.viewModel.fetchStyle.value
            switch currentFetchingStyle {
            case .oneShot:
                self.feedUpdateStyleButton.title = "Single Update"
            case .realtime:
                self.feedUpdateStyleButton.title = "Real-Time"
            }
        }).disposed(by: disposeBag)
        
        feedUpdateStyleButton.rx.tap.subscribe(onNext: { [weak self] (_) in
            guard let self = self else { return }
            let currentFetchingStyle = self.viewModel.fetchStyle.value
            switch currentFetchingStyle {
            case .realtime:
                self.viewModel.fetchStyle.accept(.oneShot)
            case .oneShot:
                self.viewModel.fetchStyle.accept(.realtime)
            }
        }).disposed(by: disposeBag)
        
        viewModel.venues.bind(to: tableView.rx.items(cellIdentifier: "\(VenueTableViewCell.self)", cellType: VenueTableViewCell.self)) { row, model, cell in
            cell.set(model: model)
        }.disposed(by: disposeBag)
        
        tableView.rx.contentOffset.subscribe(onNext: { [weak self] (contentOffset) in
            guard let self = self else { return }
            let startLoadingOffset: CGFloat = 50.0
            let isNearBottom: Bool = (contentOffset.y + self.tableView.height + startLoadingOffset) > (self.tableView.contentSize.height)
            let didLoadVenuesAlready = !self.viewModel.venues.value.isEmpty
            if isNearBottom, didLoadVenuesAlready {
                self.viewModel.fetchMoreVenues()
            }
        }).disposed(by: disposeBag)
    }
}
