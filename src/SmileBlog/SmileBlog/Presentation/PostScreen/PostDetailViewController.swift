import UIKit

final class PostDetailViewController: UIViewController {
  enum PostDetailType {
    case editable
    case none
  }
  
  private let writerLabel = UILabel()
  private let createdAtLabel = UILabel()
  private let titleLabel = UILabel()
  private let bodyTextView = UITextView()
  
  private var post: Post?
  private var type: PostDetailType
  
  private let repository = NetworkPostsRepository()
  private lazy var usecase: DefaultPostsUseCase = {
    let usecase = DefaultPostsUseCase(postsRepository: repository)
    return usecase
  }()
  
  init(post: Post, type: PostDetailType) {
    self.post = post
    self.type = type
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
    layout()
    configurePost(post)
  }
  
  private func configurePost(_ post: Post?) {
    guard let post = post else { return }
    writerLabel.text = post.writer
    createdAtLabel.text = String(describing: post.createdAt)
    titleLabel.text = post.title
    bodyTextView.text = post.body
  }
  
  @objc func didTappedEditButton(_ sender: UIBarButtonItem) {
    guard let post = post,
          let postID = post.id else { return }
    
    self.bodyTextView.isEditable = true
    
    let alertController = UIAlertController()
    
    let deleteAction = UIAlertAction(
      title: "Delete",
      style: .destructive,
      handler: { [weak self] _ in
        self?.usecase.deletePost(
          postID: "\(postID)",
          completion: { result in
            switch result {
            case .success(_):
              DispatchQueue.main.async {
                self?.navigationController?.popViewController(
                  animated: true
                )
              }
            case .failure(_):
              return
            }
          })
      }
    )
    
    let editAction = UIAlertAction(
      title: "Edit",
      style: .default,
      handler: { [weak self] _ in
        let editVC = EditPostViewController(post: post)
        self?.present(editVC, animated: true)
      })
    
    let cancelAction = UIAlertAction(
      title: "Cancel",
      style: .cancel)
    
    alertController.addAction(deleteAction)
    alertController.addAction(editAction)
    alertController.addAction(cancelAction)
    
    present(alertController, animated: true)
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
    
    if type == .editable {
      let editBarButton = UIBarButtonItem(
        barButtonSystemItem: .edit,
        target: self,
        action: #selector(didTappedEditButton(_:)))
      navigationItem.rightBarButtonItems = [editBarButton]
    }
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
    
    writerLabel.setContentHuggingPriority(
      .defaultHigh - 2, for: .vertical)
    createdAtLabel.setContentHuggingPriority(
      .defaultHigh - 1, for: .vertical)
    titleLabel.setContentHuggingPriority(
      .defaultHigh + 1, for: .vertical)
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
