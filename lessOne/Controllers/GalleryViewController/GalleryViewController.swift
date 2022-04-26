//
//  GalleryViewController.swift
//  lessOne
//
//  Created by Евгений Ефименко on 26.02.2022.
//

import UIKit

class GalleryViewController: UIViewController {

    @IBOutlet weak var CollectionVew: UICollectionView!

    let reuseIdentifier = "reuseIdentifier"
    var fotoArray = [String]()

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        CollectionVew.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        CollectionVew.register(UINib(nibName: "GalleryCollectionViewCell", bundle: nil),             forCellWithReuseIdentifier: reuseIdentifier)
        CollectionVew.delegate = self
        CollectionVew.dataSource = self
    }
}

extension GalleryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fotoArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? GalleryCollectionViewCell else { return UICollectionViewCell() }
        cell.configure(image: UIImage(named: fotoArray[indexPath.item]))
        return cell

    }
}

extension GalleryViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let presentVC = PresenterViewController()
        presentVC.fotoArray = fotoArray
//        presentVC.modalPresentationStyle = .automatic
//        presentVC.modalTransitionStyle = .coverVertical
        navigationController?.pushViewController(presentVC, animated: true)

    }
}

extension GalleryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        //        return CGSize(width: collectionView.bounds.width / 2 - 10 , height: collectionView.bounds.height / 2 - 10)

        return CGSize(width: Constants.galleryItemWidth, height: Constants.galleryItemWidth)
    }
}

