import UIKit

final class HomeViewController: UIViewController {
  private let homeTableView = UITableView()
  private let addButton = UIButton()
  
  private let user: User?
  private var posts: [Post]  = [] {
    didSet {
      DispatchQueue.main.async { [weak self] in
        self?.homeTableView.reloadData()
      }
    }
  }
  
  private let postsRepository = NetworkPostsRepository()
  private lazy var postsUsecase: DefaultPostsUseCase = {
    let usecase = DefaultPostsUseCase(postsRepository: postsRepository)
    return usecase
  }()
  
  init(user: User) {
    self.user = user
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
    layout()
    fetchPosts()
  }
  
  private func fetchPosts() {
    postsUsecase.fetchPosts(completion: { result in
      switch result {
      case .success(let posts):
        self.posts = posts
      case .failure(_):
        return
      }
    })
  }
  
  @objc func addButtonTapped(_ sender: UIButton) {
    let createPostViewController = CreatePostViewController()
    self.present(createPostViewController, animated: true)
  }
}

extension HomeViewController {
  private func setupViews() {
    view.backgroundColor = .systemBackground
    navigationController?.navigationBar.prefersLargeTitles = true
    title = "Home"
    
    homeTableView.backgroundColor = .systemBackground
    
    homeTableView.register(
      HomeTableViewCell.self,
      forCellReuseIdentifier: HomeTableViewCell.reuseIdentifier)
    
    homeTableView.delegate = self
    homeTableView.dataSource = self
    
    addButton.tintColor = .label
    addButton.backgroundColor = .systemGreen
    addButton.layer.cornerRadius = 20
    addButton.layer.masksToBounds = true
    addButton.setTitle("+", for: .normal)
    addButton.addTarget(
      self, action: #selector(addButtonTapped(_:)),
      for: .touchUpInside)
  }
  
  private func layout() {
    view.addSubview(homeTableView)
    view.addSubview(addButton)
    
    homeTableView.translatesAutoresizingMaskIntoConstraints = false
    addButton.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      homeTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      homeTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      homeTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      homeTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
      addButton.heightAnchor.constraint(equalToConstant: 40),
      addButton.widthAnchor.constraint(equalToConstant: 40),
      view.safeAreaLayoutGuide.trailingAnchor.constraint(
        equalToSystemSpacingAfter: addButton.trailingAnchor,
        multiplier: 1),
      view.safeAreaLayoutGuide.bottomAnchor.constraint(
        equalToSystemSpacingBelow: addButton.bottomAnchor,
        multiplier: 2),
    ])
  }
}

extension HomeViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return posts.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(
      withIdentifier: HomeTableViewCell.reuseIdentifier, for: indexPath
    ) as? HomeTableViewCell else {
      return UITableViewCell()
    }
    let post = posts[indexPath.row]
    cell.configureCellData(with: post)
    cell.contentView.setNeedsDisplay()
    return cell
  }
}

extension HomeViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let post = posts[indexPath.row]
    let postDetailViewController = PostDetailViewController()
    postDetailViewController.configurePost(post)
    navigationController?.pushViewController(postDetailViewController, animated: true)
  }
  
  func tableView(
    _ tableView: UITableView,
    heightForRowAt indexPath: IndexPath
  ) -> CGFloat {
    return UITableView.automaticDimension
  }
  
  func tableView(
    _ tableView: UITableView,
    estimatedHeightForRowAt indexPath: IndexPath
  ) -> CGFloat {
    return 80
  }
}
