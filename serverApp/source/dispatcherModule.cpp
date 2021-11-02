
#include <interface.h>
#include <warehouseConfig.h>

#include<json.h>

using namespace nlohmann;


 
void dispatcherOperation() {
	string result = sendPrologWebRequest((char*)"/rtx_get?query=get_output_port_values", prologServer, prologPort);
	if (result.length() > 0) {
		//printf("\n%s", result);
		try {
			auto j = json::parse(result);
			//auto j = json::parse(R"({ "ts: ": "1633095558.118798", "ports": [{"port": "3", "value" : "200"},{"port": "4", "value" : "100"}] })");

			string query = "";

			for (auto& obj : j["ports"].items()) {
				string port = obj.value()["port"];
				string value = obj.value()["value"];

				int  port_i = std::stoi(port);
				int  val_i = std::stoi(value);
				writeDigitalU8(port_i, val_i);
			}
		}

		catch (const std::exception& e) {
			if (e.what()) {/*just to avoid compiler warning*/ }

			//printf("error: %s\n", e.what());
			//printf("ports = %s\n", result);
		}
	}
}