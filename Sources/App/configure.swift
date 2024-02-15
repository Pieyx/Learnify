import Vapor

// configures your application
public func configure(_ app: Application) async throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    // register routes
    
    try app.register(collection: learnersController())
    try app.register(collection: coursesController())
    try app.register(collection: learnerEnrollmentsController())
    try routes(app)
}
