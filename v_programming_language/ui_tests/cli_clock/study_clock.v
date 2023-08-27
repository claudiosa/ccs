import time
// This example demonstrates how to use `v watch` for simple CLI apps.

fn main() {
	println('Run with: `v watch run study_time.v')
	println('')
	mut t_init := time.now()
	for {
		println('\t: ${time.now() - t_init} ms')
		time.sleep(10 * time.millisecond)
	}
}
