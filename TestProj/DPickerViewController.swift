import UIKit

var DfilterImage = UIImageView()
let screenSize: CGRect = UIScreen.main.bounds

class DPickerViewController: UIViewController,   UIImagePickerControllerDelegate,UIPopoverControllerDelegate,UINavigationControllerDelegate {
 
    var lastPoint : CGPoint = CGPoint.zero
    var isSwipe : Bool = false
    var red : CGFloat = 0.0
    var green : CGFloat = 0.0
    var blue : CGFloat = 0.0
    let screenWidth = screenSize.width
    var picker:UIImagePickerController?=UIImagePickerController()
    let modelName = UIDevice.current.modelName
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker?.delegate=self
    }
    
    override var prefersStatusBarHidden: Bool {
        get {
            return true
        }
    }
    
    @IBAction func galleryButtonAction(_ sender: UIButton) {
        openGallary()
    }

    func openGallary()
    {
        picker!.allowsEditing = false
        picker!.sourceType = UIImagePickerControllerSourceType.photoLibrary
        present(picker!, animated: true, completion: nil)
    }
    
    @IBAction func cameraButtonAction(_ sender: Any) {
        openCamera()
    }

    func openCamera() {
        picker!.allowsEditing = false
        picker!.sourceType = UIImagePickerControllerSourceType.camera
        present(picker!, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if picker.sourceType == .camera {
            let cameraImageis = info[UIImagePickerControllerOriginalImage] as? UIImage
            DfilterImage.image = resizeImage(image: cameraImageis!, newWidth: screenWidth)
        }
        else {
            DfilterImage.image = info[UIImagePickerControllerOriginalImage] as? UIImage
            DfilterImage.image = resizeImage(image: DfilterImage.image!, newWidth: screenWidth)
        }
        picker.dismiss(animated: true, completion: nil)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "BlurViewController")
        self.present(controller, animated: true, completion: nil)
     }
    
    func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage {
        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
  
}
