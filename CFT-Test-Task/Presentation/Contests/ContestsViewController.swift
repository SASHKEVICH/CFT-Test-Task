//
//  ContestsViewController.swift
//  CFT-Test-Task
//
//  Created by Александр Бекренев on 23.04.2023.
//

import UIKit

protocol ContestsViewControllerProtocol: AnyObject {
    var presenter: ContestsViewPresenterProtocol? { get set }
}

final class ContestsViewController: UIViewController, ContestsViewControllerProtocol {
    var presenter: ContestsViewPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter?.viewDidLoad()
    }

}
