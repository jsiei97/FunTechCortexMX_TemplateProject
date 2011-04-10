
extern int main(int argc, char** argv);

/*Used as checking if static initialization works (will be removed)*/
volatile unsigned int testvar = 0x87654321;

int board_main(void)
{
	int strt_nr = 0;
	/*
	 * Define an environmen. This will probabably be something in NV-ram or
	 * static const (i.e. ROM) later
	 * */
	char *env[] = "Cortex-m3", "for","STM32", "Delivered to you by funtech-se" ;

	while(1) {
		strt_nr++;

		main(4,(char**)env);
		strt_nr++;
	}
}

void nmi_handler(void)
{
	return ;
}

void hardfault_handler(void)
{
	return ;
}

