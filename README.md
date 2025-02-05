### Summary: Include screen shots or a video of your app highlighting its features
This is RecipeVous, an app that allows you to view a list of dishes. A user can swipe down to refresh the latest recipe info, and then tap on each recipe to reveal more info about it, including watching a youtube tutorial for how to make the meal!


Recipe iOS project that retrieves recipes via HTTP requests

### Focus Areas: What specific areas of the project did you prioritize? Why did you choose to focus on these areas?
I focused on solid caching to ensure that results from the api were only loaded once. This took a bit more work for images since I did not use AsyncImage. Documentation seems to indicate that it caches images, but the network monitor in Xcode indicated network calls every time I loaded an image.

### Time Spent: Approximately how long did you spend working on this project? How did you allocate your time?
Spent roughly 12 hours. 5 Hours was for the primary functioning of the app, 5 hours was for the unit testing and refactoring the unit tests indicated needed to happen. The last 2 hours were for adding some minor ui touch ups, and adding youtube frames to the recipe detail pages, and tracking down memory errors that were crashing the app.

### Trade-offs and Decisions: Did you make any significant trade-offs in your approach?
1. I chose to spend more time on the project to have a solid basic set of features and a solid base of unit tests. I know this puts my time spend beyond what is recommended by the attached flyer, but I wanted to show that I was capable of fulfilling the prompt.

2. I added a lot of structure to the code. This is a relatively simple app that could easily be done with half the code files. The structure reduces coupling and provides clarity on each code file's purpose.

3. I did not add UI tests. I don't feel that was necessary for this project brief, and so I didn't feel the additional time would be worth it.

4. UI is fairly basic. I determined functionality and performance were weightier.

5. I incorporated UIKit UIImages into the SwiftUI interface, so I didn't implement this 100% without UIKit, but I felt that UIImage provided better performance for asyncronous image data.

### Weakest Part of the Project: What do you think is the weakest part of your project?
The UI isn't beautiful. It's not very gripping to keep me in the app, although it is functional.

### Additional Information: Is there anything else we should know? Feel free to share any insights or constraints you encountered.
