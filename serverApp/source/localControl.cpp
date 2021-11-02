#include <iostream>
#include <stdio.h>
#include <conio.h>
#include <stdio.h>
#include <windows.h>

#include <interface.h>

using namespace std;

void initializeHardwarePorts()
{
	// INPUT PORTS
	createDigitalInput(0);
	createDigitalInput(1);
	createDigitalInput(2);
	createDigitalInput(3);
	// OUTPUT PORTS
	createDigitalOutput(4);
	createDigitalOutput(5);

	writeDigitalU8(4, 0);
	writeDigitalU8(5, 0);
}

void setBitValue(uInt8* variable, int n_bit, int new_value_bit)
// given a byte value, set the n bit to value
{
	uInt8  mask_on = (uInt8)(1 << n_bit);
	uInt8  mask_off = ~mask_on;
	if (new_value_bit)  *variable |= mask_on;
	else                *variable &= mask_off;
}

int getBitValue(uInt8 value, uInt8 n_bit)
// given a byte value, returns the value of bit n
{
	return(value & (1 << n_bit));
}


int getXPosition()
{
	int pp[10] = { 0,0,0,0,0,0,0,0,1,1 };
	int bb[10] = { 0,1,2,3,4,5,6,7,0,1 };
	int ports[2];
	ports[0] = readDigitalU8(0);
	ports[1] = readDigitalU8(1);
	for (int i = 0; i < 10; i++) {
		if (!getBitValue(ports[pp[i]], bb[i]))
			return i + 1;
	}
	return(-1);
}

int getZPosition()
{
	int pp[5] = { 2,2,2,2,1 };
	int bb[5] = { 6,4,2,0,6 };
	int ports[3];
	ports[2] = readDigitalU8(2);
	ports[1] = readDigitalU8(1);
	for (int i = 0; i < 5; i++) {
		if (!getBitValue(ports[pp[i]], bb[i]))
			return i + 1;
	}
	return(-1);
}

int getYPosition()
{
	int pp[3] = { 1,1,1 };
	int bb[3] = { 2,3,4 };
	int ports[2];
	ports[0] = readDigitalU8(0);
	ports[1] = readDigitalU8(1);
	for (int i = 0; i < 3; i++) {
		if (!getBitValue(ports[pp[i]], bb[i]))
			return i + 1;
	}
	return(-1);
}

void moveXRight()
{
	uInt8 p = readDigitalU8(4);
	setBitValue(&p, 1, 0);
	setBitValue(&p, 0, 1);
	writeDigitalU8(4, p);
}

void moveXLeft()
{
	uInt8 p = readDigitalU8(4);
	setBitValue(&p, 0, 0);
	setBitValue(&p, 1, 1);
	writeDigitalU8(4, p);
}

void moveZUp()
{
	uInt8 p = readDigitalU8(4);
	setBitValue(&p, 6, 0);
	setBitValue(&p, 5, 1);
	writeDigitalU8(4, p);
}

void moveZDown()
{
	uInt8 p = readDigitalU8(4);
	setBitValue(&p, 5, 0);
	setBitValue(&p, 6, 1);
	writeDigitalU8(4, p);
}

void moveYInside()
{
	uInt8 p = readDigitalU8(4);
	setBitValue(&p, 3, 0);
	setBitValue(&p, 4, 1);
	writeDigitalU8(4, p);
}

void moveYOutside()
{
	uInt8 p = readDigitalU8(4);
	setBitValue(&p, 4, 0);
	setBitValue(&p, 3, 1);
	writeDigitalU8(4, p);
}

void stopX()
{
	uInt8 p = readDigitalU8(4);
	setBitValue(&p, 0, 0);
	setBitValue(&p, 1, 0);
	writeDigitalU8(4, p);
}

void stopZ()
{
	uInt8 p = readDigitalU8(4);
	setBitValue(&p, 5, 0);
	setBitValue(&p, 6, 0);
	writeDigitalU8(4, p);
}

void stopY()
{
	uInt8 p = readDigitalU8(4);
	setBitValue(&p, 3, 0);
	setBitValue(&p, 4, 0);
	writeDigitalU8(4, p);
}

