//
//  TableViewCell.swift
//  MyMuz
//
//  Created by Garnik on 3/4/22.
//

import UIKit

class TableViewCell: UITableViewCell {

    static let identifier = "ViewController"
    
    private let iconContainer: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 22
        view.layer.masksToBounds = true
        return view
    }()
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    private let trackName: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont(name: "Helvetica-Bold", size: 19)
        label.textColor = .white
        return label
    }()
    private let artistName: UILabel = {
        let nameLabel = UILabel()
        nameLabel.numberOfLines = 1
        nameLabel.textColor = .lightGray
        return nameLabel
    }()
//    private let heartButton: UIButton = {
//        let heart = UIButton()
//        heart.imageView?.image = UIImage(systemName: "heart")
//        heart.backgroundColor = .blue
//        return heart
//    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(iconContainer)
        iconContainer.addSubview(iconImageView)
        contentView.addSubview(trackName)
        contentView.addSubview(artistName)
        contentView.clipsToBounds = true
        accessoryType = .disclosureIndicator
        accessoryView = UIView(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
        accessoryView!.backgroundColor = .tertiaryLabel
//        accessoryView?.addSubview(heartButton)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        let size: CGFloat = contentView.frame.size.height - 15
        iconContainer.frame = CGRect(x: 15, y: 6, width: size, height: size)
        
        let imageSize: CGFloat = size/1.6
        iconImageView.frame = CGRect(x: (size - imageSize)/2,
                                     y: (size - imageSize)/2,
                                     width: imageSize,
                                     height: imageSize)
        trackName.frame = CGRect(x: 25 + iconContainer.frame.size.width,
                             y: -10,
                             width: contentView.frame.size.width - 20 - iconContainer.frame.size.width,
                             height: contentView.frame.size.height)
        artistName.frame = CGRect(x: 25 + iconContainer.frame.size.width,
                                 y: 10,
                                 width: contentView.frame.size.width - 20 - iconContainer.frame.size.width,
                                 height: contentView.frame.size.height)
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        iconContainer.backgroundColor = nil
        iconImageView.image = nil
        trackName.text = nil
        artistName.text = nil
    }
    public func configure(with modal: Song) {
        iconImageView.image = UIImage(named: modal.imageName)
        trackName.text = modal.name
        artistName.text = modal.artistName
        
    }
}
