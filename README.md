# Animated Notification System

A lightweight, modular UI notification system for Roblox, designed for smooth transitions and easy integration.

### Features
* **Modular Design:** Send notifications from any script with a single line of code.
* **Tween-Based:** Uses TweenService for professional appearing and disappearing animations.
* **Type Support:** Built-in templates for Success, Warning, and Error messages.

### Quick Start
1. Place the `NotificationModule` in `ReplicatedStorage`.
2. Send a notification from any script:
```lua
local Notify = require(game.ReplicatedStorage.NotificationModule)
Notify:Send("Operation successful!", "Success")
