//
//  AllGroupsController.swift
//  lessOne
//
//  Created by Евгений Ефименко on 14.02.2022.
//

import UIKit

class AllGroupsController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!


    let reuseIndentifier = "reuseIndentifier"
    var sourceGroupsArray = [Group]()
    var groupsAutoArray = [Group]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil),
                           forCellReuseIdentifier: reuseIndentifier)
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        createGroopsArray()
        groupsAutoArray = sourceGroupsArray
        tableView.reloadData()

    }

    func createGroopsArray() {
        let groupAcura = Group(avatarImagePathUrl: "Acura", name: "Acura club",
                               description: "Advance")
        sourceGroupsArray.append(groupAcura)
        let groupAudi = Group(avatarImagePathUrl: "Audi", name: "Audi club",
                              description: "Vorsprung durch Technik")
        sourceGroupsArray.append(groupAudi)
        let groupMB = Group(avatarImagePathUrl: "MB", name: "MB club",
                            description: "Unlike any other")
        sourceGroupsArray.append(groupMB)
        let groupBMW = Group(avatarImagePathUrl: "BMW", name: "BMW club",
                             description: "Sheer Driving Pleasure")
        sourceGroupsArray.append(groupBMW)
        let groupWV = Group(avatarImagePathUrl: "WV", name: "WV club",
                            description: "Das Auto")
        sourceGroupsArray.append(groupWV)
        let groupOpel = Group(avatarImagePathUrl: "Opel", name: "Opel club",
                              description: "Wir leben Autos")
        sourceGroupsArray.append(groupOpel)
    }

}

extension AllGroupsController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            groupsAutoArray = sourceGroupsArray
        }
        else {
            groupsAutoArray = sourceGroupsArray.filter({ groupItem in
                groupItem.name.lowercased().contains(searchText.lowercased())
            })
        }
        tableView.reloadData()
    }
}

extension AllGroupsController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }

    func isContain(group: Group) -> Bool {
        for item in Storage.shared.getMyGroups() {
            if item.name == group.name {
                return true
            }
        }
        return false
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected \(groupsAutoArray[indexPath.row].name) group")
        //                NotificationCenter.default.post(name: allGroupsRowPressed, object: groupsAutoArray[indexPath.row])
        if !isContain(group: groupsAutoArray[indexPath.row]) {
            //            Storage.shared.myGroups.append(groupsAutoArray[indexPath.row])
            Storage.shared.addGroup(group: groupsAutoArray[indexPath.row])
        }
    }
}

extension AllGroupsController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupsAutoArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIndentifier, for: indexPath) as? CustomTableViewCell else { return UITableViewCell() }
        cell.configure(group: groupsAutoArray[indexPath.row ])
        return cell
    }
}
