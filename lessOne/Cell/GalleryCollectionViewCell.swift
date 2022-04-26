//
//  GalleryCollectionViewCell.swift
//  lessOne
//
//  Created by Евгений Ефименко on 26.02.2022.
//

import UIKit

class GalleryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var fotoImageView: UIImageView!
    @IBOutlet weak var heartImageView: UIImageView!
    @IBOutlet weak var counterLabel: UILabel!

    var count = 0
    var isHeartPressed = false



    func configure(image: UIImage?) {
        fotoImageView.image = image
        fotoImageView.layer.cornerRadius = 10
        fotoImageView.layer.borderWidth = 5
        fotoImageView.layer.borderColor = #colorLiteral(red: 0, green: 0.5960591371, blue: 0.7803921569, alpha: 1)
        fotoImageView.layer.masksToBounds = true
        fotoImageView.contentMode = .scaleToFill
        fotoImageView.translatesAutoresizingMaskIntoConstraints = false

    }

    override func prepareForReuse() {
        super.prepareForReuse()
        fotoImageView.image = nil
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

    }

    func heartLike(isFilled: Bool) {
        var heartImage = UIImage(systemName: "heart")
        if isFilled {
            heartImage = UIImage(systemName: "star.fill")
        }
        self.heartImageView.image = heartImage

        UIView.transition(with: counterLabel,
                          duration: 0.5,
                          options: [.transitionFlipFromBottom]) {
            self.counterLabel.text = "1"
        } completion: { _ in

        }

    }

    @IBAction func clearButton(_ sender: UIButton) {
        isHeartPressed = !isHeartPressed
        heartLike(isFilled: isHeartPressed)
        if isHeartPressed {
            self.count += 1
        } else {
            self.count -= 1
        }
        counterLabel.text = String(self.count)

    }
}