void gotoX(int x_dest) {
	int current = getXPosition();
	if (x_dest > current)
		moveXRight();
	else if (x_dest < current)
		moveXLeft();
	//   while position not reached    
	while (getXPosition() != x_dest) {
		Sleep(1);
	}
	stopX();
}

/*
int getXMoving(int movingX) {
	// Right:1   Left:0   Not Moving:-1
	uInt8 p = readDigitalU8(4);
	if (getBitValue(p, 0))
		return 1;
	if (getBitValue(p, 1))
		return 0;
	else return -1;
}*/

void gotoZ(int z_dest) {
	int current = getZPosition();
	if (z_dest > current)
		moveZUp();
	else if (z_dest < current)
		moveZDown();
	while (getZPosition() != z_dest) {
		Sleep(1);
	}
	stopZ();
}

void gotoY(int y_dest) {
	int current = getYPosition();
	if (y_dest > current)
		moveYInside();
	else if (y_dest < current)
		moveYOutside();
	while (getYPosition() != y_dest) {
		Sleep(1);
	}
	stopY();
}

void moveLeftStationInside() {

	uInt8 p4 = readDigitalU8(4);
	uInt8 p5 = readDigitalU8(5);
	setBitValue(&p4, 7, 1);
	setBitValue(&p5, 0, 0);
	writeDigitalU8(4, p4);
	writeDigitalU8(5, p5);
}

void moveLeftStationOutside() {

	uInt8 p4 = readDigitalU8(4);
	uInt8 p5 = readDigitalU8(5);
	setBitValue(&p4, 7, 0);
	setBitValue(&p5, 0, 1);
	writeDigitalU8(4, p4);
	writeDigitalU8(5, p5);
}

void stopLeftStation() {
	uInt8 p4 = readDigitalU8(4);
	uInt8 p5 = readDigitalU8(5);
	setBitValue(&p4, 7, 0);
	setBitValue(&p5, 0, 0);
	writeDigitalU8(4, p4);
	writeDigitalU8(5, p5);
}

void moveRightStationInside() {

	uInt8 p = readDigitalU8(5);
	setBitValue(&p, 1, 1);
	setBitValue(&p, 2, 0);
	writeDigitalU8(5, p);
}

void moveRightStationOutside() {

	uInt8 p = readDigitalU8(5);
	setBitValue(&p, 1, 0);
	setBitValue(&p, 2, 1);
	writeDigitalU8(5, p);
}

void stopRightStation() {
	uInt8 p = readDigitalU8(5);
	setBitValue(&p, 1, 0);
	setBitValue(&p, 2, 0);
	writeDigitalU8(5, p);
}

int isMovingRight() {

	uInt8 p4 = readDigitalU8(4);
	if (!getBitValue(p4, 0))
		return 0;
	return 1;
}

int isMovingLeft() {

	uInt8 p4 = readDigitalU8(4);
	if (!getBitValue(p4, 1))
		return 0;
	return 1;
}

int getXMoving() {

	if (isMovingLeft() == 1)
	{
		return -1;
	}
	else if (isMovingRight() == 1)
	{
		return 1;
	}
	else if (isMovingLeft() == 0 || isMovingRight() == 0)
	{
		return 0;
	}

	return -1;

}

int isMovingUp() {

	uInt8 p4 = readDigitalU8(4);
	if (!getBitValue(p4, 5))
		return 0;
	return 1;
}

int isMovingDown() {

	uInt8 p4 = readDigitalU8(4);
	if (!getBitValue(p4, 6))
		return 0;
	return 1;
}

int getZMoving() {

	if (isMovingUp() == 1)
	{
		return 1;
	}
	else if (isMovingDown() == 1)
	{
		return -1;
	}
	else if (isMovingUp() == 0 || isMovingDown() == 0)
	{
		return 0;
	}

	return -1;

}

int isMovingIn() {

	uInt8 p4 = readDigitalU8(4);
	if (!getBitValue(p4, 4))
		return 0;
	return 1;
}

int isMovingOut() {

	uInt8 p4 = readDigitalU8(4);
	if (!getBitValue(p4, 3))
		return 0;
	return 1;
}

