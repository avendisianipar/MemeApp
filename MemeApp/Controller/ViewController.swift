//
//  ViewController.swift
//  MemeApp
//
//  Created by Avendi Sianipar on 16/04/21.
//  Copyright © 2021 Avendi Sianipar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var albumButton: UIBarButtonItem!
    @IBOutlet weak var toolBar: UIToolbar!
    
    private let memeTextAttributes: [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.strokeColor: UIColor.black,
        NSAttributedString.Key.foregroundColor: UIColor.white,
        NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSAttributedString.Key.strokeWidth: -3.0
    ]
    
    private let LABEL_TOP_TEXT = "TOP TEXT"
    private let LABEL_BOTTOM_TEXT = "BOTTOM TEXT"
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        subscribeNotificationCenter()
        setupTextField(topTextField, labelText: LABEL_TOP_TEXT)
        setupTextField(bottomTextField, labelText: LABEL_BOTTOM_TEXT)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        unsubscribeNotificationCenter()
    }
    
    @IBAction func pickImageFromCameraDidTap(_ sender: Any) {
        showImagePicker(.camera)
    }
    
    @IBAction func pickImageFromAlbumDidTap(_ sender: Any) {
        showImagePicker(.photoLibrary)
    }
    
    @IBAction func shareImage(_ sender: Any) {
        guard let memeImage = generateMemedImage() else {
            return
        }
        
        let activityViewController = UIActivityViewController(activityItems: [memeImage], applicationActivities: nil)
        activityViewController.completionWithItemsHandler = { [weak self] activity, completed, items, error in
            if completed {
                //Save image
                self?.save()
                self?.dismiss(animated: true, completion: nil)
            }
        }
        
        present(activityViewController, animated: true, completion: nil)
    }
    
    @IBAction func cancel(_ sender: Any) {
        imageView.image = nil
        topTextField.text = LABEL_TOP_TEXT
        bottomTextField.text = LABEL_BOTTOM_TEXT
    }
}

private extension ViewController {
    func showImagePicker(_ source: UIImagePickerController.SourceType) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = source
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func subscribeNotificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(_:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeNotificationCenter() {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keyboardWillChange(_ notification:Notification) {
        if bottomTextField.isFirstResponder {
            view.frame.origin.y = 0
            view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }
    
    @objc func keyboardWillHide(_ notification:Notification) {
        if bottomTextField.isFirstResponder {
            view.frame.origin.y = 0
        }
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    
    func generateMemedImage() -> UIImage? {
        //Hide toolbar and navBar
        navBar.isHidden = true
        toolBar.isHidden = true
    
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        //Show toolbar and navBar
        navBar.isHidden = false
        toolBar.isHidden = false
        
        return memedImage
    }
    
    func save() {
        guard let topText = topTextField.text,
            let bottomText = bottomTextField.text,
            let imageView = imageView.image,
            let memedImage = generateMemedImage() else {
                return
        }
        
        let meme = MemeModel(topText: topText,
                             bottomText: bottomText,
                             image: imageView,
                             memedImage: memedImage)
        
        // Add it to the memes array in the Application Delegate
        //let object = UIApplication.shared.delegate
        //save shared image to memes array
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
    }
    
    func setupTextField(_ textField: UITextField, labelText: String) {
        textField.delegate = self
        textField.text = labelText
        textField.defaultTextAttributes = memeTextAttributes
        textField.textAlignment = .center
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerOriginalImage")] as? UIImage {
            imageView.image = image
        }
        dismiss(animated: true, completion: nil)
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if topTextField == textField && topTextField.text == LABEL_TOP_TEXT {
            topTextField.text = ""
        }
        
        if bottomTextField == textField && bottomTextField.text == LABEL_BOTTOM_TEXT {
            bottomTextField.text = ""
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
}
