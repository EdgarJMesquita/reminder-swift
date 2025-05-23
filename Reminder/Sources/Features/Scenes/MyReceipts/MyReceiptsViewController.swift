//
//  MyReceiptsViewController.swift
//  Reminder
//
//  Created by Edgar Jonas Mesquita da Silva on 22/01/25.
//

import Foundation
import UIKit
import CoreFramework

class MyReceiptsViewController: UIViewController {
    weak var delegate: MyReceiptsFlowDelegate?
    let viewModel = MyReceiptsViewModel()

    let contentView: MyReceiptsView

    init(contentView: MyReceiptsView, delegate: MyReceiptsFlowDelegate) {
        self.contentView = contentView
        super.init(nibName: nil, bundle: nil)
        self.contentView.delegate = self
        self.delegate = delegate
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }

    private func handleEmptyMessage() {
        if self.viewModel.receipts.isEmpty {
            self.contentView.showEmptyMessage()
        } else {
            self.contentView.hideEmptyMessage()
        }
    }

    private func loadData() {
        Task { [weak self] in
            guard let self else { return }
            await self.viewModel.fetchReceipts()
            self.contentView.customTableView.reloadData()
            self.handleEmptyMessage()
        }
    }

    private func setup() {
        view.addSubview(contentView)

        view.backgroundColor = CFColors.gray600

        navigationController?.navigationBar.isHidden = true

        setupConstraints()
        bindDataSource()
    }

    private func bindDataSource() {
        contentView.customTableView.delegate = self
        contentView.customTableView.dataSource = self
    }

    private func setupConstraints() {
        setupContentViewToBounds(contentView: contentView)
    }
}

extension MyReceiptsViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.receipts.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

extension MyReceiptsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RemedyCell.identifier, for: indexPath) as? RemedyCell else {
            return UITableViewCell()
        }

        let receipt = viewModel.receipts[indexPath.section]

//        cell.onDeleteTapped = { [weak self] in
//            guard let self else { return }
//            guard let currentIndexPath = self.contentView.customTableView.indexPath(for: cell) else { return }
//            self.viewModel.deleteReceipt(byId: receipt.id)
//            self.contentView.customTableView.deleteSections(IndexSet(integer: currentIndexPath.section), 
//                                                            with: .automatic)
//            self.handleEmptyMessage()
//        }
        cell.delegate = self
        cell.configure(remedy: receipt)

        return cell
    }

}

extension MyReceiptsViewController: RemedyCellProtocol {
    func onDelete(_ cell: UITableViewCell) {
        guard let index = contentView.customTableView.indexPath(for: cell) else { return }
        let id = viewModel.receipts[index.section].id

        viewModel.deleteReceipt(byId: id)
        contentView.customTableView.deleteSections(IndexSet(integer: index.section), with: .automatic)

    }
}

extension MyReceiptsViewController: MyReceiptsViewDelegate {
    func goBack() {
        navigationController?.popViewController(animated: true)
    }

    func navigateToMyReceipts() {
        delegate?.navigateToNewReceipt()
    }
}

protocol MyReceiptsFlowDelegate: AnyObject {
    func navigateToNewReceipt()
}
