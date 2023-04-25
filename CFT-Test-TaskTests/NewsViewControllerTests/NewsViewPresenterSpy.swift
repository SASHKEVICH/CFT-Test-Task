//
//  NewsViewPresenterSpy.swift
//  CFT-Test-TaskTests
//
//  Created by Александр Бекренев on 25.04.2023.
//

import UIKit
import CFT_Test_Task

final class NewsViewPresenterSpy: NewsViewPresenterProtocol {
    weak var view: NewsViewControllerProtocol?
    var requestNewsCalled = false
    var tableViewHelper: NewsTableViewHelperProtocol = NewsTableViewHelperDummy()
    
    func requestNews() {
        self.requestNewsCalled = true
    }
    
    func didTapLogoutButton() {}
}

final class NewsTableViewHelperDummy: NSObject, NewsTableViewHelperProtocol {
    var presenter: NewsViewPresenterTableViewHelperProtocol?
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { 0 }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { UITableViewCell() }
}
