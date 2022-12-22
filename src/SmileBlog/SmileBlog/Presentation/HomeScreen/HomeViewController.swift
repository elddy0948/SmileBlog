import UIKit

final class HomeViewController: UIViewController {
  private let homeTableView = UITableView()
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
}

extension HomeViewController {
  private func setupViews() {
    view.backgroundColor = .systemBackground
    homeTableView.backgroundColor = .systemBackground
    
    homeTableView.register(
      HomeTableViewCell.self,
      forCellReuseIdentifier: HomeTableViewCell.reuseIdentifier)
    
    homeTableView.delegate = self
    homeTableView.dataSource = self
  }
  
  private func layout() {
    view.addSubview(homeTableView)
    homeTableView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      homeTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      homeTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      homeTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      homeTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
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
    return cell
  }
}

extension HomeViewController: UITableViewDelegate {
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
