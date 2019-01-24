#ifndef POINT_H
#define POINT_H

#include <iostream>
#include <string>

struct Point{
    int x;
    int y;
};

Point operator+ (Point p1, Point p2);
Point operator++(Point g,int); //post fix
Point operator++(Point g);        //pre fix
Point operator--(Point g,int);
Point operator--(Point g);

Point InitPoint (int x, int y);
std::string Display(Point sPoint);


#endif // POINT_H
