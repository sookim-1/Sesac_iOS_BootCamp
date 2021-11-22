import Fluent
import FluentPostgresDriver
import Vapor

// configures your application
public func configure(_ app: Application) throws {
    if let databaseURL = Environment.get("DATABASE_URL"), var postgresConfig = PostgresConfiguration(url: databaseURL) {
        var clientTLSConfiguration = TLSConfiguration.makeClientConfiguration()
        clientTLSConfiguration.certificateVerification = .none
        postgresConfig.tlsConfiguration = clientTLSConfiguration

        app.databases.use(.postgres(
            configuration: postgresConfig
        ), as: .psql)
    } else {
        print("ge")
    }

    app.migrations.add(CreateAccount())
    app.migrations.add(CreateMail())
    // register routes
    try routes(app)
}
