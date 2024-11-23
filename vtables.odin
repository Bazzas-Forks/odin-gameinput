// Odin bindings for Microsoft GameInput SDK
// by Courtney Strachan <courtney.strachan@gmail.com>
// Github Link: [odin-gameinput](https://github.com/cstrachan88/odin-gameinput)

package game_input

import win "core:sys/windows"

IGameInput_UUID_STRING :: "11BE2A7E-4254-445A-9C09-FFC40F006918"
IGameInput_UUID := &win.IID{0x11be2a7e, 0x4254, 0x445a, {0x9c, 0x09, 0xff, 0xc4, 0x0f, 0x00, 0x69, 0x18}}
IGameInput_VTable :: struct {
	using iUnknown_vtable:          win.IUnknownVtbl,
	GetCurrentTimestamp:            proc "system" (this: ^IGameInput) -> u64,
	GetCurrentReading:              proc "system" (this: ^IGameInput, inputKind: Kind, device: ^IDevice, reading: ^^IReading) -> win.HRESULT,
	GetNextReading:                 proc "system" (this: ^IGameInput, referenceReading: ^IReading, inputKind: Kind, device: ^IDevice, reading: ^^IReading) -> win.HRESULT,
	GetPreviousReading:             proc "system" (this: ^IGameInput, referenceReading: ^IReading, inputKind: Kind, device: ^IDevice, reading: ^^IReading) -> win.HRESULT,
	GetTemporalReading:             proc "system" (this: ^IGameInput, timestamp: u64, device: ^IDevice, reading: ^^IReading) -> win.HRESULT,
	RegisterReadingCallback:        proc "system" (this: ^IGameInput, device: ^IDevice, inputKind: Kind, analogThreshold: f32, ctx: rawptr, callbackFunc: ReadingCallback, callbackToken: ^CallbackToken) -> win.HRESULT,
	RegisterDeviceCallback:         proc "system" (this: ^IGameInput, device: ^IDevice, inputKind: Kind, statusFilter: DeviceStatus, enumerationKind: EnumerationKind, ctx: rawptr, callbackFunc: DeviceCallback, callbackToken: ^CallbackToken) -> win.HRESULT,
	RegisterGuideButtonCallback:    proc "system" (this: ^IGameInput, device: ^IDevice, ctx: rawptr, callbackFunc: GuideButtonCallback, callbackToken: ^CallbackToken) -> win.HRESULT,
	RegisterKeyboardLayoutCallback: proc "system" (this: ^IGameInput, device: ^IDevice, ctx: rawptr, callbackFunc: KeyboardLayoutCallback, callbackToken: ^CallbackToken) -> win.HRESULT,
	StopCallback:                   proc "system" (this: ^IGameInput, callbackToken: CallbackToken),
	UnregisterCallback:             proc "system" (this: ^IGameInput, callbackToken: CallbackToken, timeoutInMicroseconds: u64) -> bool,
	CreateDispatcher:               proc "system" (this: ^IGameInput, dispatcher: ^^IDispatcher) -> win.HRESULT,
	CreateAggregateDevice:          proc "system" (this: ^IGameInput, inputKind: Kind, device: ^^IDevice) -> win.HRESULT,
	FindDeviceFromId:               proc "system" (this: ^IGameInput, value: ^APP_LOCAL_DEVICE_ID, device: ^^IDevice) -> win.HRESULT,
	FindDeviceFromObject:           proc "system" (this: ^IGameInput, value: ^win.IUnknown, device: ^^IDevice) -> win.HRESULT,
	FindDeviceFromPlatformHandle:   proc "system" (this: ^IGameInput, value: win.HANDLE, device: ^^IDevice) -> win.HRESULT,
	FindDeviceFromPlatformString:   proc "system" (this: ^IGameInput, value: win.LPCWSTR, device: ^^IDevice) -> win.HRESULT,
	EnableOemDeviceSupport:         proc "system" (this: ^IGameInput, vendorId: u16, productId: u16, interfaceNumber: u8, collectionNumber: u8) -> win.HRESULT,
	SetFocusPolicy:                 proc "system" (this: ^IGameInput, policy: FocusPolicy),
}

