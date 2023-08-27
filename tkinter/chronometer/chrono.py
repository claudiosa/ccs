

# importing whole module
from tkinter import *
from tkinter.ttk import *
 
# importing strftime function to
# retrieve system's time
from time import strftime

from datetime import datetime

canvas = Tk()
canvas.title("Digital Clock")
canvas.geometry("600x200")
canvas.resizable(1,1)
label = Label(canvas, font=("Courier", 60, 'bold'), bg="blue", fg="yellow", bd =30)


label.grid(row = 0, column=1)


#date_format_str = '%d/%m/%Y %H:%M:%S'
hour_format_str = '%H:%M:%S'
# Get current time in local timezone
t_i = datetime.now()
'''
t_i=time.strftime("%H:%M:%S")
string=tt.strftime("%H:%M:%S")
display=string
'''
def digitalclock(t_i):
    #t_current =  time.strftime("%H:%M:%S")
    contador = 0
    while  contador < 50:
        t_current = datetime.now()
        dif_time = t_current - t_i 
        #start = datetime.strftime(t_i, hour_format_str)
        #end =   datetime.strftime(t_current, hour_format_str)
        #dif_time = (end - start)
        #text_input = dif_time.strftime("%H:%M:%S")
        #
        '''
        time.strftime("%H:%M:%S")
        '''
        #label.config(text=text_input)
        label.config(text=dif_time)
        label.after(200, digitalclock)
        contador += 1


digitalclock(t_i)

canvas.mainloop()