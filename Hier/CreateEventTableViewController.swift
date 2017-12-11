//
//  CreateEventTableViewController.swift
//  Hier
//
//  Created by Yang Zhao on 8/30/17.
//  Copyright © 2017 P.R.K. All rights reserved.
//

import UIKit
import MapKit

class CreateEventTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    // MAKR: - Constants
    
    private let IconSize: CGFloat = 28
    private let PhotoSize: CGFloat = 100
    private let CellIndent: CGFloat = 16

    // MARK: - Outlets
    
    private var eventTitle: UITextField!
    private var eventDescription: UITextView!
    private var eventPhoto: UIImageView!
    private var eventTime: UITextField!
    private var eventLocation: UIButton!
    private var eventMaxParticipants: UITextField!
    private var submitButton: UIButton!
    private var datePicker: UIDatePicker!
    
    // MARK: - Properties
    
    private var selectedPlacemark: MKPlacemark? {
        didSet {
            validateLocation()
        }
    }
    
    private var selectedDateTime: Date? {
        didSet {
            validateTime()
        }
    }
    
    private var isTitleValid: Bool = false {
        didSet {
            validateEvent()
        }
    }
    
    private var isTimeValid: Bool = false {
        didSet {
            validateEvent()
        }
    }
    
    private var isLocationValid: Bool = false {
        didSet {
            validateEvent()
        }
    }
    
    private var isEventValid: Bool = false {
        didSet {
            if isEventValid {
                enableSubmit()
            } else {
                disableSubmit()
            }
        }
    }
    
    private var cells: [[UITableViewCell]] = [
        [UITableViewCell(), UITableViewCell()],
        [UITableViewCell(), UITableViewCell(), UITableViewCell()],
        [UITableViewCell()]
    ]
    
    // MARK: - Event photo methods

    func choosePhoto(gesture: UITapGestureRecognizer) {
        let actionSheet = UIAlertController(title: "Choose camera or photo library", message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: useCamera))
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: chooseFromPhotoLibrary))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(actionSheet, animated: true, completion: nil)
    }
    
    private func useCamera(action: UIAlertAction) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let picker = UIImagePickerController()
            picker.sourceType = .camera
            picker.cameraCaptureMode = .photo
            picker.modalPresentationStyle = .fullScreen
            picker.delegate = self
            picker.allowsEditing = false
            present(picker, animated: true, completion: nil)
        }
    }
    
    private func chooseFromPhotoLibrary(action: UIAlertAction) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let picker = UIImagePickerController()
            picker.sourceType = .photoLibrary
            picker.delegate = self
            picker.allowsEditing = false
            present(picker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        eventPhoto.contentMode = .scaleAspectFill
        eventPhoto.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Event time methods
    
    func chooseTime() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        eventTime.text = dateFormatter.string(from: datePicker.date)
        selectedDateTime = datePicker.date
        dismissDatePicker()
    }
    
    func dismissDatePicker() {
        view.endEditing(true)
    }
    
    // MARK: - UITextFieldDelegate methods
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let length = textField.text!.characters.count + (string.characters.count - range.length)
        switch textField {
        case eventTitle:
            return length <= 100
        case eventMaxParticipants:
            return length <= 3
        default:
            return true
        }
    }
    
    // MARK: - View controller lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set navigation bar
        title = "Create Event"
        navigationController?.navigationBar.titleTextAttributes = [
            NSFontAttributeName: Constants.NavigationTitleFont,
            NSForegroundColorAttributeName: Constants.ThemeColor
        ]
        let cancelBarButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissEvent))
        cancelBarButton.tintColor = Constants.ThemeColor
        navigationItem.leftBarButtonItem  = cancelBarButton
        
        /* Set 1st cell ************************/
        
        // Set event title
        eventTitle = UITextField()
        eventTitle.font = Constants.TitleFont
        eventTitle.placeholder = "Title"
        eventTitle.returnKeyType = .done
        eventTitle.delegate = self
        eventTitle.addTarget(self, action: #selector(validateTitle), for: .editingChanged)
        
        Helpers.layoutSingleOutlet(outlet: eventTitle, cell: cells[0][0], inset: UIEdgeInsetsMake(Constants.DefaultMargin, CellIndent, Constants.DefaultMargin, Constants.DefaultMargin))
        
        /* Set 2nd cell ************************/
        
        // Set event description
        eventDescription = UITextView()
        eventDescription.font = Constants.DefaultTextFont
        eventDescription.textAlignment = .left
        eventDescription.placeholder = "Description (optional)"
        
        // Set event photo
        eventPhoto = UIImageView()
        eventPhoto.layer.cornerRadius = Constants.CornerRadius
        eventPhoto.clipsToBounds = true
        eventPhoto.isUserInteractionEnabled = true
        eventPhoto.image = UIImage(named: Constants.AddPhoto)
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(choosePhoto(gesture:)))
        singleTap.numberOfTapsRequired = 1
        eventPhoto.addGestureRecognizer(singleTap)
        
        let secondCell = cells[0][1]
        secondCell.contentView.addSubview(eventPhoto)
        secondCell.contentView.addSubview(eventDescription)
        eventPhoto.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(PhotoSize)
            make.height.equalTo(PhotoSize)
            make.trailing.equalTo(secondCell.contentView.snp.trailing).offset(-Constants.DefaultMargin)
            make.top.equalTo(secondCell.contentView.snp.top).offset(Constants.DefaultMargin)
        }
        eventDescription.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(secondCell.contentView.snp.leading).offset(CellIndent)
            make.trailing.equalTo(eventPhoto.snp.leading).offset(-Constants.DefaultMargin)
            make.top.equalTo(eventPhoto.snp.top)
            make.bottom.equalTo(eventPhoto.snp.bottom)
        }
        
        /* Set 3rd cell ************************/
        
        // Set date picker
        datePicker = UIDatePicker()
        datePicker.datePickerMode = .dateAndTime
        
        // Set event time
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        toolbar.setItems([
            UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissDatePicker)),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil),
            UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(chooseTime))
            ], animated: false)
        eventTime = UITextField()
        eventTime.borderStyle = .none
        eventTime.font = Constants.DefaultTextFont
        eventTime.inputAccessoryView = toolbar
        eventTime.placeholder = "Pick Time"
        eventTime.inputView = datePicker
        
        Helpers.layoutIconAndField(iconName: Constants.Calendar, iconSize: IconSize, field: eventTime, cell: cells[1][0])
        
        /* Set 4th cell ************************/
        
        // Set event location
        eventLocation = UIButton()
        eventLocation.setTitle("Add Location", for: .normal)
        eventLocation.setTitleColor(Constants.PlaceholderColor, for: .normal)
        eventLocation.titleLabel?.font = Constants.DefaultTextFont
        eventLocation.contentHorizontalAlignment = .left
        eventLocation.addTarget(self, action: #selector(presentEventLocationViewController), for: .touchUpInside)
        
        Helpers.layoutIconAndField(iconName: Constants.Pin, iconSize: IconSize, field: eventLocation, cell: cells[1][1])
        
        /* Set 5th cell ************************/
        
        // Set max #participants
        eventMaxParticipants = UITextField()
        eventMaxParticipants.font = Constants.DefaultTextFont
        eventMaxParticipants.placeholder = "Max #participants"
        eventMaxParticipants.keyboardType = .numberPad
        eventMaxParticipants.delegate = self
        
        // Set 5th cell
        Helpers.layoutIconAndField(iconName: Constants.Group, iconSize: IconSize, field: eventMaxParticipants, cell: cells[1][2])
        
        /* Set 6th cell ************************/
        
        // Set submit button
        submitButton = UIButton()
        submitButton.setTitle("submit", for: .normal)
        submitButton.backgroundColor = Constants.ThemeColor
        submitButton.setTitleColor(UIColor.white, for: .normal)
        submitButton.addTarget(self, action: #selector(submitEvent), for: .touchUpInside)
        disableSubmit()
        
        Helpers.layoutSingleOutlet(outlet: submitButton, cell: cells[2][0], inset: UIEdgeInsetsMake(0, 0, 0, 0))
        
        // Table view config
        for row in cells {
            for cell in row {
                cell.selectionStyle = .none
            }
        }
        tableView.keyboardDismissMode = .onDrag
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return cells.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cells[indexPath.section][indexPath.row]
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                return Constants.DefaultTableViewCellHeight
            case 1:
                return PhotoSize + 2 * Constants.DefaultMargin
            default:
                return 0
            }
        case 1:
            return IconSize + 2 * Constants.DefaultMargin
        case 2:
            return Constants.DefaultTableViewCellHeight
        default:
            return 0
        }
    }
    
    func presentEventLocationViewController() {
        let elvc = EventLocationViewController()
        let nc = UINavigationController(rootViewController: elvc)
        view.endEditing(true)
        elvc.selectedPlacemark = selectedPlacemark
        present(nc, animated: true, completion: nil)
    }
    
    func unwindToCreateEventTableViewController(placemark: MKPlacemark?) {
        selectedPlacemark = placemark
        if selectedPlacemark != nil {
            eventLocation.setTitle(selectedPlacemark?.name, for: .normal)
            eventLocation.setTitleColor(UIColor.black, for: .normal)
        }
    }
    
    private func disableSubmit() {
        submitButton.isEnabled = false
        submitButton.alpha = 0.5

    }
    
    private func enableSubmit() {
        submitButton.isEnabled = true
        submitButton.alpha = 1.0
    }
    
    func dismissEvent() {
        view.endEditing(true)
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    func submitEvent() {
        // TO DO: call API to create event
        dismissEvent()
    }
    
    func validateTitle() {
        isTitleValid = !eventTitle.text!.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    func validateTime() {
        isTimeValid = selectedDateTime != nil
    }
    
    func validateLocation() {
        isLocationValid = selectedPlacemark != nil
    }
    
    private func validateEvent() {
        isEventValid = isTitleValid && isTimeValid && isLocationValid
    }
}


