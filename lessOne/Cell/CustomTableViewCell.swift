//
//  CustomTableViewCell.swift
//  TableViewTest
//
//  Created by Rodion Molchanov on 11.02.2022.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var fotoImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var completion: (() -> Void)?


    
    
    func configure(name: String?, description: String?, image: UIImage?) {
        fotoImageView.image = image
        nameLabel.text = name
        descriptionLabel.text = description
    }
    
    func configure(group: Group) {
        if let avatarPath = group.avatarImagePathUrl {
            fotoImageView.image = UIImage(named: avatarPath)
        }
        nameLabel.text = group.name
        descriptionLabel.text = group.description
    }
    
    func configure(friend: Friend, completion: (() -> Void)?) {
        if let avatarPath = friend.avatar {
            fotoImageView.image = UIImage(named: avatarPath)
        }
        nameLabel.text = friend.name
        self.completion = completion
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        fotoImageView.image = nil
        nameLabel.text = nil
        descriptionLabel.text = nil
        completion = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func pressImageButton(_ sender: UIButton) {
        UIView.animate(withDuration: 1) { [weak self] in
            self?.fotoImageView.transform = CGAffineTransform.init(scaleX: 0.3, y: 0.3)
        } completion: { _ in
            UIView.animate(withDuration: 1,
                           delay: 0,
                           usingSpringWithDamping: 0.1,
                           initialSpringVelocity: 1,
                           options: []) { [weak self] in
                self?.fotoImageView.transform = .identity
            } completion: { [weak self] _ in
                self?.completion?()
            }
        }
    }
}

