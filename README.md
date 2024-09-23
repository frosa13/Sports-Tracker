# Sports Tracker

Sports Tracker is your go-to app for staying up to date with all your favorite sports and events. Whether you're tracking a soccer match, a tennis game, or any other sporting event, Sports Tracker provides a seamless and interactive experience, ensuring you never miss a moment.

### Key Features:

* **Live Updates with Real-time Countdown Timers:** Get accurate, live countdowns for upcoming sports events. The countdown dynamically updates, showing you exactly how much time is left until the event starts.
* **Favorite Events:** Love a specific match or competition? Favorite any event, and it will automatically move to the top of your list for easy access.
* **Sport-specific Collapsible Sections:** View a vertical list of sports, each represented by its own unique icon. Expand or collapse sections to explore the events you're interested in. A convenient indicator shows whether the section is open or closed.
* **Horizontal Event Listings:** Each sport section contains a horizontal list of events sorted by their start time. Browse easily through events, with the earliest matches always displayed first.
* **Detailed Event Information:** Get complete details about the participants, whether they’re teams or individual athletes. Know who’s competing and follow your favorite teams or athletes closely.
* **Error Handling and Loading States:** Enjoy a smooth, responsive experience. If the app encounters any issues loading data, you’ll be notified with an error message. While waiting for data to load, a clean loading indicator ensures you're informed that your content is on its way.


### Technical Implementation

Sports Tracker was developed using MVC as an architecture pattern due to its simplicity suited to the app size and complexity. It allows to clearly separate the data handling, UI and logic without unnecessary complexity. 

For networking, the app uses the native URLSession with a custom implementation that can easily be scaled to a larger network layer with multiple requests.

The data is displayed to the user using a vertical list implemented with a UITableView using headers. This allows to easily handle the section collapse and expansion. Each section content was then created using a UICollectionView to easily handle horizontal scroll, cell reuse and updates in the element order caused by the favorite feature.
