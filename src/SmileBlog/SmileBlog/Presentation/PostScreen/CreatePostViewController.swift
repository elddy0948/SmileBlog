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
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    layout()
  }
}

extension CreatePostViewController {
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
