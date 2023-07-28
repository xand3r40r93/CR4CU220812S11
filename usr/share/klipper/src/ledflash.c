#include "autoconf.h" // CONFIG_CLOCK_FREQ
#include "basecmd.h" // oid_alloc
#include "board/gpio.h" // struct gpio
#include "board/irq.h" // irq_disable
#include "board/misc.h" // timer_read_time
#include "command.h" // shutdown
#include "sched.h" // sched_timer_dispatch

#define USR_LED_FLASH_MIN_PERIOD_MS		"500"
#define USR_LED_FLASH_HZ				(100)
#define USR_LED_FLASH_PERIOD_TICKS		(CONFIG_CLOCK_FREQ / USR_LED_FLASH_HZ)
#define USR_LED_FLASH_STEPS				(250)		//10ms/250 = 40us

DECL_CONSTANT_STR("ledflash_min_period_ms", USR_LED_FLASH_MIN_PERIOD_MS);


enum {LED_FLASH_ON=1<<2, LED_FLASH_STATUS=1<<1, LED_FLASH_START=1<<0};

static struct task_wake ledflash_wake;

struct ledflashdata
{
	struct timer time;
	
	struct gpio_out led;
	
	uint32_t next_ticks;
	
	uint32_t ledstep_ticks;
	
	uint32_t ledstep_num;
	
	uint32_t ledstep_num_index;
	
	uint32_t ledstep_keep;
	
	uint32_t ledstep_keep_index;
	
	uint8_t flags;	
};


static uint_fast8_t
ledflash_event(struct timer *t)
{
	int8_t neg_pos = 1; 

	struct ledflashdata *leddata = container_of(t, struct ledflashdata, time);

	sched_wake_task(&ledflash_wake);

	leddata->time.waketime += leddata->next_ticks;

	leddata->ledstep_keep_index++;

	if(leddata->ledstep_keep_index >= 2 * leddata->ledstep_keep)			//scale down
	{		
		leddata->ledstep_keep_index = 1;

		if(leddata->ledstep_num_index >= leddata->ledstep_num)
		{
			neg_pos = -1;
		}
		else if(leddata->ledstep_num_index <= 1)
		{
			neg_pos = 1;
		}
		else
		{
			//nothing to do.
		}

		leddata->ledstep_num_index += neg_pos;
	}
	
	if(leddata->flags & LED_FLASH_START)
	{
		return SF_RESCHEDULE;
	}
	
	return SF_DONE;
}


void
command_config_ledflash(uint32_t* args)
{
	uint8_t oid = args[0];
	
	struct ledflashdata *leddata = oid_alloc(oid, command_config_ledflash, sizeof(*leddata));
	
	leddata->led = gpio_out_setup(args[1], !!args[2]);
	
	leddata->flags = (!args[2]) << 2; //led on 
}

DECL_COMMAND(command_config_ledflash,"config_ledflash oid=%c led_pin=%c led_off=%c");


void
command_ledflash_start(uint32_t *args)
{
	uint8_t oid = args[0];
	
	struct ledflashdata *leddata = oid_lookup(oid, command_config_ledflash);	
	
	uint32_t period_ms = args[2];
	
	uint32_t period_para_test = period_ms / 2;

	if((period_para_test / USR_LED_FLASH_STEPS == 0) || (period_para_test % USR_LED_FLASH_STEPS != 0)) //deal error args[2]
	{
		period_ms = 1000;
	}

	sched_del_timer(&leddata->time);
	
	leddata->time.func = ledflash_event;
	
	leddata->time.waketime = args[1];
	
	leddata->ledstep_ticks = USR_LED_FLASH_PERIOD_TICKS / USR_LED_FLASH_STEPS; 
	
	leddata->ledstep_keep = (period_ms / 2) / USR_LED_FLASH_STEPS;
	
	leddata->ledstep_keep_index = 0;
	
	leddata->ledstep_num = USR_LED_FLASH_STEPS;
	
	leddata->ledstep_num_index = 1;
	
	leddata->flags |= LED_FLASH_START;
	
	sched_add_timer(&leddata->time);
}

DECL_COMMAND(command_ledflash_start,"ledflash_start oid=%c clock=%u period_ms=%u");

void
ledflash_task(void)
{
	uint8_t oid;
	
	struct ledflashdata *leddata;

	if(!sched_check_wake(&ledflash_wake))
	{
		return;
	}

	foreach_oid(oid, leddata, command_config_ledflash)
	{
		if(!(leddata->flags & LED_FLASH_START))
		{
			return;
		}

		if((!!(leddata->flags & LED_FLASH_STATUS)) == (!!(leddata->flags & LED_FLASH_ON)))
		{
			leddata->next_ticks = USR_LED_FLASH_PERIOD_TICKS - leddata->ledstep_num_index * leddata->ledstep_ticks;
			
			gpio_out_write(leddata->led,0);

			leddata->flags &= ~LED_FLASH_STATUS;
			
			leddata->flags |=  (!(leddata->flags & LED_FLASH_ON)) << 1;
		}
		else
		{
			leddata->next_ticks = leddata->ledstep_num_index * leddata->ledstep_ticks;
			
			gpio_out_write(leddata->led,1);

			leddata->flags &= ~LED_FLASH_STATUS;
			
			leddata->flags |=  (!!(leddata->flags & LED_FLASH_ON)) << 1;
		}
	}
}

DECL_TASK(ledflash_task);


void
ledflash_shutdown(void)
{
	uint8_t oid;
	
	struct ledflashdata *leddata;

	foreach_oid(oid,leddata,command_config_ledflash)
	{
		leddata->flags &= ~LED_FLASH_START;
		
		gpio_out_write(leddata->led, !(leddata->flags & LED_FLASH_ON));
		
		sched_del_timer(&leddata->time);
	}
}

DECL_SHUTDOWN(ledflash_shutdown);

