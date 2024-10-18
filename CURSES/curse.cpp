#include <vector>
#include <ncurses.h>
#include <cstring>

using namespace std;

using VEC = vector<int>;
using MATRIX = vector<VEC>;

int
main ()
{
  initscr ();
  noecho();
  cbreak();
  for (auto iter=0; iter<5;iter++) {
  MATRIX M(20, VEC(20,iter*10));
  for ( auto y =0; y < 20;y++)
    for (auto x=0; x < 20; x++)
    {
       mvprintw (y,x*5," %2d ",M[y][x]);
    }
  refresh ();
  if (getch () == 'q') break;

  }
  endwin ();

  return 0;
}