IReading_UUID_STRING :: "2156947A-E1FA-4DE0-A30B-D812931DBD8D"
IReading_UUID := &win.IID{0x2156947a, 0xe1fa, 0x4de0, {0xa3, 0x0b, 0xd8, 0x12, 0x93, 0x1d, 0xbd, 0x8d}}
IReading_VTable :: struct {
	using iUnknown_vtable:    win.IUnknownVtbl,
	GetInputKind:             proc "system" (this: ^IReading) -> Kind,
	GetSequenceNumber:        proc "system" (this: ^IReading, inputKind: Kind) -> u64,
	GetTimestamp:             proc "system" (this: ^IReading) -> u64,
	GetDevice:                proc "system" (this: ^IReading, device: ^^IDevice),
	GetRawReport:             proc "system" (this: ^IReading, report: ^^IRawDeviceReport) -> bool,
	GetControllerAxisCount:   proc "system" (this: ^IReading) -> u32,
	GetControllerAxisState:   proc "system" (this: ^IReading, stateArrayCount: u32, stateArray: [^]f32) -> u32,
	GetControllerButtonCount: proc "system" (this: ^IReading) -> u32,
	GetControllerButtonState: proc "system" (this: ^IReading, stateArrayCount: u32, stateArray: [^]bool) -> u32,
	GetControllerSwitchCount: proc "system" (this: ^IReading) -> u32,
	GetControllerSwitchState: proc "system" (this: ^IReading, stateArrayCount: u32, stateArray: [^]SwitchPosition) -> u32,
	GetKeyCount:              proc "system" (this: ^IReading) -> u32,
	GetKeyState:              proc "system" (this: ^IReading, stateArrayCount: u32, stateArray: [^]KeyState) -> u32,
	GetMouseState:            proc "system" (this: ^IReading, state: ^MouseState) -> bool,
	GetTouchCount:            proc "system" (this: ^IReading) -> u32,
	GetTouchState:            proc "system" (this: ^IReading, stateArrayCount: u32, stateArray: [^]TouchState) -> u32,
	GetMotionState:           proc "system" (this: ^IReading, state: ^MotionState) -> bool,
	GetArcadeStickState:      proc "system" (this: ^IReading, state: ^ArcadeStickState) -> bool,
	GetFlightStickState:      proc "system" (this: ^IReading, state: ^FlightStickState) -> bool,
	GetGamepadState:          proc "system" (this: ^IReading, state: ^GamepadState) -> bool,
	GetRacingWheelState:      proc "system" (this: ^IReading, state: ^RacingWheelState) -> bool,
	GetUiNavigationState:     proc "system" (this: ^IReading, state: ^UiNavigationState) -> bool,
}

IDevice_UUID_STRING :: "31DD86FB-4C1B-408A-868F-439B3CD47125"
IDevice_UUID := &win.IID{0x31dd86fb, 0x4c1b, 0x408a, {0x86, 0x8f, 0x43, 0x9b, 0x3c, 0xd4, 0x71, 0x25}}
IDevice_VTable :: struct {
	using iunknown_vtable:           win.IUnknownVtbl,
	GetDeviceInfo:                   proc "system" (this: ^IDevice) -> ^DeviceInfo,
	GetDeviceStatus:                 proc "system" (this: ^IDevice) -> DeviceStatus,
	GetBatteryState:                 proc "system" (this: ^IDevice, state: ^BatteryState),
	CreateForceFeedbackEffect:       proc "system" (this: ^IDevice, motorIndex: u32, params: [^]ForceFeedbackParams, effect: ^^IForceFeedbackEffect) -> win.HRESULT,
	IsForceFeedbackMotorPoweredOn:   proc "system" (this: ^IDevice, motorIndex: u32) -> bool,
	SetForceFeedbackMotorGain:       proc "system" (this: ^IDevice, motorIndex: u32, masterGain: f32),
	SetHapticMotorState:             proc "system" (this: ^IDevice, motorIndex: u32, params: [^]HapticFeedbackParams) -> win.HRESULT,
	SetRumbleState:                  proc "system" (this: ^IDevice, params: [^]RumbleParams),
	SetInputSynchronizationState:    proc "system" (this: ^IDevice, enabled: bool),
	SendInputSynchronizationHint:    proc "system" (this: ^IDevice),
	PowerOff:                        proc "system" (this: ^IDevice),
	CreateRawDeviceReport:           proc "system" (this: ^IDevice, reportId: u32, reportKind: RawDeviceReportKind, report: ^^IRawDeviceReport) -> win.HRESULT,
	GetRawDeviceFeature:             proc "system" (this: ^IDevice, reportId: u32, report: ^^IRawDeviceReport) -> win.HRESULT,
	SetRawDeviceFeature:             proc "system" (this: ^IDevice, report: ^IRawDeviceReport) -> win.HRESULT,
	SendRawDeviceOutput:             proc "system" (this: ^IDevice, report: ^IRawDeviceReport) -> win.HRESULT,
	SendRawDeviceOutputWithResponse: proc "system" (this: ^IDevice, requestReport: ^IRawDeviceReport, responseReport: ^^IRawDeviceReport) -> win.HRESULT,
	ExecuteRawDeviceIoControl:       proc "system" (this: ^IDevice, controlCode: u32, inputBufferSize: win.size_t, inputBuffer: rawptr, outputBufferSize: win.size_t, outputBuffer: rawptr, outputSize: ^win.size_t) -> win.HRESULT, // TODO: make sure this works for output buffer
	AcquireExclusiveRawDeviceAccess: proc "system" (this: ^IDevice, timeoutInMicroseconds: u64) -> bool,
	ReleaseExclusiveRawDeviceAccess: proc "system" (this: ^IDevice),
}

