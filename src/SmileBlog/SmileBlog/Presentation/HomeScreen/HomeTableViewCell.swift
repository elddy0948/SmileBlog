import UIKit

final class HomeTableViewCell: UITableViewCell {
  static let reuseIdentifier = String(describing: HomeTableViewCell.self)
  
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
  
  func configureCellData(with post: Post) {
    DispatchQueue.main.async { [weak self] in
      self?.writerLabel.text = post.writer
      self?.titleLabel.text = post.title
      self?.createdAtLabel.text = "created at : " + String(describing: post.createdAt)
    }
  }
  
  private func setupViews() {
    stackView.axis = .vertical
    stackView.distribution = .fill
    stackView.spacing = 8
    
    writerLabel.textColor = .secondaryLabel
    writerLabel.textAlignment = .left
    writerLabel.font = UIFont.preferredFont(forTextStyle: .body)
    
    titleLabel.textColor = .label
    titleLabel.textAlignment = .left
    titleLabel.font = UIFont.preferredFont(forTextStyle: .title3)
    
    createdAtLabel.textColor = .label
    createdAtLabel.textAlignment = .left
    createdAtLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
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
      stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      contentView.bottomAnchor.constraint(
        equalToSystemSpacingBelow: stackView.bottomAnchor,
        multiplier: 1),
    ])
  }
}
