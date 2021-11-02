#include <warehouseConfig.h>
#include <interface.h>



char queryString[10000]; // It is not the best way...
void monitoringOperation() {
	static int portValues[6] = { 0,0,0,0,0,0 };
	static bool firstTime = true;

	if (firstTime) {
		sendPrologWebRequest((char*)"/rtx_get?query=retractall(port_value(_, _))", prologServer, prologPort);
	}


	strcpy(queryString, "true"); // just simplifies comma in placement code below
	for (int port = 0; port < 4 + 2 * (firstTime); port++) {
		uInt8 byteValue = readDigitalU8(port);

		if ((portValues[port] != byteValue) || firstTime) {
			portValues[port] = byteValue;
			char changeFact[255];
			sprintf(changeFact, ", retractall(port_value(%d,_)), assert(port_value(%d,%d))", port, port, byteValue);
			strcat(queryString, changeFact);
		}
	}
	if (strcmp(queryString, "true") != 0) { // if it is not equal to true, then there are newly changed port values			
		char request[10000];
		sprintf(request, "/rtx_get?query=%s", queryString);
		sendPrologWebRequest((char*)request, prologServer, prologPort);
		firstTime = false;
	}
}
