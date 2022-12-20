import UIKit

final class MainViewController: UIViewController {
  private lazy var mainStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.distribution = .fill
    stackView.spacing = 8
    return stackView
  }()
  
  private lazy var logoImageView: UIImageView = {
    let image = UIImage(named: "logo")
    let imageView = UIImageView(image: image)
    return imageView
  }()
  
  private let usernameTextField = SBTextField(placeholder: "Please enter username")
  private let enterButton = UIButton(type: .system)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    style()
    layout()
  }
}

//MARK: - Setup Views
extension MainViewController {
  private func style() {
    logoImageView.contentMode = .scaleAspectFill
    enterButton.setTitle("Enter", for: .normal)
    enterButton.backgroundColor = .black
    enterButton.setTitleColor(.white, for: .normal)
    enterButton.layer.cornerRadius = 8
  }
  
  private func layout() {
    mainStackView.translatesAutoresizingMaskIntoConstraints = false
    
    view.addSubview(mainStackView)
    
    usernameTextField.translatesAutoresizingMaskIntoConstraints = false
    usernameTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
    
    mainStackView.addArrangedSubview(logoImageView)
    mainStackView.addArrangedSubview(usernameTextField)
    mainStackView.addArrangedSubview(enterButton)
    
    NSLayoutConstraint.activate([
      mainStackView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
      mainStackView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
    ])
  }
}
