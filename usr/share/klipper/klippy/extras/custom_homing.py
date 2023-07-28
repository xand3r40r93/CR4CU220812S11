# Support for 1-wire based temperature sensors
#
# Copyright (C) 2020 Alan Lord <alanslists@gmail.com>
#
# This file may be distributed under the terms of the GNU GPLv3 license.

class CUSTOM_HOMING:
    def __init__(self, config):
        self.printer = config.get_printer()
        x_pos, y_pos = config.getfloatlist("home_xy_position", count=2)
        self.home_x_pos, self.home_y_pos = x_pos, y_pos
        self.x_hop = config.getfloat("x_hop", default=-10.0)
        self.y_hop = config.getfloat("y_hop", default=10.0)
        self.z_hop = config.getfloat("z_hop", default=0.0)
        self.z_hop_speed = config.getfloat('z_hop_speed', 15., above=0.)
        self.xy_hop_speed = config.getfloat('xy_hop_speed', 50., above=0.)
        self.max_x = config.getsection('stepper_x').getfloat('position_max', default=100, minval=100, maxval=800)
        self.max_y = config.getsection('stepper_y').getfloat('position_max', default=100, minval=100, maxval=800)
        self.max_z = config.getsection('stepper_z').getfloat('position_max', default=100, minval=60, maxval=800)
        self.end_position_x = config.getsection('stepper_x').getfloat('position_endstop', default=0, minval=-20, maxval=800)
        self.end_position_y = config.getsection('stepper_y').getfloat('position_endstop', default=0, minval=-20, maxval=800)
        self.speed = config.getfloat('move_speed', 50.0, above=0.)
        self.move_dist = config.getfloat('z_move_dist', 10.0, above=0.)
        self.move_to_previous = config.getboolean('move_to_previous', False)
        self.printer.load_object(config, 'homing')
        self.gcode = self.printer.lookup_object('gcode')
        self.prev_G28 = self.gcode.register_command("G28", None)
        self.gcode.register_command("G28", self.cmd_G28)
        pass


    def cmd_G28(self, gcmd):
        toolhead = self.printer.lookup_object('toolhead')

        self.gcode.run_script_from_command('SET_TMC_FIELD STEPPER=stepper_x FIELD=en_spreadcycle VALUE=0')
        self.gcode.run_script_from_command('SET_TMC_FIELD STEPPER=stepper_y FIELD=en_spreadcycle VALUE=0')
        self.gcode.run_script_from_command('SET_TMC_FIELD STEPPER=stepper_z FIELD=en_spreadcycle VALUE=0')
        self.gcode.run_script_from_command('M220 S100')
        self.gcode.run_script_from_command('BED_MESH_SAVE')
        self.gcode.run_script_from_command('BED_MESH_CLEAR')

        if self.z_hop != 0.0:
            curtime = self.printer.get_reactor().monotonic()
            kin_status = toolhead.get_kinematics().get_status(curtime)
            pos = toolhead.get_position()

            if ('x' not in kin_status['homed_axes']) and ('y' not in kin_status['homed_axes']):
                self.gcode.respond_info("x and y not in homed", log=False)
                print_stats = self.printer.lookup_object('print_stats', None)
                if print_stats.power_loss == 1:
                    pos[0] = 0.
                    pos[1] = 0.
                    pos[2] = 0.
                    toolhead.set_position(pos, homing_axes=[2])
                    toolhead.manual_move([None, None, self.z_hop], self.z_hop_speed)
                    self.gcode.respond_info("print stats is power_loss", log=False)
                else:
                    self.gcode.run_script_from_command('STEPPER_Z_SENEORLESS MOVE_DIST=%d' % self.move_dist)
                    self.gcode.respond_info("print stats is normal", log=False)

                toolhead.dwell(.200)
                if hasattr(toolhead.get_kinematics(), "note_z_not_homed"):
                    toolhead.get_kinematics().note_z_not_homed()
                pos = toolhead.get_position()
                pos[0] = 50.
                pos[1] = 50.
                pos[2] = 0.
                toolhead.set_position(pos, homing_axes=(0, 1, 2))
                toolhead.manual_move([50.0 + self.x_hop, 50.0 + self.y_hop, None], self.xy_hop_speed)
                toolhead.dwell(.200)
                toolhead.manual_move([pos[0] - self.x_hop / 2, pos[1] - self.y_hop / 2, None], self.xy_hop_speed)
                toolhead.set_position([0., 0., 0., pos[3]], homing_axes=(0, 1, 2))
                if hasattr(toolhead.get_kinematics(), "note_xy_not_homed"):
                        toolhead.get_kinematics().note_xy_not_homed()  
                if hasattr(toolhead.get_kinematics(), "note_z_not_homed"):
                        toolhead.get_kinematics().note_z_not_homed()    
                toolhead.dwell(1.0)      

            elif ('z' in kin_status['homed_axes']) and (pos[2] < self.z_hop):
                self.gcode.respond_info("z in homed", log=False)
                # If the Z axis is homed, and below z_hop, lift it to z_hop
                toolhead.manual_move([None, None, self.z_hop],
                                        self.z_hop_speed)
            elif 'z' not in kin_status['homed_axes']:
                self.gcode.respond_info("z not in homed", log=False)
                # Always perform the z_hop if the Z axis is not homed
                pos[2] = 0
                toolhead.set_position(pos, homing_axes=[2])
                if hasattr(toolhead.get_kinematics(), "note_z_not_homed"):
                        toolhead.get_kinematics().note_z_not_homed()

        need_x, need_y, need_z = [gcmd.get(axis, None) is not None
                                  for axis in "XYZ"]
        if not need_x and not need_y and not need_z:
            need_x = need_y = need_z = True
        if need_z:
            if ('x' not in kin_status['homed_axes']) and (not need_x):
                need_x = True
            if ('y' not in kin_status['homed_axes']) and (not need_y):
                need_y = True

        new_params = {}
        if need_x:
            self.gcode.respond_info("needx1 is perform", log=False)
            curtime = self.printer.get_reactor().monotonic()
            kin_status = toolhead.get_kinematics().get_status(curtime)
            pos = toolhead.get_position()
            if ('x' in kin_status['homed_axes']) and (abs(round(pos[0]) - self.end_position_x) < 10):
                if pos[0] < self.end_position_x:
                    pos[0] = self.end_position_x - 10
                else:
                    pos[0] = self.end_position_x + 10
                toolhead.manual_move([pos[0], None, None], self.xy_hop_speed)
                toolhead.dwell(1.0)
            if ('y' in kin_status['homed_axes']) and (pos[1] > (self.max_y - 50)):
                toolhead.manual_move([None, self.max_y - 50, None], self.xy_hop_speed)
                toolhead.dwell(1.0)
            new_params['X'] = '0'
            g28_gcmd = self.gcode.create_gcode_command("G28", "G28", new_params)
            self.prev_G28(g28_gcmd)
            curtime = self.printer.get_reactor().monotonic()
            kin_status = toolhead.get_kinematics().get_status(curtime)
            pos = toolhead.get_position()
            if self.max_x == self.end_position_x:
                toolhead.manual_move([pos[0] - 10, None, None], self.xy_hop_speed)
            else:
                toolhead.manual_move([pos[0] + 10, None, None], self.xy_hop_speed)

        y_params = {}
        if need_y:
            if need_x:
                toolhead.dwell(2.0)
            self.gcode.respond_info("needy1 is perform", log=False)
            curtime = self.printer.get_reactor().monotonic()
            kin_status = toolhead.get_kinematics().get_status(curtime)
            pos = toolhead.get_position()
            if ('y' in kin_status['homed_axes']) and (abs(round(pos[1]) - self.end_position_y) < 10):
                if pos[1] < self.end_position_y:
                    pos[1] = self.end_position_y - 10
                else:
                    pos[1] = self.end_position_y + 10
                toolhead.manual_move([None, pos[1], None], self.xy_hop_speed)
                toolhead.dwell(1.0)
            y_params['Y'] = '0'
            g28_gcmd = self.gcode.create_gcode_command("G28", "G28", y_params)
            self.prev_G28(g28_gcmd)
            curtime = self.printer.get_reactor().monotonic()
            kin_status = toolhead.get_kinematics().get_status(curtime)
            pos = toolhead.get_position()
            if self.max_y == self.end_position_y:
                toolhead.manual_move([None, pos[1] - 10, None], self.xy_hop_speed)
            else:
                toolhead.manual_move([None, pos[1] + 10, None], self.xy_hop_speed)
        
        if need_x:
            if need_y:
                toolhead.dwell(2.0)
            self.gcode.respond_info("needx2 is perform", log=False)
            curtime = self.printer.get_reactor().monotonic()
            kin_status = toolhead.get_kinematics().get_status(curtime)
            pos = toolhead.get_position()
            new_params['X'] = '0'
            g28_gcmd = self.gcode.create_gcode_command("G28", "G28", new_params)
            self.prev_G28(g28_gcmd)
            curtime = self.printer.get_reactor().monotonic()
            kin_status = toolhead.get_kinematics().get_status(curtime)
            pos = toolhead.get_position()
            toolhead.manual_move([pos[0] - 10, None, None], self.xy_hop_speed)
        
        if need_y:
            if need_x:
                toolhead.dwell(2.0)
            self.gcode.respond_info("needy2 is perform", log=False)
            y_params['Y'] = '0'
            g28_gcmd = self.gcode.create_gcode_command("G28", "G28", y_params)
            self.prev_G28(g28_gcmd)
            curtime = self.printer.get_reactor().monotonic()
            kin_status = toolhead.get_kinematics().get_status(curtime)
            pos = toolhead.get_position()
            toolhead.manual_move([None, pos[1] + 10, None], self.xy_hop_speed)

        # Home Z axis if necessary
        if need_z:
            # Throw an error if X or Y are not homed
            self.gcode.respond_info("needz is perform", log=False)
            self.gcode.run_script_from_command('G90')
            curtime = self.printer.get_reactor().monotonic()
            kin_status = toolhead.get_kinematics().get_status(curtime)
            if ('x' not in kin_status['homed_axes'] or
                'y' not in kin_status['homed_axes']):
                raise gcmd.error("Must home X and Y axes first")
            # Move to safe XY homing position
            prevpos = toolhead.get_position()
            toolhead.manual_move([self.home_x_pos, self.home_y_pos, None], self.speed)
            # Home Z
            g28_gcmd = self.gcode.create_gcode_command("G28", "G28", {'Z': '0'})
            self.prev_G28(g28_gcmd)
            # Perform Z Hop again for pressure-based probes
            if self.z_hop:
                pos = toolhead.get_position()
                if pos[2] < self.z_hop:
                    toolhead.manual_move([None, None, self.z_hop],
                                         self.z_hop_speed)
            # Move XY back to previous positions
            if self.move_to_previous:
                toolhead.manual_move(prevpos[:2], self.speed)
                
        self.gcode.run_script_from_command('BED_MESH_RESTORE')

def load_config(config):
    return CUSTOM_HOMING(config)


# [custom_homing]
# home_xy_position: 110,110
# x_hop: -10
# y_hop: 10
# xy_hop_speed: 50
# move_speed: 50.0
# z_hop: 3.0        //这个变量尤其注意，需要和断电续打时Z轴向下移动的数据保持一致
# z_hop_speed: 5.0
# z_move_dist: 15
