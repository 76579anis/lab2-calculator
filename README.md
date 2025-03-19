# lab2_calculator

A new Flutter project.



This Flutter-based calculator app enables users to perform basic arithmetic operations such as addition, subtraction, multiplication, and division. It features a simple and user-friendly interface while ensuring error handling, particularly for division by zero. The app also utilizes shared_preferences to store the last calculated result, allowing users to retrieve it upon reopening the application. Additionally, it supports up to 8-digit input, ensuring precision in calculations.
**shared_prefs_service.dart** 

Manages saving and retrieving the last result.
Uses the shared_preferences package to persist data.
**pubspec.yaml** (Ensure Dependency is Added)

**Purpose of main.dart**
Initializes the application

Contains the main() function, which launches the app.
Defines the root widget

Uses MaterialApp to set up the main structure.
Specifies the home screen (CalculatorScreen).
Manages global app settings

Title of the app (Calculator).
Removes the debug banner (debugShowCheckedModeBanner: false).
![screenshot description](assets/cal.png)
