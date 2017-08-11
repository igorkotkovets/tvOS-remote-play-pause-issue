# tvOS-remote-play-pause-issue
An example application to demonstrate the issue with receiving play-pause event from remote control

## Steps to reproduce
1. Create an instance of `AVPlayer` object and keep a link to it
2. Present `AVPlayerViewController` modally from a view controller
3. After returning back and putting player to play the `UIApplication` stops receiving UIPress events

## Bug status
Bug reported to Apple. Received ID 33825530

## Demo
<img src="https://github.com/igorkotkovets/tvOS-remote-play-pause-issue/raw/master/demo.gif">
