#include <iostream>
#include <conio.h>
#include <process.h>    /* _beginthread, _endthread */
#include <WinSock2.h>

#include <interface.h> 
#include<json.h>
#include <warehouseConfig.h>


using namespace std;


char prologServer[127] = "127.0.0.1";
char prologPort[16] = "8082";


bool supervisionOperationState = false;




void warehouseSupervisionThread(void* ignored) {
	
	supervisionOperationState = true;
	

	while (supervisionOperationState) {
		
		monitoringOperation();
		   //diagnosisOperation();
		   //errorRecovering();
		   //planningOperation(); 
		dispatcherOperation();
		   
		
		sendPrologWebRequest((char*)"/rtx_get?query=forward", prologServer, prologPort);
		


		Sleep(1);
	}
}

void startSupervision() {
	_beginthread(warehouseSupervisionThread, 0, NULL);
}

void stopSupervision() {
	supervisionOperationState = false;
}




int main(void) {
	
	cout << "Hello Inteligent Supervision...";
	printf("\npress ESC key to exit....");

	configure_simulator_server();
	start_mg_server();
	initializeHardwarePorts();

	
	
	
	startSupervision();


	int keyboard = 0;

	while (keyboard != 27) {
		if (_kbhit()) {
			keyboard = _getch();
			executeLocalControl(keyboard);
		}
		else {
			keyboard = 0;
			Sleep(1);
		}
		
		Sleep(1);
	}
	
	stopSupervision();
	stop_mg_server();
	return 0;
	
}