struct test_struct
{
	int a, b, c, d, e, f;
};

extern void asm_function1(int, int, int, int, int, int);
extern struct test_struct asm_function3(void);

extern void c_function1(void) {
	asm_function1(1,2,3,4,5,6);
}

extern void c_function2(int a, int b, int c, int d, int e, int f) {

}

extern void c_function3(void) {
	struct test_struct t = asm_function3();
}

extern struct test_struct c_function4(void) {
	struct test_struct t = { 1, 2, 3, 4, 5, 6 };
	return t;
}
