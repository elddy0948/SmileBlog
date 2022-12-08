import Vapor

func routes(_ app: Application) throws {
  app.get { req async in
    "It works!"
  }
  
  app.get("hello", ":name", use: { req -> String in
    guard let name = req.parameters.get("name") else { throw Abort(.internalServerError) }
    //Comment
    print("Hello World")
    return "Hello \(name)!"
  })
}
