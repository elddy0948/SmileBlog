import UIKit

final class PostTableViewCell: UITableViewCell {
  static let reuseIdentifier = String(describing: PostTableViewCell.self)
  
  private let stackView = UIStackView()
  private let writerLabel = UILabel()
  private let titleLabel = UILabel()
  private let createdAtLabel = UILabel()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupViews()
    layout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    writerLabel.text = nil
    titleLabel.text = nil
    createdAtLabel.text = nil
  }
  
  func configureCellData(with post: Post) {
    writerLabel.text = post.writer
    titleLabel.text = post.title
    createdAtLabel.text = "created at : " + String(describing: post.createdAt)
  }
  
  private func setupViews() {
    selectionStyle = .none
    
    stackView.axis = .vertical
    stackView.distribution = .fillEqually
    stackView.spacing = 8
    
    writerLabel.textColor = .secondaryLabel
    writerLabel.textAlignment = .left
    writerLabel.font = UIFont.preferredFont(forTextStyle: .body)
    writerLabel.numberOfLines = 1
    writerLabel.text = "writer"
    
    titleLabel.textColor = .label
    titleLabel.textAlignment = .left
    titleLabel.font = UIFont.preferredFont(forTextStyle: .title3)
    titleLabel.numberOfLines = 0
    titleLabel.text = "title"
    
    createdAtLabel.textColor = .label
    createdAtLabel.textAlignment = .left
    createdAtLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
    createdAtLabel.numberOfLines = 1
    createdAtLabel.text = "created"
  }
  
  private func layout() {
    contentView.addSubview(stackView)
    
    stackView.translatesAutoresizingMaskIntoConstraints = false
    
    stackView.addArrangedSubview(writerLabel)
    stackView.addArrangedSubview(titleLabel)
    stackView.addArrangedSubview(createdAtLabel)
    
    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(
        equalToSystemSpacingBelow: contentView.topAnchor,
        multiplier: 1),
      stackView.leadingAnchor.constraint(
        equalToSystemSpacingAfter: contentView.leadingAnchor,
        multiplier: 1),
      contentView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
      contentView.bottomAnchor.constraint(
        equalToSystemSpacingBelow: stackView.bottomAnchor,
        multiplier: 1),
    ])
  }
}
