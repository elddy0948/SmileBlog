import UIKit

class SBButton: UIButton {
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupButton(title: "")
  }
  
  init(title: String) {
    super.init(frame: .zero)
    setupButton(title: title)
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setupButton(title: "")
  }
  
  private func setupButton(title: String) {
    setTitle(title, for: .normal)
    backgroundColor = .label
    setTitleColor(.systemBackground, for: .normal)
    layer.cornerRadius = 8
  }
}
