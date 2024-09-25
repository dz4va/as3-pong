## as3-pong

This is a simple Pong game implemented in Actionscript 3.

### Usage

The game is self-contained and starts automatically. There is no menu or configuration options.

**Controls:**

* **Up Arrow:** Move right handle up
* **Down Arrow:** Move right handle down
* **W:** Move left handle up
* **S:** Move left handle down
* **Space:** Continue after the ball goes out of bounds

The first player to reach 10 points wins.

### Code Structure

The code is organized using object-oriented programming, but it doesn't adhere to any specific design patterns or principles.

**Main Classes:**

* **Pong:**  The main class containing the game logic and event handling.
* **Ball:**  Represents the ball, managing its position, velocity, and collision detection.
* **Handle:** Represents the paddles, handling movement and interaction with the ball.
* **Player:** Represents a player, managing their score and handle.
* **Counter:**  Displays the score of each player.
* **PongSoundPlayer:**  Handles playing sound effects and background music.

### Game Logic

The game loop updates the position of the ball and handles collision detection with the paddles, walls, and out-of-bounds areas. When the ball collides with a paddle, it bounces off. When the ball goes out of bounds, the corresponding player scores a point.

The game ends when one of the players reaches the specified score limit (default is 10).