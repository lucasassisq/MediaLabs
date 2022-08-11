import Core
import Foundation
import UIKit

// MARK: - Class

final class ConfigEnvironmentCell: UITableViewCell {



    // MARK: - Static reuse

    static var reuseIdentifier: String { return String.init(describing: self) }

    // MARK: - Internal variables

    let containerView = UIView()

    let imgPhoto: UIImageView = {
        $0.image = UIImage(systemName: "photo")
        $0.tintColor = .lightGray
        return $0
    }(UIImageView())

    let usernameLabel = AppLabel(font: FontFamily.OpenSans.bold,
                                 alignment: .left)

    let postQtyLabel = AppLabel(font: FontFamily.OpenSans.regular,
                                alignment: .left)

    let joinedDateLabel = AppLabel(font: FontFamily.OpenSans.regular,
                                   alignment: .left)

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        addComponents()
        callConstraints()
        backgroundColor = Colors.nelson.color
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        DispatchQueue.main.async {
            self.containerView.roundCorners(corners: .allCorners, radius: 15.0)
            self.imgPhoto.layer.cornerRadius = self.imgPhoto.bounds.height/2.0
            self.imgPhoto.layer.borderWidth = 1.0
            self.imgPhoto.layer.masksToBounds = false
            self.imgPhoto.layer.borderColor = UIColor.white.cgColor
            self.imgPhoto.clipsToBounds = true
        }
    }

}

// MARK: - Extension

extension ConfigEnvironmentCell: ViewProtocol {

    // MARK: - Private methods

    func addComponents() {
        contentView.addSubview(containerView, constraints: true)
        containerView.addSubviews([imgPhoto,
                                   usernameLabel,
                                   postQtyLabel,
                                   joinedDateLabel], constraints: true)
        containerView.backgroundColor = Colors.edna.color
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 18),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -18),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10.0)
        ])
    }

    func callConstraints() {
        setImgConstraints()
        setUserConstraints()
        setPostQtyConstraints()
        setJoinedDateConstraints()
    }

    func setImgConstraints() {
        NSLayoutConstraint.activate([
            imgPhoto.centerY(to: containerView),
            imgPhoto.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16.0),
            imgPhoto.height(size: 80.0),
            imgPhoto.width(size: 80.0)
        ])
    }

    func setUserConstraints() {
        NSLayoutConstraint.activate([
            usernameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8.0),
            usernameLabel.leadingAnchor.constraint(equalTo: imgPhoto.trailingAnchor, constant: 16.0)
        ])
    }

    func setPostQtyConstraints() {
        NSLayoutConstraint.activate([
            postQtyLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 8.0),
            postQtyLabel.leadingAnchor.constraint(equalTo: imgPhoto.trailingAnchor, constant: 16.0)
        ])
    }

    func setJoinedDateConstraints() {
        NSLayoutConstraint.activate([
            joinedDateLabel.topAnchor.constraint(equalTo: postQtyLabel.bottomAnchor, constant: 8.0),
            joinedDateLabel.leadingAnchor.constraint(equalTo: imgPhoto.trailingAnchor, constant: 16.0),
            joinedDateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.0),
            joinedDateLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8.0)
        ])
    }

    func setUserImage(_ user: User) {
        if user.baseImg.isEmpty {
            if let url = URL(string: user.imgUrl) {
                imgPhoto.load(url: url, completion: { image in
                    let size = CGSize(width: 600, height: 600)
                    guard let baseImg = image.resizeAndParseBase64(image: image, sizeDesired: size) else { return }
                    var updateUser = user
                    updateUser.baseImg = baseImg
                    Storage.update(account: updateUser)
                })
            }
        } else {
            DispatchQueue.main.async {
                let image = UIImage.init(base64String: user.baseImg)
                self.imgPhoto.image = image
            }
        }
    }

    // MARK: - Internal methods

    func populate(user: User) {
        usernameLabel.text = user.username
        postQtyLabel.text = "Posts(RT/QT) created: \(user.getPosts())"
        joinedDateLabel.text = "Joined date: \(user.dateJoined)"
        setUserImage(user)
    }
}
