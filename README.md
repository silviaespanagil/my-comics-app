# iOS App: My Comics
## _Swift exercise_

¡Hola mundo!

In my Swift learning journey my mentor and I decided to do an app using the [Comic Vine API](https://comicvine.gamespot.com/api/). This API gives a lot of information about comic characters so we decided to do a search app where you can look for any character and add it into a favorite list ⭐️ 

<img src="https://user-images.githubusercontent.com/81619759/139837535-24345d60-683b-4d5f-8b1d-2e6a9b533098.png" alt="App view after you do a search on the search bar" width="300"/> <img src="https://user-images.githubusercontent.com/81619759/139842872-a5e09af0-a951-4196-8708-e22dd71ca87e.png" alt="Character detail, after you click on a character. Shows all the api information: photo, gender, description, powers and also renders a heart to make it favorite" width="300"/> <img src="https://user-images.githubusercontent.com/81619759/139843122-10e56f78-c65a-48e6-a4ea-379d7a5697ff.png" alt="Favorites view" width="300"/>

https://user-images.githubusercontent.com/81619759/139843522-d2dd2d6b-8de1-4760-b062-8fe920ddb757.mov


## Some Requirements 📋

- Create a Swift App
- App must be feed via API
- Main components must be tested
- Add and render a favorite list
- User must be able to search characters in a search bar
- There must be at least one filter other than the search

## Extra features 🌟

- Allow users to erase the search input
- Add a tab bar

## Built with 🔨
- XCode
- SwiftUI
- Combine
- CoreData

## Development ⌨️

This has been a team work between my mentor and I, as the app was and is part of my Swift learning path 📱. So we started managing the API for so he used and explain to me some of the Combine functionalities. With the API communication working properly we started shaping all the views that are stored in the "Scenes" and "View" folders.

Here is important to tell that, as a good practice, our view's structs do not have any logic in them, for so we have worked with the View Models. This way the view's structs are as clean and possible and they do one thing: to render. And the View Models are the brain 🧠 behind, sending in all the possible information, or logic needed to do so correctly. 

The view can be separated in five main components:

#### 🦹🏽‍♀️🦸 **Character List** 🦹🏽‍♀️🦸🏻‍♂️ 

This view shows the image and name of the character searched. This is the most basic view and is the only one that has no viewModel attached to it.

<img width="277" alt="App screenshot of Mafalda showing the character list view" src="https://user-images.githubusercontent.com/81619759/139847186-05eaebb4-2e93-4d16-a683-0a3b787df661.png">

#### 👁 **Character Detail** 👁 

As is name say, is the detailed view. When the user click on a character, this view will be rendered showing more information of it. In this view the user will also find a heart, clicking on it will "favorite" the character. This action will allow the user to later find, all its favorites characters in the "Favorite" tab.

#### 🔎 **Search bar** 🔎

This is our main view as the search action is necessary in order to call the API and show the user the information. This view comes with three main components:
    - The TextField() itself that will take the user input that we will search in the API to later render it in the Character's components.
    - The delete search icon, an icon that will be shown after the user starts writing and that allows it to delete the input
    - The Picker that allows the user to filter the characters by gender. This filter will only be available after the user has done a search and results are rendered

#### ❤️ **Favorites** ❤️ 

This is the favorites view. Any character that has been favorited by the user will be shown here

#### ❤️ **Tab Bar** ❤️

As a navigation treat we implemented a tab bar that makes it easier to the user to move between the search area and the favorite list. 

<img width="308" alt="Screenshot 2021-11-02 at 13 54 06" src="https://user-images.githubusercontent.com/81619759/139850470-2c9d6a6d-ff99-46b3-a7ff-5e751ab49f2b.png">

As the views where ready we went a little further. My mentor created a Data Base using CoreData. This Data Base saves all the characters that the user favorited in order to later render them in the favorite area. Finally we went into the testing, we decided to test all the main components and functions.

### Some things I really like 💖

❌ **Delete search icon** ❌ 

This is a really small functionality but for the user is a very interesting one. Also I do think that this kind of details really make the app to look and feel really polished. 

The delete search icon is a little icon that will be shown in the search bar as soon as the user starts typing. If clicked before the search it will erase whatever the user was writting and empty the field. However if clicked after the user has done a search, it will not only erase the text field input it will also clean up the characters area.

https://user-images.githubusercontent.com/81619759/139852536-3c4d91ad-a50d-4abd-b0c4-e066cae98479.mov

✅ **Testing** ✅

Prior to this project my experience in doing unitary test has been almost unexistant so this was a rollercoaster 🎢 but I had a lot of fun. For the testing my mentor did 4 components to help me understand a little bit more about unit testing, but also for me to have some guidance on how and what to test. After it I was able to do more than 20 test! I'm still in awe about this.


### My challenges 🚩

I definetly need to keep digging into the testing as I still find it really hard and takes me lots of time. Combine a CoreData are huge challenges, they are SUPER important, and without them the app would just not work. Both the Combine and CoreData implementations were done by my mentor so I would definetly love to practice them on my own in order to be able to develop them by myself. 


## Codefactor 
[![CodeFactor](https://www.codefactor.io/repository/github/silviaespanagil/my-comics-app/badge/main)](https://www.codefactor.io/repository/github/silviaespanagil/my-comics-app/overview/main)
