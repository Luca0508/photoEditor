//
//  PhotoEditorViewController.swift
//  photoEditor
//
//  Created by 蕭鈺蒖 on 2022/1/10.
//

import UIKit

class PhotoEditorViewController: UIViewController {
    var chosenPhoto : UIImage!

    @IBOutlet weak var photoImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photoImageView.image = chosenPhoto

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
