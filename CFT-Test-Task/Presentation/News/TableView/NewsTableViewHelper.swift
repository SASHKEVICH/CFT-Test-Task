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

public protocol NewsTableViewHelperProtocol: UITableViewDelegate, UITableViewDataSource {
    var presenter: NewsViewPresenterTableViewHelperProtocol? { get set }
}

final class NewsTableViewHelper: NSObject, NewsTableViewHelperProtocol {
    weak var presenter: NewsViewPresenterTableViewHelperProtocol?
}

// MARK: - UITableViewDelegate
extension NewsTableViewHelper {
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
        presenter?.didTapNewsCell(at: indexPath)
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
    
    func tableView(
        _ tableView: UITableView,
        estimatedHeightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        80
    }
    
    func tableView(
        _ tableView: UITableView,
        willDisplay cell: UITableViewCell,
        forRowAt indexPath: IndexPath
    ) {
        if let visibleIndexPaths = tableView.indexPathsForVisibleRows, visibleIndexPaths.contains(indexPath) {
            presenter?.requestFetchNewsNextPageIfLastCell(at: indexPath)
        }
    }
}

// MARK: - UITableViewDataSource
extension NewsTableViewHelper {
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
        configureAdditinalInfo(for: cell, news: news)
        
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

// MARK: - NewsTableViewHeaderViewDelegate
extension NewsTableViewHelper: NewsTableViewHeaderViewDelegate {
    func didTapGreetingsButton() {
        presenter?.didTapGreetingsButton()
    }
}

// MARK: - Private methods
private extension NewsTableViewHelper {
    func configureAdditinalInfo(for cell: NewsTableViewCell, news: News?) {
        let author = news?.author ?? "Неизвестно"
        let source = news?.source?.name ?? "Неизвестно"
        let additionalInfo = author + " | " + source
        cell.additionalInfo = additionalInfo
    }
}
