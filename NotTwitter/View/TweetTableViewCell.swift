//
//  TweetTableViewCell.swift
//  NotTwitter
//
//  Created by Joshua on 11/12/2022.
//

import UIKit

class TweetTableViewCell: UITableViewCell, ParalexEffectDelegate {
    private var regex = NSRegularExpression()
    private var characterPattern = "(?:#|@)\\w+"

    @IBOutlet private weak var authorNameLabel: UILabel! {
        didSet {
            authorNameLabel.textColor = GlobalConstants.AuthorNameColorRed
        }
    }
    @IBOutlet private weak var tweetDateLabel: UILabel! {
        didSet {
            tweetDateLabel.textColor = GlobalConstants.TweetDateColorGrey
        }
    }
    @IBOutlet private weak var tweetLabel: UILabel!
    @IBOutlet private weak var authorImageView: CustomImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.layoutIfNeeded()
        setupUI()
        applyParallaxEffect(onView: authorImageView, magnitude: 5)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        authorImageView.image = nil
        authorNameLabel.text = nil
        tweetDateLabel.text = nil
        tweetLabel.text = nil
    }

    func setupCell(_ tweet: Timeline) {
        contentView.backgroundColor = .white
        setupAccessibility(tweet: tweet)
        let imageUrl = tweet.avatar
        if let url = URL(string: imageUrl ?? "") {
            authorImageView.loadImage(from: url)
        }
        if imageUrl == nil {
            authorImageView.image = UIImage(named: "blankAvatar")
        }
        setupAttributedText(text: tweet.content)
        authorNameLabel.text = tweet.author
        tweetDateLabel.text = tweet.date.dateAndTimetoString()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
          super.setSelected(selected, animated: animated)
          if selected {
              contentView.backgroundColor = .green
              UIView.animate(withDuration: 0.3, animations: {
                  self.transform = CGAffineTransform(scaleX: 1.06, y: 1.06)
              }, completion: { finished in
                  UIView.animate(withDuration: 0.3) {
                      self.contentView.backgroundColor = .white
                      self.transform = .identity
                  }
              })
          }
      }
    
    private func setupUI() {
        authorImageView.layer.cornerRadius = authorImageView.frame.width / 10
        authorImageView.layer.borderWidth = 3
        authorImageView.layer.borderColor = GlobalConstants.AvatarBorderColorBlue.cgColor
        authorImageView.layer.shadowColor = GlobalConstants.AvatarShadowColorBlue.cgColor
        authorImageView.layer.shadowOpacity = 1
        authorImageView.layer.shadowOffset = CGSize.zero
        authorImageView.layer.shadowRadius = 10
        authorImageView.layer.shadowPath = UIBezierPath(roundedRect: authorImageView.bounds, cornerRadius: 10).cgPath
    }
    
    private func setupAccessibility(tweet: Timeline) {
        authorNameLabel.isAccessibilityElement = false
        authorImageView.isAccessibilityElement = false
        tweetLabel.isAccessibilityElement = false
        tweetDateLabel.isAccessibilityElement = false

        self.accessibilityLabel = "Tweet by..\(tweet.author).. \(tweet.content)"
    }

    private func setupAttributedText(text: String) {
        do {
             regex = try NSRegularExpression(pattern: characterPattern, options: [])
        } catch {
            print("Failed to create regex")
        }

        let attrStr = NSMutableAttributedString.init(string: text)
        let plainStr = attrStr.string
        attrStr.addAttribute(.foregroundColor, value: UIColor.black, range: NSRange(0..<plainStr.utf16.count))

        let matches = regex.matches(in: plainStr, range: NSRange(0..<plainStr.utf16.count))

        for match in matches {
            let nsRange = match.range
            let matchStr = plainStr[Range(nsRange, in: plainStr) ?? plainStr.startIndex..<plainStr.startIndex]
            let color: UIColor
            if matchStr.hasPrefix("@") {
                color = .blue
            } else {
                color = .systemBlue
            }
            attrStr.addAttribute(.foregroundColor, value: color, range: nsRange)
        }

        tweetLabel.attributedText = attrStr
    }
}
