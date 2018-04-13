//
//  TestViewController.swift
//  SwiftBaseProject
//
//  Created by Huy Lam on 4/13/18.
//  Copyright © 2018 Huy Lam. All rights reserved.
//

import UIKit

class TestViewController: BaseViewController {
    let clientRequest = APIClient.shared.makeAPIRequest()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func callApi(_ sender: Any) {
        let requestModel = TaskListRequestModel(pageSize: 10, pageIndex: 10)
        TaskService(request: clientRequest).fetchTask(with: requestModel) { (result) in
            print(result)
        }
    }
    
    @IBAction func presented(_ sender: Any) {
        let vc = TestViewController.instance()
        present(vc, animated: true, completion: nil)
    }
}
