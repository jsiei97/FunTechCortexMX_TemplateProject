#define STACK_TOP 0x20000800

void nmi_handler(void);
void hardfault_handler(void);
int main(void);

// Define the vector table
unsigned int * myvectors[4] 
__attribute__ ((section("vectors")))= {
    (unsigned int *)	STACK_TOP,         // stack pointer
    (unsigned int *) 	main,              // code entry point
    (unsigned int *)	nmi_handler,       // NMI handler (not really)
    (unsigned int *)	hardfault_handler  // hard fault handler (let's hope not)
};


int main(void)
{
    int i=0;

    while(1)
    {
        i++;
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
