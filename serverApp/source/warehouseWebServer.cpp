
//https://github.com/cesanta/mongoose/blob/master/docs/README.md
#include <iostream>

#include <stdio.h>
#include <string.h>
#include <process.h>    /* _beginthread, _endthread */
#include <conio.h>
#include <stdlib.h>

#include <mongoose.h>

#include<warehouseConfig.h>


using namespace std;


//#include <WinSock2.h>
	void configure_simulator_server();
	void start_mg_server(void);
	void stop_mg_server(void);

	char mg_http_server[127] = "127.0.0.1";
	char mg_http_port[128] = "8081";
	char mg_http_folder[512] = "c:/si/simulators";



//static struct mg_serve_http_opts s_http_server_opts;

static struct  mg_http_serve_opts s_http_server_opts;// = { .root_dir = s_root_dir,
									  //.ssi_pattern = s_ssi_pattern };



char mg_ports[10][10] = {"0","0" ,"0" ,"0" ,"0" ,"0" ,"0" ,"0" ,"0" ,"0" };
//0 <- INPUT; //1<- output; //-1 <- not specified
int ports_type[10] = {-1,-1,-1,-1,-1,-1,-1,-1,-1,-1 };


int server_is_on = 0;


int PORTS_VALUES_AVAILABLE = 0;




	
//http://localhost:8081/rtxengine?query=forall(between(1,10,X),writeln(X))

//https://github.com/cesanta/mongoose/blob/master/examples/connected_device_4/server.c

