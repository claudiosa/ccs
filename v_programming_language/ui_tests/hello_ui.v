import ui
import time

fn main() {
	mut t_init := time.now()
	for {
		//println('\t: ${time.now() - t_init} ms')
		ui.message_box((time.now() - t_init).str())
		time.sleep(10 * time.millisecond)
	}
	ui.message_box('Hello World')
	
}