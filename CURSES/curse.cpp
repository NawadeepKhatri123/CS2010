#include <vector>
#include <ncurses.h>
#include <iostream>

using namespace std;

using VEC = vector<int>;
using MATRIX = vector<VEC>;

void displayMatrix(const MATRIX &M) {
    clear(); // Clear the screen before displaying
    // Display the matrix
    for (int y = 0; y < M.size(); y++) {
        for (int x = 0; x < M[y].size(); x++) {
            if (M[y][x] == -1) {
                mvprintw(y, x * 5, " X "); // Display "X" for clicked positions
            } else {
                mvprintw(y, x * 5, "%2d", M[y][x]);
            }
        }
    }
    refresh(); // Refresh to show the grid
}

void gameOfLife(bool &exitFlag) {
    // Placeholder for Game of Life logic
    mvprintw(22, 0, "Game of Life function called. Press any key to return to main menu."); // Temporary message
    refresh(); // Refresh to show the message
    getch(); // Wait for a key press before returning

    // Set the exit flag to true to terminate the main loop
    exitFlag = true;
}

int main() {
    MEVENT event;
    int yMax = 0, yMin = 1000, xMax = 0, xMin = 1000;
    vector<pair<int, int>> clicks; // Vector to store clicked coordinates
    bool exitFlag = false; // Flag to control the main loop

    initscr();
    noecho();
    cbreak();
    keypad(stdscr, TRUE);
    curs_set(0);
    mouseinterval(3);
    mousemask(ALL_MOUSE_EVENTS, NULL);

    MATRIX M(20, VEC(20, 0)); // Initialize matrix outside the loop

    displayMatrix(M); // Initial display

    while (!exitFlag) {
        int c = getch();
        switch (c) {
            case KEY_MOUSE:
                if (getmouse(&event) == OK) {
                    if (event.bstate & BUTTON1_PRESSED) {
                        // Update min/max coordinates
                        yMin = (event.y < yMin) ? event.y : yMin;
                        yMax = (event.y > yMax) ? event.y : yMax;
                        xMin = (event.x < xMin) ? event.x / 5 : xMin; // Divide by 5 for spacing
                        xMax = (event.x > xMax) ? event.x / 5 : xMax;

                        // Update the matrix and store the clicked coordinates
                        int matrixY = event.y;
                        int matrixX = event.x / 5; // Convert to matrix coordinates
                        if (matrixY < M.size() && matrixX < M[matrixY].size()) {
                            M[matrixY][matrixX] = -1; // Change value to -1 (representing 'X')
                            clicks.push_back({matrixY, matrixX}); // Store the coordinates of the click
                        }

                        displayMatrix(M); // Redisplay the updated matrix
                    }
                }
                break;

            case 'n': // Call the Game of Life function on 'n'
                gameOfLife(exitFlag);
                break;

            case 'q': // Exit on 'q'
                exitFlag = true; // Set the exit flag
                break;
        }
    }

    endwin(); // End NCurses mode

    // Output the min/max coordinates and the list of clicks
    cout << "yMin: " << yMin << ", yMax: " << yMax << ", xMin: " << xMin << ", xMax: " << xMax << endl;
    cout << "Clicked coordinates:\n";
    for (const auto &click : clicks) {
        cout << "(" << click.first << ", " << click.second << ")\n";
    }

    return 0;
}

