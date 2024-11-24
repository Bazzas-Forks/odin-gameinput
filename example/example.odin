package main

import "base:runtime"
import "core:fmt"
import win "core:sys/windows"
import gameinput ".."

main :: proc() {
	gi: ^gameinput.IGameInput
	assert(gameinput.Create(&gi) == 0)

	fmt.println("GameInput timestamp:", gi->GetCurrentTimestamp())

	// https://learn.microsoft.com/en-us/gaming/gdk/_content/gc/reference/input/gameinput/interfaces/igameinput/methods/igameinput_registerdevicecallback
	token: gameinput.CallbackToken

	hres := gi->RegisterDeviceCallback(
		   device          = nil,
		   inputKind       = {.Mouse, .Keyboard},
		   statusFilter    = {.Connected},
		   enumerationKind = .BlockingEnumeration,
		   ctx             = nil,
		   callbackFunc    = device_callback,
		   callbackToken   = &token
	)
	if win.FAILED(hres) {
		gi->UnregisterCallback(token, 5000)
	}
}

device_callback :: proc "stdcall" (
	callbackToken  : gameinput.CallbackToken,
	ctx            : rawptr,
	device         : ^gameinput.IDevice,
	timestamp      : u64,
	currentStatus  : gameinput.DeviceStatus,
	previousStatus : gameinput.DeviceStatus,
        ) {

        context = runtime.default_context()
        fmt.println(device->GetDeviceInfo()^)
}
