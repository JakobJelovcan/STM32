#include <ctype.h>
extern void red_led_on(void);
extern void red_led_off(void);
extern void delay_tc(int);
void display_signal(char);
char code_table[] = {0x48, 0x90, 0x94, 0x70, 0x20, 0x84, 0x78, 0x80, 0x40, 0x8E, 0x74, 0x88, 0x58, 0x50, 0x7C, 0x46, 0x4D, 0x68, 0x60, 0x30, 0x64, 0x82, 0x6C, 0x92, 0x4B, 0x4C, 0xBF, 0xAF, 0xA7, 0xA3, 0xA1, 0xA0, 0xB0, 0xB8, 0xBC, 0xBE};

extern char char_to_morse(char c) {
	char c_lower = tolower(c);
	if(isdigit(c_lower)) {
		return code_table[c_lower - 22];
	} else if(isalpha(c_lower)) {
		return code_table[c_lower - 97];
	}
	else {
		return 0;
	}
}

extern void short_signal() {
	red_led_on();
	delay_tc(500);
	red_led_off();
	delay_tc(500); //Pause after letter
}

extern void long_signal() {
	red_led_on();
	delay_tc(1500);
	red_led_off();
	delay_tc(500); //Pause after letter
}

extern void space() {
	delay_tc(2500);
}

extern void display_morse(char* str) {
	while(*str) {
		if(*str == ' ') {
			space();
		}
		else {
			char morse = char_to_morse(*str);
			display_signal(morse);
		}
		++str;
	}
}

void display_signal(char morse) {
	char len = (morse & 0xE0) >> 5;
	morse <<= 3;
	while(len--) {
		char signal = morse & 0x80;
		morse <<= 1;
		if(signal) short_signal();
		else long_signal();
	}
}
