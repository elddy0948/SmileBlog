import UIKit

final class HomeTabBarController: UITabBarController {
  
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
    setupTabBar()
    setupViewControllers()
  }
  
  private func setupTabBar() {
    tabBar.barTintColor = .systemBackground
    tabBar.tintColor = .label
    tabBar.unselectedItemTintColor = .secondaryLabel
  }
  
  private func setupViewControllers() {
    guard let user = user else { return }
    let homeVC = HomeViewController(user: user)
    let homeNavigationController = UINavigationController(rootViewController: homeVC)
    homeNavigationController.tabBarItem.title = "Home"
    homeNavigationController.tabBarItem.image = UIImage(systemName: "house")
    
    let mypageViewController = MyPageViewController()
    mypageViewController.tabBarItem.title = "MyPage"
    mypageViewController.tabBarItem.image = UIImage(systemName: "person")
    
    viewControllers = [
      homeNavigationController,
      mypageViewController
    ]
  }
}