IDispatcher_UUID_STRING :: "415EED2E-98CB-42C2-8F28-B94601074E31"
IDispatcher_UUID := &win.IID{0x415eed2e, 0x98cb, 0x42c2, {0x8f, 0x28, 0xb9, 0x46, 0x01, 0x07, 0x4e, 0x31}}
IDispatcher_VTable :: struct {
	using iunknown_vtable: win.IUnknownVtbl,
	Dispatch:              proc "system" (this: ^IDispatcher, quotaInMicroseconds: u64) -> bool,
	OpenWaitHandle:        proc "system" (this: ^IDispatcher, waitHandle: ^win.HANDLE) -> win.HRESULT,
}

IForceFeedbackEffect_UUID_STRING :: "51BDA05E-F742-45D9-B085-9444AE48381D"
IForceFeedbackEffect_UUID := &win.IID{0x51bda05e, 0xf742, 0x45d9, {0xb0, 0x85, 0x94, 0x44, 0xae, 0x48, 0x38, 0x1d}}
IForceFeedbackEffect_VTable :: struct {
	using iunknown_vtable: win.IUnknownVtbl,
	GetDevice:             proc "system" (this: ^IForceFeedbackEffect, device: ^^IDevice),
	GetMotorIndex:         proc "system" (this: ^IForceFeedbackEffect) -> u32,
	GetGain:               proc "system" (this: ^IForceFeedbackEffect) -> f32,
	SetGain:               proc "system" (this: ^IForceFeedbackEffect, gain: f32),
	GetParams:             proc "system" (this: ^IForceFeedbackEffect, params: [^]ForceFeedbackParams), // _Out_ ForceFeedbackParams * params
	SetParams:             proc "system" (this: ^IForceFeedbackEffect, params: [^]ForceFeedbackParams) -> bool, // _In_ ForceFeedbackParams const * params
	GetState:              proc "system" (this: ^IForceFeedbackEffect) -> FeedbackEffectState,
	SetState:              proc "system" (this: ^IForceFeedbackEffect, state: FeedbackEffectState),
}

IRawDeviceReport_UUID_STRING :: "61F08CF1-1FFC-40CA-A2B8-E1AB8BC5B6DC"
IRawDeviceReport_UUID := &win.IID{0x61f08cf1, 0x1ffc, 0x40ca, {0xa2, 0xb8, 0xe1, 0xab, 0x8b, 0xc5, 0xb6, 0xdc}}
IRawDeviceReport_VTable :: struct {
	using iunknown_vtable: win.IUnknownVtbl,
	GetDevice:             proc "system" (this: ^IRawDeviceReport, device: ^^IDevice),
	GetReportInfo:         proc "system" (this: ^IRawDeviceReport) -> ^RawDeviceReportInfo,
	GetRawDataSize:        proc "system" (this: ^IRawDeviceReport) -> win.size_t,
	GetRawData:            proc "system" (this: ^IRawDeviceReport, bufferSize: win.size_t, buffer: rawptr) -> win.size_t, // _Out_writes_(bufferSize) void * buffer
	SetRawData:            proc "system" (this: ^IRawDeviceReport, bufferSize: win.size_t, buffer: rawptr) -> bool, // _In_reads_(bufferSize) void const * buffer
	GetItemValue:          proc "system" (this: ^IRawDeviceReport, itemIndex: u32, value: ^i64) -> bool,
	SetItemValue:          proc "system" (this: ^IRawDeviceReport, itemIndex: u32, value: i64) -> bool,
	ResetItemValue:        proc "system" (this: ^IRawDeviceReport, itemIndex: u32) -> bool,
	ResetAllItems:         proc "system" (this: ^IRawDeviceReport) -> bool,
}
