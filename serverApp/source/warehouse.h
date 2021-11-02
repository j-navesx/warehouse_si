#pragma once
#ifndef _WAREHOUSE_H_
#define _WAREHOUSE_H_

#include <stdbool.h>

void initializeHardwarePorts();

int getXPosition();
int getYPosition();
int getZPosition();
int getXMoving();
int getYMoving();
int getZMoving();
int getLeftStationMoving();
int getRightStationMoving();
bool isAtZUp();
bool isAtZDown();
bool isPartInCage();
bool isPartOnLeftStation();
bool isPartOnRightStation();


void moveXRight();
void moveXLeft();
void stopX();
void moveYInside();
void moveYOutside();
void stopY();
void moveZUp();
void moveZDown();
void stopZ();
void moveLeftStationInside();
void moveLeftStationOutside();
void stopLeftStation();
void moveRightStationInside();
void moveRightStationOutside();
void stopRightStation();


#endif
