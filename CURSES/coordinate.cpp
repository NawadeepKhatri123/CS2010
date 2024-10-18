/******************************************************************************

Welcome to GDB Online.
GDB online is an online compiler and debugger tool for C, C++, Python, Java, PHP, Ruby, Perl,
C#, OCaml, VB, Swift, Pascal, Fortran, Haskell, Objective-C, Assembly, HTML, CSS, JS, SQLite, Prolog.
Code, Compile, Run and Debug online from anywhere in world.

*******************************************************************************/
#include <iostream>
#include <vector>

using namespace std;

using COORD = vector<int>;
using POINTS = vector<COORD>;
int main()
{
    POINTS p;
    int x,y;
    while ( 0 != x) {
      cout<<"Enter x and y coordinates : ";
      cin >> x >> y;
      p.push_back(COORD{x,y});
    }
    for (auto i : p) {
        if (i == COORD{0,0})
            cout << i[0] << "," << i[1] << " ";
    }
    return 0;
}
