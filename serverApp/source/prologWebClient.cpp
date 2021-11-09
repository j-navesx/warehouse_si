
#include <iostream>
#include <string>
#include<stdio.h>
#include <windows.h>
#include<winhttp.h>

#include<tchar.h>




using namespace std;

HINTERNET  hSession = NULL,
hConnect = NULL,
hRequest = NULL;



wchar_t* convertCharArrayToLPCWSTR(char* charArray)
{
	wchar_t* wString = new wchar_t[4096];
	MultiByteToWideChar(CP_ACP, 0, charArray, -1, wString, 4096);
	return wString;
}




void CALLBACK HttpCallback(HINTERNET hInternet, DWORD* dwContext, DWORD dwInternetStatus, void* lpvStatusInfo, DWORD dwStatusInfoLength)
{
	switch (dwInternetStatus)
	{
	default:
		//std::cout << dwInternetStatus << "\n";
		break;

	case WINHTTP_CALLBACK_STATUS_HANDLE_CREATED:
		//std::cout << "Handle created.\n";
		//theRequest = 1;
		break;

	case WINHTTP_CALLBACK_FLAG_WRITE_COMPLETE:
		//std::cout << "post done.\n";
		//responseReceived++;
		break;
	case WINHTTP_CALLBACK_STATUS_REQUEST_SENT:
		//std::cout << "Request sent.\n";
		//theRequest = 2;
		break;

	case WINHTTP_CALLBACK_STATUS_RESPONSE_RECEIVED:
		//std::cout << "Response received.\n";
		//theRequest = 3;

		break;
	case WINHTTP_CALLBACK_FLAG_INTERMEDIATE_RESPONSE:
		//std::cout << "intermediate response.\n";

		break;

	}
}


int semaphore_mutex = 1;
string   sendPrologWebRequest(char* request, char* server, char* port) {
	DWORD dwSize = 0;
	DWORD dwDownloaded = 0;
	LPSTR pszOutBuffer = NULL;
	BOOL  bResults = FALSE;

	// received output
	string result="";

	while (semaphore_mutex == 0) {
		Sleep(1);
	}
	semaphore_mutex = 0;


	//convert "char* server" to LPCWSTR
	string temp = server;
	std::wstring stemp = std::wstring(temp.begin(), temp.end());
	LPCWSTR serverName = stemp.c_str();

	int portNumber = atoi(port);

	//convert "char* request" to LPCWSTR
	string temp2 = request;
	std::wstring stemp2 = std::wstring(temp2.begin(), temp2.end());
	LPCWSTR request2 = stemp2.c_str();


	// Use WinHttpOpen to obtain a session handle.
	if (!hSession) {
		hSession = WinHttpOpen(L"WinHTTP Example/1.0",
			WINHTTP_ACCESS_TYPE_DEFAULT_PROXY,
			WINHTTP_NO_PROXY_NAME,
			WINHTTP_NO_PROXY_BYPASS, 0);


		WINHTTP_STATUS_CALLBACK isCallback = WinHttpSetStatusCallback(hSession,
			(WINHTTP_STATUS_CALLBACK)HttpCallback,
			WINHTTP_CALLBACK_FLAG_ALL_NOTIFICATIONS,
			NULL);

	}




	// Specify an HTTP server.
	if (hSession)
		if (!hConnect) {


			hConnect = WinHttpConnect(hSession, serverName,
				portNumber, 0);
		}

	// Create an HTTP request handle.
	if (hConnect) {
		//request2 = convertCharArrayToLPCWSTR(request);

		hRequest = WinHttpOpenRequest(hConnect, L"GET", request2,
			NULL, WINHTTP_NO_REFERER,
			WINHTTP_DEFAULT_ACCEPT_TYPES,
			0);
	}

	// Send a request.
	if (hRequest)
		bResults = WinHttpSendRequest(
			hRequest,
			WINHTTP_NO_ADDITIONAL_HEADERS,
			0,
			WINHTTP_NO_REQUEST_DATA,
			0,
			0,
			0);

	// End the request.
	if (bResults) {
		bResults = WinHttpReceiveResponse(hRequest, NULL);

	}
	// Keep checking for data until there is nothing left.
	if (bResults) {
		/* funciona
		while (!WinHttpQueryDataAvailable(hRequest, &dwSize)) {
			Sleep(1);
		}
		//WinHttpQueryDataAvailable(hRequest, &dwSize);
		pszOutBuffer = new char[dwSize + 1];
		ZeroMemory(pszOutBuffer, dwSize + 1);
		
		WinHttpReadData(hRequest, (LPVOID)pszOutBuffer, dwSize, &dwDownloaded);
		*/do
		{
			// Check for available data.
			dwSize = 0;
			if (!WinHttpQueryDataAvailable(hRequest, &dwSize))
			{
				printf("Error %u in WinHttpQueryDataAvailable.\n",
					GetLastError());
				break;
			}

			// No more available data.
			if (!dwSize)
				break;

			// Allocate space for the buffer.
			pszOutBuffer = new char[dwSize + 1];
			if (!pszOutBuffer)
			{
				printf("Out of memory\n");
				break;
			}

			// Read the Data.
			ZeroMemory(pszOutBuffer, dwSize + 1);

			if (!WinHttpReadData(hRequest, (LPVOID)pszOutBuffer,
				dwSize, &dwDownloaded))
			{
				printf("Error %u in WinHttpReadData.\n", GetLastError());
			}
			else
			{
				//printf("%s", pszOutBuffer);
			}

			// Free the memory allocated to the buffer.
			result.append(pszOutBuffer);
			delete[] pszOutBuffer;

			// This condition should never be reached since WinHttpQueryDataAvailable
			// reported that there are bits to read.
			if (!dwDownloaded)
				break;

		} while (dwSize > 0);
	}


	// Report any errors.
	if (!bResults)
		printf("Error: %d has occurred, when trying request %s on %s:%s.\n",
			GetLastError(), request, server, port);

	// Close any open handles.
	if (hRequest)
		WinHttpCloseHandle(hRequest);

	//if (hConnect) WinHttpCloseHandle(hConnect);
	//if (hSession) WinHttpCloseHandle(hSession);	

	
	//result.assign(pszOutBuffer ? pszOutBuffer : "");

	//printf("\n webProlog result=%s", result.c_str());

	//if (pszOutBuffer)
	//	delete[]pszOutBuffer;

	semaphore_mutex = 1;
	return result;
}




void main_webRequest(void) {
	//LPSTR output = sendWebRequest((char *)"/rtx_get?query=retractall(port_val(_,_)),assert(port_val(2,255))");
	string output = sendPrologWebRequest((char*)"/rtx_get?query=write(a)", (char*)"127.0.0.1", (char*)"8082");

	printf("\nresult=%s", output.c_str());

}