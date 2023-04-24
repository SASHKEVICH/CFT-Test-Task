//
//  NewsTableViewHelper.swift
//  CFT-Test-Task
//
//  Created by Александр Бекренев on 23.04.2023.
//

import UIKit

protocol NewsTableViewHeaderViewDelegate: AnyObject {
    func didTapGreetingsButton()
}

protocol NewsTableViewHelperProtocol: UITableViewDelegate, UITableViewDataSource {
    var presenter: NewsViewPresenterTableViewHelperProtocol? { get set }
}

final class NewsTableViewHelper: NSObject, NewsTableViewHelperProtocol {
    weak var presenter: NewsViewPresenterTableViewHelperProtocol?
    
    // MARK: - UITableViewDelegate
    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        80
    }
    
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(
        _ tableView: UITableView,
        viewForHeaderInSection section: Int
    ) -> UIView? {
        guard let view = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: NewsTableViewHeaderView.identifier) as? NewsTableViewHeaderView
        else {
            assertionFailure("cannot dequeue header")
            return nil
        }

        view.delegate = self

        return view
    }
    
    func tableView(
        _ tableView: UITableView,
        heightForHeaderInSection section: Int
    ) -> CGFloat {
        80
    }
    
    // MARK: - UITableViewDataSource
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        guard let presenter = presenter else {
            assertionFailure("presenter is nil")
            return 0
        }
        
        return presenter.news.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: NewsTableViewCell.identifier, for: indexPath) as? NewsTableViewCell
        else {
            assertionFailure("cannot dequeue cell")
            return UITableViewCell()
        }
        
        let news = presenter?.news[indexPath.row]
        cell.cellTitle = news?.title
        
        cell.accessoryType = .disclosureIndicator
        
        if indexPath.row == 0 {
            return cell.setupFirstCellInTableView()
        }
        
        if indexPath == tableView.lastCellIndexPath {
            return cell.setupLastCellWithoutBottomSeparator(tableViewWidth: tableView.bounds.width)
        }
        
        return cell
    }
}

extension NewsTableViewHelper: NewsTableViewHeaderViewDelegate {
    func didTapGreetingsButton() {
        print("tap")
    }
}
