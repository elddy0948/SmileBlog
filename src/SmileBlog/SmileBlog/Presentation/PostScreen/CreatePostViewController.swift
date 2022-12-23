import UIKit

final class CreatePostViewController: UIViewController {
  private lazy var saveButton: UIButton = {
    let button = UIButton()
    button.tintColor = .label
    button.setTitle("Save", for: .normal)
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
  private let user: User?
  
  init(user: User) {
    self.user = user
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
  }
  
  @objc func didTappedCancel() {
    self.dismiss(animated: true)
  }
  
  @objc func didTappedSave() {
    guard let title = titleTextField.text,
          let body = bodyTextView.text else {
      self.dismiss(animated: true)
      return
    }
    
    if title == "" || body == "" {
      self.dismiss(animated: true)
      return
    }
    
    guard let user = user else { return }
    
    savePost(with: user, title: title, body: body)
  }
  
  private func savePost(with user: User, title: String, body: String) {
    let postToCreate = Post(
      id: nil,
      title: title,
      body: body,
      writer: user.username,
      editedAt: "\(Date())",
      createdAt: "\(Date())",
      user: user.id
    )
    
    usecase.create(
      post: postToCreate,
      completion: { [weak self] result in
        switch result {
        case .success(_):
          DispatchQueue.main.async {
            self?.dismiss(animated: true)
          }
        case .failure(let error):
          print(error)
        }
      })
  }
}

extension CreatePostViewController {
  private func setupViews() {
    cancelButton.addTarget(
      self,
      action: #selector(didTappedCancel),
      for: .touchUpInside)
    saveButton.addTarget(
      self,
      action: #selector(didTappedSave),
      for: .touchUpInside)
  }
  
  private func layout() {
    let safeArea = view.safeAreaLayoutGuide
    
    view.addSubview(cancelButton)
    view.addSubview(saveButton)
    view.addSubview(titleTextField)
    view.addSubview(bodyTextView)
    
    cancelButton.translatesAutoresizingMaskIntoConstraints = false
    saveButton.translatesAutoresizingMaskIntoConstraints = false
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
      
      saveButton.topAnchor.constraint(equalTo: cancelButton.topAnchor),
      safeArea.trailingAnchor.constraint(
        equalToSystemSpacingAfter: saveButton.trailingAnchor,
        multiplier: 1),
      saveButton.widthAnchor.constraint(equalToConstant: 80),
      saveButton.heightAnchor.constraint(equalToConstant: 48),
      
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
