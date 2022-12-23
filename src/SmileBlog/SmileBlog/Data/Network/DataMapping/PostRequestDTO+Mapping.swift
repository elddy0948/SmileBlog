import Foundation

struct PostRequestDTO: Encodable {
  let title: String
  let body: String
  let writer: String
  let userID: UUID?
}