int getYMoving() {

	if (isMovingIn() == 1)
	{
		return 1;
	}
	else if (isMovingOut() == 1)
	{
		return -1;
	}
	else if (isMovingIn() == 0 || isMovingOut() == 0)
	{
		return 0;
	}

	return -1;
}

int isLeftMovingInside() {

	uInt8 p4 = readDigitalU8(4);
	if (!getBitValue(p4, 7))
		return 0;
	return 1;
}

int isLeftMovingOutside() {

	uInt8 p5 = readDigitalU8(5);
	if (!getBitValue(p5, 0))
		return 0;
	return 1;
}

int getLeftStationMoving() {

	if (isLeftMovingInside() == 1)
	{
		return 1;
	}
	else if (isLeftMovingOutside() == 1)
	{
		return 1;
	}
	else if (isLeftMovingInside() == 0 || isLeftMovingOutside() == 0)
	{
		return 0;
	}

	return -1;
}

int isRightMovingInside() {

	uInt8 p5 = readDigitalU8(5);
	if (!getBitValue(p5, 1))
		return 0;
	return 1;
}

int isRightMovingOutside() {

	uInt8 p5 = readDigitalU8(5);
	if (!getBitValue(p5, 2))
		return 0;
	return 1;
}

int getRightStationMoving() {

	if (isRightMovingInside() == 1)
	{
		return 1;
	}
	else if (isRightMovingOutside() == 1)
	{
		return 1;
	}
	else if (isRightMovingInside() == 0 || isRightMovingOutside() == 0)
	{
		return 0;
	}

	return -1;
}

bool isPartOnLeftStation() {
	uInt8 p3 = readDigitalU8(3);
	if (!getBitValue(p3, 0))
		return false;
	return true;
}

bool isPartOnRightStation() {
	uInt8 p3 = readDigitalU8(3);
	if (!getBitValue(p3, 1))
		return false;
	return true;
}

bool isAtZUp() {
	uInt8 p1 = readDigitalU8(1);
	uInt8 p2 = readDigitalU8(2);

	if (!getBitValue(p1, 5) || !getBitValue(p1, 7) || !getBitValue(p2, 1) || !getBitValue(p2, 3) || !getBitValue(p2, 5))
		return true;
	else return false;
}

bool isAtZDown() {
	uInt8 p1 = readDigitalU8(1);
	uInt8 p2 = readDigitalU8(2);

	if (!getBitValue(p1, 6) || !getBitValue(p2, 0) || !getBitValue(p2, 2) || !getBitValue(p2, 4) || !getBitValue(p2, 6))
		return true;
	else return false;
}

bool isPartInCage() {

	uInt8 p2 = readDigitalU8(2);
	if (!getBitValue(p2, 7))
		return false;
	return true;
}


void showPortsInformation() {	
	for (int portNumber = 0; portNumber < 6; portNumber++) {
		uInt8 portValue = readDigitalU8(portNumber);
		printf("\nport(%d)=%02x --> ", portNumber, portValue);
		for (int bitNumber = 0; bitNumber < 8; bitNumber++) {
			bool bitValue = portValue & (1 << 7 - bitNumber);
			if ((bitNumber % 4) == 0)
				putchar(' ');
			printf("%d", (int)bitValue);
		}
		printf("\n");
	}
}


void executeLocalControl(int keyboard) {


	switch (keyboard) {
	case 'q': moveXRight(); break;
	case 'a': moveXLeft();	break;
	case 'z': stopX();		break;
	
	case 'w': moveYInside(); break;
	case 's': moveYOutside(); break;
	case 'x': stopY(); break;
	
	case 'e': moveZUp(); break;
	case 'd': moveZDown(); break;
	case 'c': stopZ(); break;
	
	case 'r': moveLeftStationInside(); break;
	case 'f': moveLeftStationOutside(); break;
	case 'v': stopLeftStation(); break;
	
	case 't': moveRightStationInside(); break;
	case 'g': moveRightStationOutside(); break;
	case 'b': stopRightStation(); break;

	case 'p': showPortsInformation(); break;
	

	default: break;
	}
}