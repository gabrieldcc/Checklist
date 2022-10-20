//
//  SceneDelegate.swift
//  Checklists
//
//  Created by Gabriel de Castro Chaves on 23/08/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    let dataModel = DataModel()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        let navigationController = window?.rootViewController as! UINavigationController
        let controller = navigationController.viewControllers.first as! AllListsViewController
        controller.dataModel = dataModel
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        saveData()
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        saveData()
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
    
    //MARK: - Helper Methods
    private func saveData() {
        dataModel.saveChecklists()
    }

}

