import time
import sys
import serial
import serial.tools.list_ports
import re
import threading
import dearpygui.dearpygui as dpg

ser_info_battery = int() # int from 0 to 100
ser_info_mode = int() # int that is either 0 (manual) or 1 (automatic)
ser_info_path = int() # int from 1 to 4

def init_serial_EFM8() -> tuple[serial.Serial, bool]:
    ser_mcu = serial.Serial()
    try:
        ser_mcu = serial.Serial(
            port='COM11',
            baudrate=115200,
            parity=serial.PARITY_NONE,
            stopbits=serial.STOPBITS_ONE,
            bytesize=serial.EIGHTBITS
        )

        ser_mcu.is_open
        return (ser_mcu, True)
    
    except serial.SerialException:
        return (ser_mcu, False)
    
def read_serial() -> bool:
    global ser_info_battery
    global ser_info_mode
    global ser_info_path

    ser_mcu.reset_input_buffer()
    ser_mcu_line = re.search(r'(\d+)\s(\d+)\s(\d+)', ser_mcu.readline().decode().strip().upper())
    
    if ser_mcu_line:
        try:
            ser_info_battery = int(ser_mcu_line.group(1))
            ser_info_mode = int(ser_mcu_line.group(2))
            ser_info_path = int(ser_mcu_line.group(3))
            #print(ser_mcu_line.group(1), ser_mcu_line.group(2), ser_mcu_line.group(3))

            return True
        
        except ValueError:
            return False
    else:
        return False

def thread_function_serial() -> None:
    if not read_serial():
        print("Failed to read serial data")
        
    threading.Timer(0.5, thread_function_serial).start()

ser_mcu, success = init_serial_EFM8()

if not success:
    print("Could not establish serial connection to EFM8 remote control")
    sys.exit(-1)

serial_thread = threading.Timer(0.0, thread_function_serial)
serial_thread.daemon = True

dpg.create_context()

with dpg.window(tag="tag_main_window", width=100, height=100):
    dpg.add_text(label="Battery:", tag="tag_info_battery")
    dpg.add_progress_bar(label="Battery: ", tag="tag_battery_bar", default_value=0, width=-1, overlay="0%")
    dpg.add_text(label="Mode: ", tag="tag_info_mode")
    dpg.add_text(label="Path: ", tag="tag_info_path")

dpg.create_viewport(title="RC Car Status Viewer", width=100, height=100)
dpg.set_primary_window("tag_main_window", True)
dpg.setup_dearpygui()
dpg.show_viewport()

serial_thread.start()

info_mode = str()
info_path = str()

while dpg.is_dearpygui_running():
    dpg.set_value("tag_info_battery", "Battery:")
    dpg.set_value("tag_battery_bar", ser_info_battery / 100.0)
    dpg.configure_item("tag_battery_bar", overlay=f"{ser_info_battery}%")

    #print(ser_info_battery, ser_info_mode, ser_info_path)
    
    if ser_info_mode == 0:
        info_mode = "Manual"
    elif ser_info_mode == 1:
        info_mode = "Automatic"
    else:
        info_mode = "Unknown"

    dpg.set_value("tag_info_mode", f"Mode: {info_mode}")

    if ser_info_path == 1:
        info_path = "1 (FLLFRLRS)"
    elif ser_info_path == 2:
        info_path = "2 (LRLRFFS)"
    elif ser_info_path == 3:
        info_path = "3 (RFRLRLFS)"
    elif ser_info_path == 4:
        info_path = "4 (Custom)"
    else:
        info_path = "Unknown"

    dpg.set_value("tag_info_path", f"Path: {info_path}")

    dpg.render_dearpygui_frame()

dpg.destroy_context()
sys.exit(0)