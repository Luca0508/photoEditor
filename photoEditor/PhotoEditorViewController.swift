//
//  PhotoEditorViewController.swift
//  photoEditor
//
//  Created by 蕭鈺蒖 on 2022/1/10.
//

import UIKit
import AVFoundation

class PhotoEditorViewController: UIViewController {
    var chosenPhoto : UIImage!

    @IBOutlet weak var photoView: UIView!
    @IBOutlet weak var rotateView: UIView!
    @IBOutlet weak var mirrorView: UIView!
    @IBOutlet weak var resizeView: UIView!
    
    @IBOutlet var editButtons: [UIButton]!
    
    @IBOutlet weak var photoScrollView: UIScrollView!
    @IBOutlet weak var photoImageView: UIImageView!
    
    @IBOutlet weak var sizeSegmentedControl: UISegmentedControl!
    
    var rotateTimes = 0
    var mirrorVariable = 1
    var zoomVariable = 1.0
    
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sizeSegmentedControl.isHidden = true
        photoImageView.image = chosenPhoto
        
        
        photoScrollView.contentSize = photoImageView.frame.size
        photoScrollView.delegate = self
        updateScrollView()
        
    }
    
    func updateScrollView(){
        
        let widthScale = photoView.bounds.width / photoImageView.image!.size.width
        let heightScale = photoView.bounds.height / photoImageView.image!.size.height
        let scale = min(widthScale, heightScale)
        photoScrollView.minimumZoomScale = scale
        photoScrollView.zoomScale = scale
        
    }
    
    
    
    @IBAction func pressEditButtons(_ sender: UIButton) {
        sizeSegmentedControl.isHidden = true
        
        switch sender.tag{
        
        // rotate
        case 0:
            rotateTimes += 1
            rotateView.transform = CGAffineTransform(rotationAngle: CGFloat.pi/180*90 * CGFloat(rotateTimes))
        
        // mirror
        case 1:
            mirrorVariable *= -1
            mirrorView.transform = CGAffineTransform(scaleX: CGFloat(mirrorVariable), y: 1)
            
        // resize
        case 2:
            sizeSegmentedControl.isHidden = false
            
        // save photo
        case 3:
            let renderer = UIGraphicsImageRenderer(size: photoView.bounds.size)
            
            let image = renderer.image(actions: {(context) in
                photoView.drawHierarchy(in: photoView.bounds, afterScreenUpdates: true)
            })
            
            let actViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
            present(actViewController, animated: true, completion: nil)
            
        default:
            break
        }
        
    }
    

    @IBAction func pressResizeOption(_ sender: Any) {
        
        let origWidth = resizeView.bounds.width
        let origHeight = resizeView.bounds.height
        var newWidth :CGFloat = 0.0
        var newHeight : CGFloat = 0.0
        
        
        switch sizeSegmentedControl.selectedSegmentIndex{
        case 0 :
            newWidth = origWidth
            newHeight = origHeight
            print("original")
        case 1 :
            newWidth = origWidth/2.0
            newHeight = origHeight
            
            print("origwidth: \(origWidth)  origheight: \(origHeight)")
            
        case 2 :
            newWidth = origWidth
            newHeight = origWidth / 4.0 * 3.0
            print("width: \(newWidth)  height: \(newHeight)")
            
        case 3:
            newWidth = origWidth
            newHeight = origWidth / 16.0 * 9.0
            
        default:
            break
        }
        
        photoScrollView.frame.size = CGSize(width: newWidth, height: newHeight)
        photoScrollView.center = CGPoint(x: origWidth/2, y: origHeight/2)
        
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
extension PhotoEditorViewController : UIScrollViewDelegate{
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        photoImageView
    }

}
