import UIKit

class SBTextField: UITextField {
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupTextField(placeholder: "")
  }
  
  init(placeholder: String) {
    super.init(frame: .zero)
    setupTextField(placeholder: placeholder)
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setupTextField(placeholder: "")
  }
  
  private func setupTextField(placeholder: String) {
    self.placeholder = placeholder
    leftViewMode = .always
    leftView = UIView(
      frame: CGRect(x: 0, y: 0, width: 10, height: 0)
    )
    layer.cornerRadius = 8
    backgroundColor = .secondarySystemBackground
    layer.borderWidth = 1
    layer.borderColor = UIColor.black.cgColor
    keyboardType = .default
  }
}
