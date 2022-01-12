//
//  photoViewController.swift
//  photoEditor
//
//  Created by 蕭鈺蒖 on 2022/1/5.
//

import UIKit


class photoViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    @IBOutlet weak var photoImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBSegueAction func showPhotoEditorViewController(_ coder: NSCoder) -> PhotoEditorViewController? {
        let controller =  PhotoEditorViewController(coder: coder)
        controller?.chosenPhoto = photoImageView.image
        return controller
    }
    
    struct source{
        var title :String
        var sourceType :UIImagePickerController.SourceType
    }
    
    @IBAction func pressChoosePhotoButton(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Select Photo", message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        let sources = [
            source(title: "Album", sourceType: .photoLibrary),
            source(title: "Camera", sourceType: .camera)
        ]
        for s in sources{
            let action = UIAlertAction(title: s.title, style: .default){_ in
                self.selectPhoto(sourceType: s.sourceType)
            }
            alertController.addAction(action)
        }
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    func selectPhoto(sourceType :UIImagePickerController.SourceType){
        let controller = UIImagePickerController()
        controller.delegate = self
        controller.sourceType = sourceType
        present(controller, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        photoImageView.image = info[.originalImage] as? UIImage
        
        if photoImageView.image != nil {
            performSegue(withIdentifier: "showPhotoEditor", sender: nil)
        }
        dismiss(animated: true, completion: nil)
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
