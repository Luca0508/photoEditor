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
    
    @IBAction func pressChoosePhotoButton(_ sender: UIButton) {
        let controller = UIImagePickerController()
        controller.delegate = self
        controller.sourceType = .photoLibrary
        present(controller, animated: true, completion: nil)
        
      
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        photoImageView.image = info[.originalImage] as? UIImage
        dismiss(animated: true, completion: nil)
    }
    
    func imageEmptyAlert(){
        let controller = UIAlertController(title: "Warning !!!", message: "您還沒選照片呢！！", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "知道啦～～", style: .default, handler: nil)
        controller.addAction(okAction)
        present(controller, animated: true, completion: nil)
    }
    
    @IBAction func pressEditPhotoButton(_ sender: Any) {
        if photoImageView.image != nil {
            performSegue(withIdentifier: "showPhotoEditor", sender: nil)
        }else {
            imageEmptyAlert()
        }
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
