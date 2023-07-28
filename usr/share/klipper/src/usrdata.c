#include "autoconf.h" // CONFIG_CLOCK_FREQ
#include "basecmd.h" // oid_alloc
#include "board/gpio.h" // struct gpio
#include "board/internal.h" // SysTick
#include "board/irq.h" // irq_disable
#include "board/misc.h" // timer_read_time
#include "generic/armcm_timer.h" // timer_read_time
#include "command.h" // shutdown
#include "sched.h" // sched_timer_dispatch

static void jumpToBoot(void)
{
		uint32_t i = 0;

		void (*SysMemBootJump) (void);

		uint32_t BootAddr = CONFIG_FLASH_BOOT_ADDRESS; 

		uint32_t BootAddrVal = *(uint32_t *)BootAddr;

        irq_disable();

		SysTick->CTRL = 0;

		SysTick->LOAD = 0;

		SysTick->VAL = 0;

#if (defined(AT32F421F6P7) || defined(AT32F415CCU7))

		crm_reset();

#else

		//HAL_RCC_DeInit();

#endif

		for (i = 0; i < 8; i++)
		{
				NVIC->ICER[i] = 0xFFFFFFFF;

				NVIC->ICPR[i] = 0xFFFFFFFF;
		}

        irq_enable();

#if defined(FLASH_DBANK_SUPPORT) //STM32F429ZGT6 supports Dual Bank Boot feature.

		__HAL_SYSCFG_REMAPMEMORY_SYSTEMFLASH();

#endif

		SysMemBootJump = (void (*) (void) ) (* ( (uint32_t *) (BootAddr + 4) ) );

		asm volatile(
			"mov sp,%0\n"
			:: "r"(BootAddrVal));
		//__set_MSP (* (uint32_t *) BootAddr);

		//__set_CONTROL (0);

		SysMemBootJump();

		while (1)
		{

		}

		return;
}


void
command_bootloader_query_entery(uint32_t *args)
{
	uint8_t status = 1;

	uint32_t tick = 0;

	uint32_t delayms = 500;

	status = 1;

	sendf("bootloader_entery oid=%c value=%c",(uint8_t)args[0],(uint8_t)status);

	tick = timer_read_time();

	while(timer_read_time() - tick > (CONFIG_CLOCK_FREQ / 1000 * delayms));

	jumpToBoot();
}

DECL_COMMAND(command_bootloader_query_entery,"bootloader_query_entery oid=%c");
