//
//  AppRoutes.swift
//  Application
//
//  Created by Kuba Bialy on 24/02/2019.
//

import LoggerAPI
import KituraContracts

func initializeAppRoutes(app: App) -> Void {
    app.router.get("/form") { (request, response, next) in
        try response.render("Form.stencil", context: ["test": "foo"])
        next()
    }
}
