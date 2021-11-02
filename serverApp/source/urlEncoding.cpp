#include <mongoose.h>


//http://localhost:8081/rtxengine?query=forall(between(1,10,X),writeln(X))

//https://github.com/cesanta/mongoose/blob/master/examples/connected_device_4/server.c



char* urlencode(char* originalText)
{
	// allocate memory for the worst possible case (all characters need to be encoded)
	char* encodedText = (char*)malloc(sizeof(char) * strlen(originalText) * 3 + 1);

	const char* hex = "0123456789abcdef";

	int pos = 0;
	for (unsigned i = 0; i < strlen(originalText); i++) {
		if (('a' <= originalText[i] && originalText[i] <= 'z')
			|| ('A' <= originalText[i] && originalText[i] <= 'Z')
			|| ('0' <= originalText[i] && originalText[i] <= '9')) {
			encodedText[pos++] = originalText[i];
		}
		else {
			encodedText[pos++] = '%';
			encodedText[pos++] = hex[originalText[i] >> 4];
			encodedText[pos++] = hex[originalText[i] & 15];
		}
	}
	encodedText[pos] = '\0';
	return encodedText;
}

/* Converts an integer value to its hex character*/
//https://www.geekhideout.com/urlcode.shtml
char to_hex(char code) {
	static char hex[] = "0123456789abcdef";
	return hex[code & 15];
}


char from_hex(char ch) {
	return isdigit(ch) ? ch - '0' : tolower(ch) - 'a' + 10;
}


char* url_encode(char* str) {
	char* pstr = str, * buf = (char *)malloc(strlen(str) * 3 + 1), * pbuf = buf;
	while (*pstr) {
		if (isalnum(*pstr) || *pstr == '-' || *pstr == '_' || *pstr == '.' || *pstr == '~')
			* pbuf++ = *pstr;
		else if (*pstr == ' ')
			* pbuf++ = *pstr; // JROSAS
		else
			*pbuf++ = '%', * pbuf++ = to_hex(*pstr >> 4), * pbuf++ = to_hex(*pstr & 15);
		pstr++;
	}
	*pbuf = '\0';
	return buf;
}

char* url_decode(char* str) {
	char* pstr = str, * buf = (char *)malloc(strlen(str) + 1), * pbuf = buf;
	while (*pstr) {
		if (*pstr == '%') {
			if (pstr[1] && pstr[2]) {
				*pbuf++ = from_hex(pstr[1]) << 4 | from_hex(pstr[2]);
				pstr += 2;
			}
		}
		else if (*pstr == '+') {
			*pbuf++ = *pstr; // JROSAS
		}
		else {
			*pbuf++ = *pstr;
		}
		pstr++;
	}
	*pbuf = '\0';
	return buf;
}

