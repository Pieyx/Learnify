import Vapor
import Fluent
import FluentPostgresDriver

// configures your application
public func configure(_ app: Application) async throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    //PostgresSQL Config
    app.databases.use(.postgres(configuration: SQLPostgresConfiguration(hostname: "localhost", username: "postgres", password: "", database: "learnifydb",tls: .prefer(try .init(configuration: .clientDefault)))), as: .psql)
    
    //register migrations
    app.migrations.add(createCourse())
    app.migrations.add(createLearner())
    app.migrations.add(createLearnerEnrollment())

    // register routes
    try app.register(collection: learnersController())
    try app.register(collection: coursesController())
    try app.register(collection: learnerEnrollmentsController())
    try routes(app)
}
