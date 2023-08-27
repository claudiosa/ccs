from tkinter import Tk, Label, Button, Frame, messagebox, Radiobutton, IntVar
from tkinter import ttk


class Chrono:

    def __init__(self, is_pause=False):
        self.seconds = 0
        self.process = None
        self.is_pause = is_pause
        self.max_time = 25 * 60
        self.timer_behaviour = False
        self.chronometer_behaviour = not self.timer_behaviour


class Gui:

    def __init__(self, title):
        self.root = Tk()
        self.root.title(title)
        self.root.resizable(0, 0)
        self.frame_cmd_button = Frame(self.root)
        self.frame_settings = Frame(self.root)
        self.frame_radio_button = Frame(self.frame_settings)
        self.time = Label(self.root, fg='black', width=20, font=("", "18"))
        self.time.grid(row=0, column=0, padx=2, pady=5)
        self.current_value_minutes = None
        self.current_value_seconds = None
        self.btnValidate = None
        self.radio_button_variable = IntVar(master=self.root, value=0)

        # Windows should stay in foreground
        self.root.call('wm', 'attributes', '.', '-topmost', '1')

    def create_radio_buttons(self):
        _radioButtonChronometer = Radiobutton(
            self.frame_radio_button,
            fg='grey',
            text='chronometer',
            command=change_to_chronometer_mode,
            variable=self.radio_button_variable,
            value=0
        ).grid(row=0, column=0, padx=2, pady=5, sticky="w")
        _radioButtonTime = Radiobutton(
            self.frame_radio_button,
            fg='grey',
            text='timer',
            command=change_to_timer_mode,
            variable=self.radio_button_variable,
            value=1
        ).grid(column=0, padx=2, pady=5, sticky="w")

    def create_main_window(self):
        self.time['text'] = "00:00:00"

        # Buttons declaration
        _btnStart = Button(
            self.frame_cmd_button,
            fg='green',
            text='Start',
            command=start_chronometer
        ).grid(row=1, column=0, padx=2, pady=5)
        _btnStop = Button(
            self.frame_cmd_button,
            fg='red',
            text='Stop',
            command=stop_chronometer
        ).grid(row=1, column=1, padx=2, pady=5)
        _btnResume = Button(
            self.frame_cmd_button,
            fg='blue',
            text='Reset',
            command=resume_chronometer
        ).grid(row=1, column=2, padx=2, pady=5)
        _btnInput = Button(
            self.frame_settings,
            fg='grey',
            text='Time settings',
            command=click_time_settings_window
        ).grid(row=0, column=2, padx=2, pady=5)

        # Separator declaration
        _separator_time_button = ttk.Separator(
            master=self.root,
            orient='horizontal',
        ).grid(row=1, column=0, ipadx=106, pady=3)

        _separator_button_setting = ttk.Separator(
            master=self.root,
            orient='horizontal',
        ).grid(row=3, column=0, ipadx=106, pady=3)

        _separator_radio_button_time_setting_button = ttk.Separator(
            master=self.frame_settings,
            orient='vertical',
        ).grid(row=0, column=1, ipady=30, padx=15)

        self.frame_cmd_button.grid(row=2, column=0, padx=2, pady=5)
        self.frame_settings.grid(row=4, column=0, padx=2, pady=5)
        self.frame_radio_button.grid(row=0, column=0, padx=2, pady=5)

        self.create_radio_buttons()

    def create_time_settings_window(self):
        frame_minutes_seconds = Frame(master=self.root)
        frame_minutes_seconds.grid(row=0, column=0)

        self.current_value_minutes = IntVar(master=frame_minutes_seconds, value=25)
        self.current_value_seconds = IntVar(master=frame_minutes_seconds, value=0)

        self.btnValidate = Button(
            self.root,
            fg='green',
            text='Go',
            command=get_value
        ).grid(row=1, column=0, padx=2, pady=5)

        spinbox_minutes = ttk.Spinbox(
            frame_minutes_seconds,
            from_=0,
            to=240,  # 4 hours it's enough
            textvariable=self.current_value_minutes,
            width=5
        )
        spinbox_minutes.grid(row=1, column=0, padx=4, pady=1, sticky='w')

        spinbox_seconds = ttk.Spinbox(
            frame_minutes_seconds,
            from_=0,
            to=59,
            textvariable=self.current_value_seconds,
            wrap=True,
            width=5
        )
        spinbox_seconds.grid(row=1, column=2, padx=4, pady=1, sticky='e')

        minutes_seconds_separator_label = Label(
            master=frame_minutes_seconds,
            fg='black',
            width=1,
            font=("", "18")
        )
        minutes_seconds_separator_label.grid(row=1, column=1, padx=2, pady=1)
        minutes_seconds_separator_label['text'] = ":"

        minutes_label = Label(
            master=frame_minutes_seconds,
            fg='black',
            width=6,
            font=("", "7")
        )
        minutes_label.grid(row=0, column=0, padx=2, pady=10, sticky="s")
        minutes_label['text'] = "minutes"

        seconds_label = Label(
            master=frame_minutes_seconds,
            fg='black',
            width=6,
            font=("", "7")
        )
        seconds_label.grid(row=0, column=2, padx=2, pady=10, sticky="s")
        seconds_label['text'] = "seconds"

    def main_loop(self):
        self.root.mainloop()


