#pragma once

#include<string>

using namespace std;

void configure_simulator_server();
void start_mg_server(void);
void stop_mg_server(void);


void initializeHardwarePorts();
string sendPrologWebRequest(char* request, char* server, char* port);
void executeLocalControl(int keyboard);


void dispatcherOperation();

void monitoringOperation();

extern char prologServer[127];
extern char prologPort[16];