static void ev_handler(struct mg_connection *nc, int ev, void *ev_data, void * fn_data) {
	extern HANDLE mutex_sem;

	if (ev == MG_EV_HTTP_MSG) {

		struct mg_http_message *hm = (struct mg_http_message *) ev_data;
				

		if (mg_vcmp(&hm->uri, "/save") == 0) {
			if (mg_vcmp(&hm->method, "GET") == 0) {
				char var1[500];
				mg_http_get_var(&hm->query, "a", var1, sizeof(var1));
				int x;
				x = 0;

				double cpu_usage = (double)rand() / RAND_MAX * 100.0;
				// Use chunked encoding in order to avoid calculating Content-Length
				mg_printf(nc, "%s", "HTTP/1.1 200 OK\r\nTransfer-Encoding: chunked\r\n\r\n");
				// Output JSON object which holds CPU usage data
			
				mg_http_printf_chunk(nc, "{ \"result\": %f }", cpu_usage);
				// Send empty chunk, the end of response
				mg_http_printf_chunk(nc, "");

			}//if GET
		}
		else if (mg_vcmp(&hm->uri, "/ajax_port_values") == 0) {
			if (mg_vcmp(&hm->method, "GET") == 0) {				
				/*
				mg_get_http_var(&hm->query_string, "P0", mg_p0, sizeof(mg_p0));
				mg_get_http_var(&hm->query_string, "P1", mg_p1, sizeof(mg_p1));
				mg_get_http_var(&hm->query_string, "P2", mg_p2, sizeof(mg_p2));
				mg_get_http_var(&hm->query_string, "P3", mg_p3, sizeof(mg_p3));
				mg_get_http_var(&hm->query_string, "P4", mg_p4, sizeof(mg_p4));
				mg_get_http_var(&hm->query_string, "P5", mg_p5, sizeof(mg_p5));
				mg_printf(nc, "%s", "HTTP/1.1 200 OK\r\nTransfer-Encoding: chunked\r\n\r\n");

				mg_printf_http_chunk(nc, "{");
				mg_printf_http_chunk(nc, "\"P0\": %s,", mg_p0);
				mg_printf_http_chunk(nc, "\"P1\": %s,", mg_p1);
				mg_printf_http_chunk(nc, "\"P2\": %s,", mg_p2);
				mg_printf_http_chunk(nc, "\"P3\": %s,", mg_p3);
				mg_printf_http_chunk(nc, "\"P4\": %s,", mg_p4);
				mg_printf_http_chunk(nc, "\"P5\": %s" , mg_p5);
				mg_printf_http_chunk(nc, "}");
				// Send empty chunk, the end of response
				mg_send_http_chunk(nc, "", 0);
				*/
			}//if GET
			if (mg_vcmp(&hm->method, "POST") == 0 ) 
			{				
				if (mutex_sem != NULL)
					WaitForSingleObject(mutex_sem, INFINITE);
				for (int i = 0;i < 10; i++) {
					char port_name[10];
					sprintf_s(port_name, sizeof(port_name),"P%d", i);
					if(ports_type[i]==0) //INPUT
						mg_http_get_var(&hm->body, port_name, mg_ports[i], sizeof(mg_ports[i]));
				}
				PORTS_VALUES_AVAILABLE++;
				if (mutex_sem != NULL)
					ReleaseSemaphore(mutex_sem, 1, NULL);
								
				mg_printf(nc, "HTTP/1.1 200 OK\r\n");
				mg_printf(nc, "Content-Type: application/json\r\n");
				mg_printf(nc, "Transfer-Encoding: chunked\r\n\r\n");
				mg_http_printf_chunk(nc, "{");

				
				for (int i = 0;i < 6; i++) {
					char port_name[10];
					sprintf_s(port_name, sizeof(port_name) ,"P%d" , i);
					if(i>0) // so para acrescentar virgual
						mg_http_printf_chunk(nc, "%s", "," );
					mg_http_printf_chunk(nc, "\"%s\": %s", port_name, mg_ports[i]);
				}											
				mg_http_printf_chunk(nc, "}");
				// Send empty chunk, the end of response
				mg_http_printf_chunk(nc, "", 0);							
			}//if POST
		}
		else if (mg_vcmp(&hm->uri, "/rtx_get") == 0) {
			if (mg_vcmp(&hm->method, "POST") == 0) {
				char query[10000] = "";
				mg_http_get_var(&hm->body, "query", query, sizeof(query));
				//   /rtx_get?query=get_output_port_values
				char request[11000];
				sprintf(request, "/rtx_get?query=%s", query);
				printf("\nremote_request=%s", request);
				string result = sendPrologWebRequest(request, prologServer, prologPort);
				printf("\nresult=%s", result.c_str());
				mg_printf(nc, "HTTP/1.1 200 OK\r\n");
				mg_printf(nc, "Content-Type: application/plain\r\n");
				mg_printf(nc, "Transfer-Encoding: chunked\r\n\r\n");
				mg_http_printf_chunk(nc, result.c_str());
				mg_http_printf_chunk(nc, "", 0);
			}
		}
		else
			mg_http_serve_dir(nc, hm, &s_http_server_opts);
	}
}





void start_the_work(void *ignored) {
	
	struct mg_mgr mgr;
	struct mg_connection *nc;	
	mg_mgr_init(&mgr);
	printf("\nStarting web server on port %s\n", mg_http_port);
	char address[256];

	sprintf(address, "http://%s:%s", mg_http_server, mg_http_port);

	nc = mg_http_listen(&mgr, address, ev_handler, NULL);
	if (nc == NULL) {
		printf("Failed to create listener\n");
		return;
	}


	// Set up HTTP server parameters
	//mg_set_protocol_http_websocket(nc);
	s_http_server_opts.root_dir = mg_http_folder;  // Serve current directory
	//s_http_server_opts.directory_listing = "yes";

	SetThreadPriority(GetCurrentThread(), THREAD_PRIORITY_TIME_CRITICAL);

	while(server_is_on==1) {
		mg_mgr_poll(&mgr, 1);
		Sleep(1);
	}
	mg_mgr_free(&mgr);	 	
}




void start_mg_server(void) { 
	if (server_is_on == 0) {
		server_is_on = 1;
		//HANDLE handle =		
			_beginthread(start_the_work, 0, NULL);
		
		//SetThreadPriority(handle, 15);


	}
}


void stop_mg_server(void) {
	server_is_on = 0;
}


int main_mongoose(void)
{

	start_mg_server();
	printf("\npress a key to exit....");
	_getch();
	stop_mg_server();
	return 0;
}



