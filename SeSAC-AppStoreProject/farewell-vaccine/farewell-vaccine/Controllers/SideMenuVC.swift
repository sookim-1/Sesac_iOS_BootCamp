//
//  SideMenuVC.swift
//  farewell-vaccine
//
//  Created by sookim on 2021/12/04.
//

import UIKit

struct SideMenuModel {
    var icon: UIImage
    var title: String
}

protocol SideMenuViewControllerDelegate {
    func selectedCell(_ row: Int)
}

class SideMenuVC: UIViewController {
    @IBOutlet var headerImageView: UIImageView!
    @IBOutlet var sideMenuTableView: UITableView!
    @IBOutlet var footerLabel: UILabel!

    var delegate: SideMenuViewControllerDelegate?

    var defaultHighlightedCell: Int = 0

    var menu: [SideMenuModel] = [
        SideMenuModel(icon: UIImage(systemName: "house.fill")!, title: "홈"),
        SideMenuModel(icon: UIImage(systemName: "paperplane.fill")!, title: "연애테스트"),
        SideMenuModel(icon: UIImage(systemName: "pencil.circle.fill")!, title: "소개하기"),
        SideMenuModel(icon: UIImage(systemName: "book.circle.fill")!, title: "연애 명언"),
        SideMenuModel(icon: UIImage(systemName: "slider.horizontal.3")!, title: "설정")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        configureSideMenuView()
    }

    func configureSideMenuView() {
        self.sideMenuTableView.delegate = self
        self.sideMenuTableView.dataSource = self
        self.sideMenuTableView.backgroundColor = .customPink ?? .systemPink
        self.sideMenuTableView.separatorStyle = .none

        DispatchQueue.main.async {
            let defaultRow = IndexPath(row: self.defaultHighlightedCell, section: 0)
            self.sideMenuTableView.selectRow(at: defaultRow, animated: false, scrollPosition: .none)
        }

        self.footerLabel.textColor = UIColor.white
        self.footerLabel.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        self.footerLabel.text = "© 2021. 이별차단 Co. all rights reserved."

        self.sideMenuTableView.register(SideMenuCell.nib, forCellReuseIdentifier: SideMenuCell.identifier)

        self.sideMenuTableView.reloadData()
    }
}



// MARK: - UITableViewDelegate

extension SideMenuVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.selectedCell(indexPath.row)
    }
    
}

// MARK: - UITableViewDataSource

extension SideMenuVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.menu.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SideMenuCell.identifier, for: indexPath) as? SideMenuCell else { fatalError("xib 파일 에러") }

        cell.iconImageView.image = self.menu[indexPath.row].icon
        cell.titleLabel.text = self.menu[indexPath.row].title

        let myCustomSelectionColorView = UIView()
        myCustomSelectionColorView.backgroundColor = .systemPink
        cell.selectedBackgroundView = myCustomSelectionColorView
        return cell
    }

}

