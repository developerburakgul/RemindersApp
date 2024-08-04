<h1 align="left">
    RemindersApp
</h1> 

### Overview

- This project is a simple four-paged Reminders App similar to Apple's native Reminder app.
- This project was made with Swift and UIKit.
- This project is written according to the MVVM architecture.
- In this project, closure is preferred as DataBinding.
- In this project, SnapKit is used to programmatically create a user interface without Storyboard or xib files
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

<div>
    <h2 align=left> Screen Shots </h2>
</div>

<div align="center">
  <table>
    <tr>
      <td><img width=2000  src="https://github.com/developerburakgul/RemindersApp/blob/main/RemindersAppSS/1.png"></td>
      <td><img width=2000 src="https://github.com/developerburakgul/RemindersApp/blob/main/RemindersAppSS/2.png"></td>
      <td><img width=2000 src="https://github.com/developerburakgul/RemindersApp/blob/main/RemindersAppSS/3.png"></td>
      <td><img width=2000 src="https://github.com/developerburakgul/RemindersApp/blob/main/RemindersAppSS/4.png"></td>
      <td><img width=2000 src="https://github.com/developerburakgul/RemindersApp/blob/main/RemindersAppSS/5.png"></td>     
      <td><img width=2000 src="https://github.com/developerburakgul/RemindersApp/blob/main/RemindersAppSS/6.png"></td>     
      <td><img width=2000 src="https://github.com/developerburakgul/RemindersApp/blob/main/RemindersAppSS/7.png"></td>    
    </tr>
    <tr>
      <td><img width=2000 src="https://github.com/developerburakgul/RemindersApp/blob/main/RemindersAppSS/8.png"></td>
      <td><img width=2000 src="https://github.com/developerburakgul/RemindersApp/blob/main/RemindersAppSS/9.png"></td>
      <td><img width=2000 src="https://github.com/developerburakgul/RemindersApp/blob/main/RemindersAppSS/10.png"></td>
      <td><img width=2000 src="https://github.com/developerburakgul/RemindersApp/blob/main/RemindersAppSS/11.png"></td>
      <td><img width=2000 src="https://github.com/developerburakgul/RemindersApp/blob/main/RemindersAppSS/12.png"></td>     
      <td><img width=2000 src="https://github.com/developerburakgul/RemindersApp/blob/main/RemindersAppSS/13.png"></td>       
    </tr>
    <tr>     
      <td><img width=2000 src="https://github.com/developerburakgul/RemindersApp/blob/main/RemindersAppSS/14.png"></td>  
      <td><img width=2000 src="https://github.com/developerburakgul/RemindersApp/blob/main/RemindersAppSS/15.png"></td>       
    </tr>
  </table>
</div>

## İdea
Thanks for idea https://github.com/meyusufdemirci .
