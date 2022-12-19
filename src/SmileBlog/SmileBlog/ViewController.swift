import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    
//    NetworkService.fetchUser(
//      with: "17C2E115-4750-46C5-BA4B-0AEFE755B993", completion: { result in
//        switch result {
//        case .success(let user):
//          print(user.toDomain().id)
//        case .failure(let error):
//          print(error)
//        }
//      })
    
    NetworkService.fetchPost(with: "68781A7C-9154-4A69-BD2A-BA26E8D49F5D", completion: { result in
      switch result {
      case .success(let post):
        print(post.toDomain().id)
      case .failure(let error):
        print(error)
      }
    })
  }
}