def display_time_in_mm_ss(time_in_seconds, max_time):
    timer_behaviour = my_chronometer.timer_behaviour
    if not timer_behaviour:
        time_to_display = max_time - time_in_seconds
        return '{:02d}:{:02d}'.format(time_to_display // 60, time_to_display % 60)
    else:
        time_to_display = time_in_seconds
        return '{:02d}:{:02d}'.format(time_to_display // 60, time_to_display % 60)


def reset_settings_ui():
    my_gui.frame_settings.grid_remove()
    my_gui.frame_settings = Frame(master=my_gui.root)
    my_gui.frame_radio_button.grid_remove()
    my_gui.frame_radio_button = Frame(master=my_gui.frame_settings)


def change_to_timer_mode():
    reset_settings_ui()
    my_gui.frame_cmd_button.grid(row=2, column=0, padx=2, pady=5)
    my_gui.frame_settings.grid(row=4, column=0, padx=2, pady=5)
    my_gui.frame_radio_button.grid(row=4, column=0, padx=2, pady=5)

    my_gui.create_radio_buttons()
    my_chronometer.timer_behaviour = True
    # Set max time to 4 hours
    my_chronometer.max_time = 4 * 60 * 60
    resume_chronometer()


def change_to_chronometer_mode():
    reset_settings_ui()
    my_gui.frame_settings.grid(row=4, column=0, padx=2, pady=5)
    _separator_radio_button_time_setting_button = ttk.Separator(
        master=my_gui.frame_settings,
        orient='vertical',
    ).grid(row=0, column=1, ipady=30, padx=15)
    _btnInput = Button(
        my_gui.frame_settings,
        fg='grey',
        text='Time settings',
        command=click_time_settings_window
    ).grid(row=0, column=2, padx=2, pady=5)

    my_gui.frame_radio_button.grid(row=0, column=0, padx=2, pady=5)
    my_gui.create_radio_buttons()

    # Set max time to 25 minutes
    my_chronometer.max_time = 25 * 60
    my_chronometer.timer_behaviour = False
    resume_chronometer()


def start_chronometer():
    try:
        stop_chronometer()
    except:
        pass
    my_chronometer.process = my_gui.time.after(1000, start_chronometer)
    my_chronometer.seconds += 1

    if my_chronometer.max_time <= my_chronometer.seconds:
        my_gui.time.config(fg="red", font=("", "16"))
        my_gui.time['text'] = "Time off!"
        stop_chronometer()
    else:
        my_gui.time.config(fg="black", font=("", "18"))
        my_gui.time['text'] = display_time_in_mm_ss(my_chronometer.seconds, my_chronometer.max_time)


def stop_chronometer():
    try:
        my_gui.time.after_cancel(my_chronometer.process)
    except:
        pass


def resume_chronometer():
    global my_gui
    stop_chronometer()
    my_chronometer.seconds = 0
    my_gui.time['text'] = display_time_in_mm_ss(my_chronometer.seconds, my_chronometer.max_time)


def get_value():
    global time_settings_window
    try:
        max_time = int(time_settings_window.current_value_minutes.get()) * 60 + \
                   int(time_settings_window.current_value_seconds.get())
    except:
        time_settings_window.root.withdraw()
        time_settings_window.root.deiconify()
        messagebox.showinfo('Error', 'format not correct\nCorrect format: xx:xx\nSet default time to 25 minutes')
        max_time = 25 * 60
        my_chronometer.max_time = max_time
        return
    my_chronometer.max_time = max_time
    time_settings_window.root.destroy()
    resume_chronometer()


def click_time_settings_window():
    global time_settings_window
    time_settings_window = Gui(title='time setting')
    time_settings_window.create_time_settings_window()


if __name__ == "__main__":
    my_chronometer = Chrono()
    time_settings_window = None
    my_gui = Gui(title='chronometer')
    my_gui.create_main_window()
    my_gui.main_loop()
