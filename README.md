<h1 align="left">
    RemindersApp
</h1> 

### Overview

- Simple four-paged Reminders App similar to Apple's native Reminder app.
- Made with Swift and UIKit.
- Written according to the MVVM architecture.
- Closure is preferred as DataBinding.
- SnapKit is used to programmatically create a user interface without Storyboard or xib files
- Data is stored locally using UserDefaults, and the Reminder items are managed using Codable.
- There are 4 screens in the project:
  - 1- List Screen
    - Shows Reminders
    - Has a + button to go to Create Screen 
  - 2- Create Screen
    - Inherits from Base Reminder Screen
    - Has 2 [Custom Text View](https://github.com/developerburakgul/RemindersApp/blob/main/RemindersApp/UI/CustomViews/CustomReusableViews/PlaceHolderTextView/PlaceHolderTextView.swift). for the title and description of the Reminder
    - Has 2 Date picker for the Date and Time for Reminder
    - Has cancel and done button for save or cancel Reminder
  - 3- Edit Screen
    - Inherits from Base Reminder Screen
    - Has 2 [Custom Text View](https://github.com/developerburakgul/RemindersApp/blob/main/RemindersApp/UI/CustomViews/CustomReusableViews/PlaceHolderTextView/PlaceHolderTextView.swift). for edit the title and description of the Reminder
    - Has 2 Date picker for edit the Date and Time for Reminder
    - Has cancel and save button for save or cancel Reminder
  - 4- Detail Screen
    - Inherits from Base Reminder Screen
    - Has 2 [Custom Text View](https://github.com/developerburakgul/RemindersApp/blob/main/RemindersApp/UI/CustomViews/CustomReusableViews/PlaceHolderTextView/PlaceHolderTextView.swift). for show the title and description of the Reminder
    - Has 2 Date picker for show the Date and Time for Reminder
    - Has cancel button for dismiss Reminder

<br>


## İdea
Thanks for the idea https://github.com/meyusufdemirci .
