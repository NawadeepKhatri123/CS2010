#include <vector>
#include <ncurses.h>
#include <cstring>
#include <iostream>

using namespace std;
/*
    need to run in it in wsl
*/
int
main ()
{
  MEVENT event;
  int yMax=0,yMin=1000,xMax=0,xMin=1000;
  
  initscr ();
  noecho();
  cbreak();
  keypad(stdscr, TRUE);
  curs_set(0);
  mouseinterval(3);
  mousemask(ALL_MOUSE_EVENTS, NULL);
	
	while(1)
	{	
	    int c = getch();
		switch(c)
		{	
		    case KEY_MOUSE:
//                attron(A_REVERSE);
			    if(getmouse(&event) == OK)
				    if(event.bstate & BUTTON1_PRESSED)
				    {	
					    yMin = (event.y < yMin) ? event.y: yMin;    
					    yMax = (event.y > yMax) ? event.y: yMax;    
					    xMin = (event.x < xMin) ? event.x: xMin;    
					    xMax = (event.x > xMax) ? event.x: xMax;    
					    mvprintw(event.y, event.x, "X");
					    refresh(); 
				    }
//`                attron(A_NORMAL);
		     break;
		     case 'q' : goto end;
		}
	}		
end:
  endwin ();
  cout << yMin << " " << yMax << "  " << xMin << " " << xMax << endl;
  return 0;
}



