import UIKit

final class MyPageViewController: UIViewController {
  private let myPostTableView = UITableView()
  
  private let user: User?
  
  private let repository = NetworkUsersRepository()
  private lazy var usecase: DefaultUsersUseCase = {
    let usecase = DefaultUsersUseCase(
      usersRepository: repository
    )
    return usecase
  }()
  
  private var posts: [Post] = [] {
    didSet {
      DispatchQueue.main.async { [weak self] in
        self?.myPostTableView.reloadData()
      }
    }
  }
  
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
    navigationController?.navigationBar.prefersLargeTitles = true
    title = "My Posts"
    navigationController?.navigationBar.tintColor = .label
    setupViews()
    layout()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    fetchUserPosts()
  }
  
  private func fetchUserPosts() {
    guard let user = user,
          let userID = user.id else { return }
    
    usecase.fetchUserPosts(
      userID: String(describing: userID),
      completion: { [weak self] result in
        switch result {
        case .success(let posts):
          self?.posts = posts
        case .failure(_):
          return
        }
      })
  }
}

extension MyPageViewController {
  private func setupViews() {
    myPostTableView.backgroundColor = .systemBackground
    myPostTableView.register(
      PostTableViewCell.self,
      forCellReuseIdentifier: PostTableViewCell.reuseIdentifier
    )
    myPostTableView.delegate = self
    myPostTableView.dataSource = self
  }
  
  private func layout() {
    view.addSubview(myPostTableView)
    myPostTableView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      myPostTableView.topAnchor.constraint(
        equalTo: view.safeAreaLayoutGuide.topAnchor),
      myPostTableView.leadingAnchor.constraint(
        equalTo: view.safeAreaLayoutGuide.leadingAnchor),
      myPostTableView.trailingAnchor.constraint(
        equalTo: view.safeAreaLayoutGuide.trailingAnchor),
      myPostTableView.bottomAnchor.constraint(
        equalTo: view.safeAreaLayoutGuide.bottomAnchor),
    ])
  }
}

extension MyPageViewController: UITableViewDataSource {
  func tableView(
    _ tableView: UITableView,
    numberOfRowsInSection section: Int
  ) -> Int {
    return posts.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(
      withIdentifier: PostTableViewCell.reuseIdentifier,
      for: indexPath) as? PostTableViewCell else {
      return UITableViewCell()
    }
    let post = posts[indexPath.row]
    cell.configureCellData(with: post)
    cell.contentView.setNeedsDisplay()
    return cell
  }
}

extension MyPageViewController: UITableViewDelegate {
  func tableView(
    _ tableView: UITableView,
    didSelectRowAt indexPath: IndexPath
  ) {
    let post = posts[indexPath.row]
    let postDetailViewController = PostDetailViewController(
      post: post, type: .editable
    )
    navigationController?.pushViewController(
      postDetailViewController,
      animated: true
    )
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
