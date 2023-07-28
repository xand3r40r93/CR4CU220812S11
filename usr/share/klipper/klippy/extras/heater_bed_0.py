# Support for a heated bed
#
# Copyright (C) 2018-2019  Kevin O'Connor <kevin@koconnor.net>
#
# This file may be distributed under the terms of the GNU GPLv3 license.

class PrinterHeaterBed0:
    def __init__(self, config):
        self.printer = config.get_printer()
        pheaters = self.printer.load_object(config, 'heaters')
        self.heater = pheaters.setup_heater(config, 'B')
        self.get_status = self.heater.get_status
        self.stats = self.heater.stats
        # Register commands
        gcode = self.printer.lookup_object('gcode')
        gcode.register_command("M140", self.cmd_M140)
        gcode.register_command("M190", self.cmd_M190)
    def cmd_M140(self, gcmd, wait=False):
        # Set Bed Temperature
        tempS = gcmd.get_float('S', 0.)
        tempD = gcmd.get_int('D', 3, 0, 3)
        pheaters = self.printer.lookup_object('heaters')
        if tempD is 3 or tempD is 0:
            heaterS = self.printer.lookup_object('heater_bed_0').heater
            pheaters.set_temperature(heaterS, tempS, wait)
        if tempD is 3 or tempD is 1:
            heaterM = self.printer.lookup_object('heater_bed_1').heater
            pheaters.set_temperature(heaterM, tempS, wait)
        if tempD is 3 or tempD is 2:
            heaterO = self.printer.lookup_object('heater_bed_2').heater
            pheaters.set_temperature(heaterO, tempS, wait)        
    def cmd_M190(self, gcmd):
        # Set Bed Temperature and Wait
        self.cmd_M140(gcmd, wait=True)

def load_config(config):
    return PrinterHeaterBed0(config)
