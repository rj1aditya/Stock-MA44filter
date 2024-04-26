#include<iostream>
#include <stdlib.h>
using namespace std;
int main(int argc, char* argv[])
{
	double d = atof(argv[1]);
	int x = atoi(argv[2]);

	cout<<(double)d/x;
	return 0;
}
