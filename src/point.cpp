#include "../inc/point.hpp"

Point InitPoint(int x, int y){
    Point sPoint;

    sPoint.x    =   x;
    sPoint.y    =   y;

    return sPoint;
}

std::string Display(Point sPoint){
    std::string coords;

    //std::cout<<"("<<sPoint.x<<","<<sPoint.y<<")"<<std::endl;
    coords  =   "(";
    coords  +=  std::to_string(sPoint.x);
    coords  +=  ",";
    coords  +=  std::to_string(sPoint.y);
    coords  +=  ")";

    return coords;
}

Point operator+ (Point p1, Point p2)
{
    Point res;
    res.x=p1.x+p2.x;
    res.y=p1.y+p2.y;
    return res;
}

Point operator++(Point g,int)
{
    g.x= g.x+1;

    return g;
}

Point operator++(Point g)
{
    g.y= g.y+1;

    return g;
}

Point operator--(Point g,int)
{
    g.x = g.x-1;
    return g;
}

Point operator--(Point g)
{
    g.y = g.y-1;
    return g;
}
