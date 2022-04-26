//
//  FriendsViewController.swift
//  lessOne
//
//  Created by Евгений Ефименко on 26.02.2022.
//

import UIKit

class FriendsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    

    var friendsArray = [Friend]()
    let reuseIdentifier = "reuseIdentifier"
    let fromFriendsToGallery = "fromFriendsToGallery"

    let interactiveTransition = CustomTableViewCell()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: reuseIdentifier)
        self.navigationController?.delegate = self
        createfriendsArray()
        //        self.navigationItem.leftBarButtonItem = self.editButtonItem - редактирование
        tableView.reloadData()

    }

    func createfriendsArray() {

        let friendOne = Friend(name: "Vin Disel", avatar: "VinDizel", foto: ["Char", "Daytona"])
        friendsArray.append(friendOne)

        let friendTwo = Friend(name: "Paul Waker", avatar: "PoulWaker", foto: ["Supra", "Supra2", "NewCar"])
        friendsArray.append(friendTwo)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == fromFriendsToGallery {
            guard let destinationVC = segue.destination as? GalleryViewController,
                  let fotoArray = sender as? [String]
            else {return}
            destinationVC.fotoArray = fotoArray
        }
    }
}

extension FriendsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }

    //    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //        print("selected \(friendsArray[indexPath.row].name) group")
    //        performSegue(withIdentifier: fromFriendsToGallery, sender: friendsArray[indexPath.row].foto)
    //    }

}

extension FriendsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendsArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? CustomTableViewCell else {return UITableViewCell()}
        cell.configure(friend: friendsArray[indexPath.row], completion:{ [weak self] in
            guard let self = self else {return}
            self.performSegue(withIdentifier: self.fromFriendsToGallery, sender: self.friendsArray[indexPath.row].foto)
        })
        return cell
    }
}
extension FriendsViewController: UINavigationControllerDelegate {

    func navigationController(_ navigationController: UINavigationController,
                              animationControllerFor operation: UINavigationController.Operation,
                              from fromVC: UIViewController,
                              to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == .push {
            return AnimationToGallery()
        } else if operation == .pop {
            if navigationController.viewControllers.first != toVC {
            }
            return AnimationToFriends()
        }
        return nil
    }


}

