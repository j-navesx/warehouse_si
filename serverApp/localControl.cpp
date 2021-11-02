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

void stopX()
{
	uInt8 p = readDigitalU8(4);
	setBitValue(&p, 0, 0);
	setBitValue(&p, 1, 0);
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

void stopY()
{
	uInt8 p = readDigitalU8(4);
	setBitValue(&p, 3, 0);
	setBitValue(&p, 4, 0);
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

void stopZ()
{
	uInt8 p = readDigitalU8(4);
	setBitValue(&p, 5, 0);
	setBitValue(&p, 6, 0);
	writeDigitalU8(4, p);
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
	case 'a': moveXLeft(); break;
	case 'z': stopX(); break;

		case 'w': moveYInside(); break;
		case 's': moveYOutside(); break;
		case 'x': stopY(); break;

		case 'e': moveZUp(); break;
		case 'd': moveZDown(); break;
		case 'c': stopZ(); break;

		//case 'r': moveLeftStationInside(); break;
		//case 'f': moveLeftStationOutside(); break;
		//case 'v': stopLeftStation(); break;

		//case 't': moveRightStationInside(); break;
		//case 'g': moveRightStationOutside(); break;
		//case 'b': stopRightStation(); break;

	case 'p': showPortsInformation(); break;
	default: break;
	}
}