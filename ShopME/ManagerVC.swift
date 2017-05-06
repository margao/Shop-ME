//
//  ManagerVC.swift
//  ShopME
//
//  Created by Matt Argao on 3/2/17.
//  Copyright © 2017 Matt Argao. All rights reserved.
//

import UIKit

class ManagerVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var addButton: UIBarButtonItem!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productName: UITextField!
    @IBOutlet weak var productDescLabel: UILabel!
    @IBOutlet weak var productDesc: UITextField!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productPrice: UITextField!
    @IBOutlet weak var addPictureButton: UIButton!
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var categoryField: UITextField!
    @IBOutlet weak var categoryNameLabel: UILabel!
    @IBOutlet weak var categoryNameField: UITextField!
    
    let picker = UIImagePickerController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        categoryNameLabel.isHidden = true
        categoryNameField.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func indexChanged(_ sender: Any) {
        
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            productNameLabel.isHidden = false
            productName.isHidden = false
            productDescLabel.isHidden = false
            productDesc.isHidden = false
            productPriceLabel.isHidden = false
            productPrice.isHidden = false
            categoryLabel.isHidden = false
            categoryField.isHidden = false
            
            categoryNameLabel.isHidden = true
            categoryNameField.isHidden = true
        case 1:
            productNameLabel.isHidden = true
            productName.isHidden = true
            productDescLabel.isHidden = true
            productDesc.isHidden = true
            productPriceLabel.isHidden = true
            productPrice.isHidden = true
            categoryLabel.isHidden = true
            categoryField.isHidden = true
            
            categoryNameLabel.isHidden = false
            categoryNameField.isHidden = false
        default:
            break
        }
        
    }
    
    
    @IBAction func addData(_ sender: Any) {
        if segmentedControl.selectedSegmentIndex == 0 {
            let data = product(label: productName.text, image: addPictureButton.currentImage, price: Double(productPrice.text!), detail: productDesc.text)
            
            let category = categoryField.text
            
            var indexToInsertAt: Int?
            
            
            for i in 0..<sections.count {
                print(sections[i])
                if sections[i] == category {
                    indexToInsertAt = i
                    catalogue[indexToInsertAt!-2].append(data)
                    let alertController = UIAlertController(title: "Success!", message: "Item added to catalogue.", preferredStyle: .alert)
                    
                    let actionCancel = UIAlertAction(title: "Cancel", style: .default) { (action:UIAlertAction) in
                        print("Cancelled.");
                    }
                    
                    alertController.addAction(actionCancel)
                    self.present(alertController, animated:true, completion:nil)
                    break
                }
            }
            
            if indexToInsertAt == nil {
                let alertController = UIAlertController(title: "Error!", message: "Category not found.", preferredStyle: .alert)
                
                let actionCancel = UIAlertAction(title: "Cancel", style: .default) { (action:UIAlertAction) in
                    print("Cancelled.");
                }
                
                alertController.addAction(actionCancel)
                self.present(alertController, animated:true, completion:nil)
            }
        } else {
            let data = category(label: categoryNameField.text, buttonImage: addPictureButton.currentImage)
            categoryArray.append(data)
            sections.append(categoryNameField.text!)
            
            let alertController = UIAlertController(title: "Success!", message: "Item added to catalogue.", preferredStyle: .alert)
            
            let actionCancel = UIAlertAction(title: "Cancel", style: .default) { (action:UIAlertAction) in
                print("Cancelled.");
            }
            
            alertController.addAction(actionCancel)
            self.present(alertController, animated:true, completion:nil)
        }


        
    }
    
    @IBAction func addPicture(_ sender: Any) {
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        present(picker, animated: true, completion: nil)
    }
    
    //MARK: - Delegates
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        addPictureButton.imageView?.contentMode = .scaleAspectFit
        addPictureButton.setImage(chosenImage, for: .normal)
        dismiss(animated:true, completion: nil)
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    

}
