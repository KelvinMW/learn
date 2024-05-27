#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <termios.h>
#include <ctype.h>
#include <ncurses.h>
#include <time.h>

typedef struct {
    int x;
    int y;
} Point;

Point snake[100];
int length = 3;
Point food;
char direction;

void setup() {
    initscr(); // Initialize the screen
    noecho(); // Disable input echoing
    cbreak(); // Disable line buffering
    keypad(stdscr, TRUE); // Enable keyboard input for special keys like arrow keys
    clear();
    refresh();
}

void gameOver() {
    endwin(); // End the ncurses screen
    printf("Game Over\n");
    exit(0);
}

void moveSnake() {
    Point newHead = snake[length - 1];

    switch (direction) {
        case 'w': newHead.y--; break;
        case 'a': newHead.x--; break;
        case 's': newHead.y++; break;
        case 'd': newHead.x++; break;
    }

// Check for boundaries
  if (newHead.x < 0 || newHead.x >= COLS || newHead.y < 0 || newHead.y >= LINES) {
    gameOver();
  }

  // Check for self-collision using a loop
  for (int i = 0; i < length - 1; i++) {
    if (snake[i].x == newHead.x && snake[i].y == newHead.y) {
      gameOver();
    }
  }

    // Check if the snake has eaten food
    if (newHead.x == food.x && newHead.y == food.y) {
        length++;
        food.x = rand() % COLS; // Generate new food position
        food.y = rand() % LINES;
    } else {
        // Shift the snake body
        memmove(&snake[1], &snake[0], (length - 1) * sizeof(Point));
    }

    // Update the head position
    snake[0] = newHead;

    // Draw the snake and food
    for (int i = 0; i < length; ++i) {
        mvaddch(snake[i].y, snake[i].x, '#'); // Use '#' to represent the snake body
    }
    mvaddch(food.y, food.x, '*'); // Use '*' to represent the food

    refresh(); // Refresh the screen
}

void input() {
    int c = getch();
    switch (c) {
        case KEY_UP: direction = 'w'; break;
        case KEY_LEFT: direction = 'A'; break;
        case KEY_DOWN: direction = 's'; break;
        case KEY_RIGHT: direction = 'd'; break;
    }
}

int main() {
    setup();
    srand((time_t)time(NULL)); // Initialize random seed

    // Initial snake position and food position
    snake[0].x = COLS / 2;
    snake[0].y = LINES / 2;
    food.x = rand() % COLS;
    food.y = rand() % LINES;

    while (1) {
        input();
        moveSnake();
        usleep(100000); // Sleep for 0.1 seconds
    }

    return 0;
}