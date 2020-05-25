# iosStopwatch
The reproduction of iOS stopwatch app with Swift

## Screenshot
![Simulator Screen Shot - iPhone 11 - 2020-05-25 at 16 07 39](https://user-images.githubusercontent.com/38114983/82820420-68e5c280-9ea2-11ea-8868-d2def39b2912.png)

## Framework used
- UIkit

## More

This project uses an algorithm to display two digits number for one digit number like in the exemple below.
1 -> 01
This algorithm allows to keep a good design no matter the digit display on screen

This project uses an instance of Timer to increment the time each milliseconds. But this instance is not really accurate. I noticed taht when we do the addition of every lap, the result is not equal to the global time. To solve this issue I set an offset that allows to be more accurate. It's not a satisfying solution but for the goal of this project it's okay.
