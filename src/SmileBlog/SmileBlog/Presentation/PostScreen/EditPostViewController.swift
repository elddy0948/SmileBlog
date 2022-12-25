import UIKit

final class EditPostViewController: UIViewController {
  private lazy var editButton: UIButton = {
    let button = UIButton()
    button.tintColor = .label
    button.setTitle("Edit", for: .normal)
    button.setTitleColor(.label, for: .normal)
    return button
  }()
  
  private lazy var cancelButton: UIButton = {
    let button = UIButton()
    button.tintColor = .systemRed
    button.setTitle("Cancel", for: .normal)
    button.setTitleColor(.systemRed, for: .normal)
    return button
  }()
  
  private lazy var titleTextField: UITextField = {
    let textField = UITextField()
    textField.font = UIFont.preferredFont(forTextStyle: .title2)
    textField.textColor = .label
    textField.backgroundColor = .systemBackground
    textField.placeholder = "Title..."
    textField.autocorrectionType = .no
    textField.autocapitalizationType = .none
    return textField
  }()
  
  private lazy var bodyTextView: UITextView = {
    let textView = UITextView()
    textView.font = UIFont.preferredFont(forTextStyle: .body)
    textView.textColor = .label
    textView.backgroundColor = .systemBackground
    textView.autocorrectionType = .no
    textView.autocapitalizationType = .none
    textView.isEditable = true
    return textView
  }()
  
  private let repository = NetworkPostsRepository()
  private lazy var usecase: DefaultPostsUseCase = {
    let usecase = DefaultPostsUseCase(postsRepository: repository)
    return usecase
  }()
  private var post: Post?
  
  init(post: Post) {
    self.post = post
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    setupViews()
    layout()
    configurePost()
  }
  
  private func configurePost() {
    guard let post = post else { return }
    titleTextField.text = post.title
    bodyTextView.text = post.body
  }
  
  @objc func didTappedCancel() {
    self.dismiss(animated: true)
  }
  
  @objc func didTappedEdit() {
    guard let title = titleTextField.text,
          let body = bodyTextView.text else {
      self.dismiss(animated: true)
      return
    }
    
    if title == "" || body == "" {
      self.dismiss(animated: true)
      return
    }
    
    
    guard let post = post,
          let postID = post.id else { return }
    
    let postToEdit = Post(
      id: post.id,
      title: title,
      body: body,
      writer: post.writer,
      editedAt: String(describing: Date()),
      createdAt: post.createdAt,
      user: post.user
    )
    
    editPost(id: "\(postID)", post: postToEdit)
  }
  
  private func editPost(id: String, post: Post) {
    usecase.updatePost(
      postID: id,
      updatedPost: post,
      completion: { [weak self] result in
        switch result {
        case .success(_):
          DispatchQueue.main.async {
            self?.dismiss(animated: true)
          }
        case .failure(_):
          return
        }
      }
    )
  }
}

extension EditPostViewController {
  private func setupViews() {
    cancelButton.addTarget(
      self,
      action: #selector(didTappedCancel),
      for: .touchUpInside)
    editButton.addTarget(
      self,
      action: #selector(didTappedEdit),
      for: .touchUpInside)
  }
  
  private func layout() {
    let safeArea = view.safeAreaLayoutGuide
    
    view.addSubview(cancelButton)
    view.addSubview(editButton)
    view.addSubview(titleTextField)
    view.addSubview(bodyTextView)
    
    cancelButton.translatesAutoresizingMaskIntoConstraints = false
    editButton.translatesAutoresizingMaskIntoConstraints = false
    titleTextField.translatesAutoresizingMaskIntoConstraints = false
    bodyTextView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      cancelButton.topAnchor.constraint(
        equalToSystemSpacingBelow: safeArea.topAnchor,
        multiplier: 1),
      cancelButton.leadingAnchor.constraint(
        equalToSystemSpacingAfter: safeArea.leadingAnchor,
        multiplier: 1),
      cancelButton.widthAnchor.constraint(equalToConstant: 80),
      cancelButton.heightAnchor.constraint(equalToConstant: 48),
      
      editButton.topAnchor.constraint(equalTo: cancelButton.topAnchor),
      safeArea.trailingAnchor.constraint(
        equalToSystemSpacingAfter: editButton.trailingAnchor,
        multiplier: 1),
      editButton.widthAnchor.constraint(equalToConstant: 80),
      editButton.heightAnchor.constraint(equalToConstant: 48),
      
      titleTextField.topAnchor.constraint(
        equalToSystemSpacingBelow: cancelButton.bottomAnchor,
        multiplier: 1),
      titleTextField.leadingAnchor.constraint(
        equalToSystemSpacingAfter: safeArea.leadingAnchor,
        multiplier: 2),
      safeArea.trailingAnchor.constraint(
        equalToSystemSpacingAfter: titleTextField.trailingAnchor,
        multiplier: 2),
      titleTextField.heightAnchor.constraint(equalToConstant: 56),
      
      bodyTextView.topAnchor.constraint(
        equalToSystemSpacingBelow: titleTextField.bottomAnchor,
        multiplier: 1),
      bodyTextView.leadingAnchor.constraint(
        equalTo: titleTextField.leadingAnchor),
      bodyTextView.trailingAnchor.constraint(
        equalTo: titleTextField.trailingAnchor),
      safeArea.bottomAnchor.constraint(
        equalToSystemSpacingBelow: bodyTextView.bottomAnchor,
        multiplier: 1),
    ])
  }
}
