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
    imageView.contentMode = .scaleAspectFill
    return imageView
  }()
  
  private let usernameTextField = SBTextField(placeholder: "Please enter username")
  private let warningLabel = UILabel()
  private let enterButton = SBButton(title: "Enter!")
  
  private let repository = NetworkUsersRepository()
  private lazy var usecase: DefaultUsersUseCase = {
    let usecase = DefaultUsersUseCase(usersRepository: repository)
    return usecase
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
    layout()
  }
}

//MARK: - Setup Views
extension MainViewController {
  private func setupViews() {
    warningLabel.textColor = .systemRed
    warningLabel.textAlignment = .center
    warningLabel.text = ""
    enterButton.addTarget(self, action: #selector(didTappedEnterButton(_:)), for: .touchUpInside)
  }
  
  private func layout() {
    mainStackView.translatesAutoresizingMaskIntoConstraints = false
    
    view.addSubview(mainStackView)
    
    usernameTextField.translatesAutoresizingMaskIntoConstraints = false
    usernameTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
    enterButton.translatesAutoresizingMaskIntoConstraints = false
    enterButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    
    mainStackView.addArrangedSubview(logoImageView)
    mainStackView.addArrangedSubview(usernameTextField)
    mainStackView.addArrangedSubview(warningLabel)
    mainStackView.addArrangedSubview(enterButton)
    
    NSLayoutConstraint.activate([
      mainStackView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
      mainStackView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
    ])
  }
}

extension MainViewController {
  @objc func didTappedEnterButton(_ sender: UIButton) {
    if usernameTextField.text == "" || usernameTextField.text == nil {
      warningLabel.text = "Type username!"
    } else {
      warningLabel.text = ""
      guard let username = usernameTextField.text else { return }
      usecase.searchUser(username: username, completion: { [weak self] result in
        switch result {
        case .success(let user):
          self?.enterHome(with: user)
        case .failure(_):
          self?.createUser(with: username)
        }
      })
    }
  }
  
  private func createUser(with username: String) {
    let userToCreate = User(id: nil, username: username)
    usecase.create(
      user: userToCreate,
      completion: { [weak self] result in
        switch result {
        case .success(let user):
          self?.enterHome(with: user)
        case .failure(_):
          DispatchQueue.main.async { [weak self] in
            self?.warningLabel.text = "생성에 실패 했습니다!"
          }
        }
      })
  }
  
  private func enterHome(with user: User) {
    DispatchQueue.main.async { [weak self] in
      self?.view.window?.rootViewController = HomeTabBarController(user: user)
    }
  }
}
