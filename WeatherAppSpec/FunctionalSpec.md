## Weather App

### Overview 

Weather App for iOS is a native application that presents the user with weather data provided from the [OpenWeatherMap API](http://openweathermap.org/API). With the application the user should be able to view the current temperature for their location and view a 5-day forecast.

**Requirements**

- iOS 7+

** Application-Wide Design Stories **

- Application Colors
  - $gray-darkest: #232323

- Application Text Styles
  - Default Font: Avenir-Book
  - Sizes defined in weatherapp.redlines.png

### Functional Specifcation

#### Main Screen

The main screen is the user's only interface to the app. It display the temperature for the user's current location and the 5 day forecast in a scrollable view. 

##### Stories

- The user should be able to view the current temperature for their current location.
- The user should be able to view the temprature for the next 5 days.

##### Technical Details

- Weather should be loaded from the [OpenWeatherMap API](http://openweathermap.org/API).
- Current temperature can be loaded from the [weather endpoint](http://openweathermap.org/API#weather).
- 5-day forecast can be loaded from the [forecast endpoint](http://openweathermap.org/API#forecast).
- When loading data from the API present an overlay, build an overlay for this or use something like [MBProgressHUD](https://github.com/jdg/MBProgressHUD). 

##### Design Details

- Seperator line should be $gray-darkest and 1pt in height.

