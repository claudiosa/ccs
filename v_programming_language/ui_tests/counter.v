import ui
import gx
import math
import time

const (
	win_width  = 400
	win_height = 400
)

[heap]
struct App {
mut:
	counter string = '0'
}

fn main() {
	mut app := &App{}
	window := ui.window(
		width: win_width
		height: win_height
		title: 'Chronometer'
		mode: .resizable
		layout: ui.column(
			spacing: 10
			margin_: 10
			widths: ui.stretch
			heights: ui.stretch
			children: [
				ui.textbox(
					max_len: 20
					height: 60
					read_only: true
					is_numeric: true
					text: &app.counter
					//color: green
					//border_color: gx.dark_green
				),

				ui.button(
					text: 'Horas'
					bg_color: gx.dark_green
					radius: 5
					border_color: gx.gray
					on_click: app.btn_click_0
				),
				ui.button(
					text: 'Count'
					bg_color: gx.light_gray
					radius: 5
					border_color: gx.gray
					on_click: app.btn_click
				),
			]
		)
	)
	ui.run(window)
}

//BOTAO
fn (mut app App) btn_click(btn &ui.Button) {
	//set_text('0')
	app.counter = (app.counter.int() + 1).str()
}


fn (mut app App) btn_click_0(btn &ui.Button) {
	//app.counter = (app.counter.int() - 10).str()
	
	app.counter = time.now().str()
}




/*
fn (mut app App) on_reset(button &ui.Button) {
	app.elapsed_time = 0.0
	//spawn app.timer()
}


fn (mut app App) on_start(button &ui.Button) {
	app.elapsed_time = 0.0
	//spawn app.timer()
}
*/


