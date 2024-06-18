# Week 2 Lab
This week, we learned how to use the ElevatedButton, Image, Checkbox, Switch, and TextField.

For this week's lab, demonstrate your understanding of the material (6 marks):

1. Create a login page with two text fields. One is for "Login name" and the one below it for "password". To make the password field not show what is typed, use the parameter: `obscureText: true` in the TextField (2 marks).
   ![image](https://github.com/RyanRen2023/s3mobile/assets/148353217/3d8eee57-31ca-4276-a8e0-a91d231f173b)


3. Add an ElevatedButton below the two TextFields with the word "Login". When the user presses the button, get the string that was typed in the password field (1 mark).

4. Below the Login button, add an Image that is 300 x 300 that originally is a Question Mark (3 marks):
    - ![Question Mark](https://www.flaticon.com/free-icon/question-mark_5726470).
    
   When the user clicks on the login button, read the string that was typed in the password. If the string is "QWERTY123", then change the image source to be a light bulb:
    - ![Light Bulb](https://www.flaticon.com/free-icon/idea_566461?term=light+bulb&page=1&position=23&origin=search&related_id=566461).
    
   If the string is anything other than "QWERTY123", then set the image to a stop sign:
    - ![Stop Sign](https://www.flaticon.com/free-icon/stop_3477145?term=stop+sign&page=1&position=4&origin=search&related_id=3477145).
   
   To do this, replace the source of the image with a string variable that is initialized to the image: `var imageSource = "images/question-mark.jpg";`. Then when the user clicks the button, use `setState()` to set `imageSource` to another string representing a file that you have downloaded onto your computer into the images folder (either stop sign or light bulb).

You should show these items are completed and working during your normal lab period. You don't need to submit anything for now but you will keep working on your code in next week's lab.
