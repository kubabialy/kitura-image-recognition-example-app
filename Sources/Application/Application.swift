import Foundation
import Kitura
import LoggerAPI
import Configuration
import CloudEnvironment
import KituraContracts
import Health
import KituraStencil
import CoreML

public let projectPath = ConfigurationManager.BasePath.project.path
public let health = Health()

public class App {
    let router = Router()
    let cloudEnv = CloudEnv()

    public init() throws {
        // Run the metrics initializer
        initializeMetrics(router: router)
    }

    func postInit() throws {
        // Endpoints
        initializeHealthRoutes(app: self)
        router.add(templateEngine: StencilTemplateEngine())
        router.get("/form") { request, response, next in
            try response.render("Form.stencil", context: ["var": 1])
            next()
        }
        router.post("/", middleware: BodyParser())

        router.post("/upload") { request, response, next in
            if let value = request.body {
                if case .multipart(_) = value {
                    print(value.asMultiPart?.debugDescription as Any) // This gives us debug data for uploaded images
                    response.send(json: ["guess" : "Any"]) // this is just a mock for future responses
                } else {
                    throw response.error!
                }
            }
            next()
        }
    }

    public func run() throws {
        try postInit()
        Kitura.addHTTPServer(onPort: cloudEnv.port, with: router)
        Kitura.run()
    }
}
