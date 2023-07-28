# Support for a heated bed
#
# Copyright (C) 2018-2019  Kevin O'Connor <kevin@koconnor.net>
#
# This file may be distributed under the terms of the GNU GPLv3 license.

# [heater_bed_mid]
# heater_pin: PA2
# sensor_type: EPCOS 100K B57560G104F
# sensor_pin: PC4
# control: pid
# tuned for stock hardware with 50 degree Celsius target
# pid_Kp: 54.027
# pid_Ki: 0.770
# pid_Kd: 948.182
# min_temp: 0
# max_temp: 130

class PrinterHeaterBedMid1:
    def __init__(self, config):
        self.printer = config.get_printer()
        pheaters = self.printer.load_object(config, 'heaters')
        self.heater = pheaters.setup_heater(config, 'M')
        self.get_status = self.heater.get_status
        self.stats = self.heater.stats
def load_config(config):
    return PrinterHeaterBedMid1(config)
