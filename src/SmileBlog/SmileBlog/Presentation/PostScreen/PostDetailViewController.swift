import UIKit

final class PostDetailViewController: UIViewController {
  private let writerLabel = UILabel()
  private let createdAtLabel = UILabel()
  private let titleLabel = UILabel()
  private let bodyTextView = UITextView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
    layout()
  }
  
  func configurePost(_ post: Post) {
    writerLabel.text = post.writer
    createdAtLabel.text = String(describing: post.createdAt)
    titleLabel.text = post.title
    bodyTextView.text = post.body
  }
  
  private func setupViews() {
    view.backgroundColor = .systemBackground
    writerLabel.textColor = .secondaryLabel
    writerLabel.numberOfLines = 1
    writerLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
    
    createdAtLabel.textColor = .secondaryLabel
    createdAtLabel.numberOfLines = 1
    createdAtLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
    
    titleLabel.textColor = .label
    titleLabel.numberOfLines = 0
    titleLabel.font = UIFont.preferredFont(forTextStyle: .title1)
    
    bodyTextView.textColor = .label
    bodyTextView.font = UIFont.preferredFont(forTextStyle: .body)
    bodyTextView.isEditable = false
  }
  
  private func layout() {
    let safeArea = view.safeAreaLayoutGuide
    view.addSubview(writerLabel)
    view.addSubview(createdAtLabel)
    view.addSubview(titleLabel)
    view.addSubview(bodyTextView)
    
    writerLabel.translatesAutoresizingMaskIntoConstraints = false
    createdAtLabel.translatesAutoresizingMaskIntoConstraints = false
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    bodyTextView.translatesAutoresizingMaskIntoConstraints = false
    
    writerLabel.setContentHuggingPriority(.defaultHigh - 2, for: .vertical)
    createdAtLabel.setContentHuggingPriority(.defaultHigh - 1, for: .vertical)
    titleLabel.setContentHuggingPriority(.defaultHigh + 1, for: .vertical)
    bodyTextView.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
    
    NSLayoutConstraint.activate([
      writerLabel.topAnchor.constraint(
        equalToSystemSpacingBelow: safeArea.topAnchor,
        multiplier: 1
      ),
      writerLabel.leadingAnchor.constraint(
        equalToSystemSpacingAfter: safeArea.leadingAnchor,
        multiplier: 1
      ),
      safeArea.trailingAnchor.constraint(
        equalToSystemSpacingAfter: writerLabel.trailingAnchor,
        multiplier: 1
      ),
      createdAtLabel.topAnchor.constraint(
        equalToSystemSpacingBelow: writerLabel.bottomAnchor,
        multiplier: 1
      ),
      createdAtLabel.leadingAnchor.constraint(
        equalTo: writerLabel.leadingAnchor
      ),
      createdAtLabel.trailingAnchor.constraint(
        equalTo: writerLabel.trailingAnchor
      ),
      titleLabel.topAnchor.constraint(
        equalToSystemSpacingBelow: createdAtLabel.bottomAnchor,
        multiplier: 1
      ),
      titleLabel.leadingAnchor.constraint(
        equalTo: writerLabel.leadingAnchor
      ),
      titleLabel.trailingAnchor.constraint(
        equalTo: writerLabel.trailingAnchor
      ),
      bodyTextView.topAnchor.constraint(
        equalToSystemSpacingBelow: titleLabel.bottomAnchor,
        multiplier: 1
      ),
      bodyTextView.leadingAnchor.constraint(
        equalTo: writerLabel.leadingAnchor
      ),
      bodyTextView.trailingAnchor.constraint(
        equalTo: writerLabel.trailingAnchor
      ),
      safeArea.bottomAnchor.constraint(
        equalToSystemSpacingBelow: bodyTextView.bottomAnchor,
        multiplier: 1
      ),
    ])
  }
}
