#include "../inc/point.hpp"

int main()
{
    Point sPoint1;
    Point sPoint2;

    Point sPointTot;

    sPoint1 = InitPoint(10, 10);
    sPoint2 = InitPoint(100, 50);

    sPointTot   =   sPoint1 + sPoint2;

    std::cout<<Display(sPoint1)<<std::endl;
    sPoint1++;
    std::cout<<Display(sPoint1)<<std::endl;
    std::cout<<Display(sPoint2)<<std::endl;
    std::cout<<Display(sPointTot)<<std::endl;
    return 0;
}
