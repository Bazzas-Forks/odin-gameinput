// Odin bindings for Microsoft GameInput SDK
// by Courtney Strachan <courtney.strachan@gmail.com>
// Github Link: [odin-gameinput](https://github.com/cstrachan88/odin-gameinput)

package game_input

import win "core:sys/windows"

#assert(ODIN_OS == .Windows)
#assert(ODIN_ARCH == .amd64)

// From windef.h
APP_LOCAL_DEVICE_ID_SIZE :: 32
APP_LOCAL_DEVICE_ID :: struct {
	value: [APP_LOCAL_DEVICE_ID_SIZE]u8,
}

/* ========================================================================= */
/*                                GameInput.h                                */
/* ========================================================================= */
// Microsoft.GameInput 0.2303.22621.3038
// https://www.nuget.org/packages/Microsoft.GameInput

foreign import lib "GameInput/GameInput.lib"

Kind :: distinct bit_set[Kind_FLAG;u32]
Kind_FLAG :: enum {
	RawDeviceReport  = 0,
	ControllerAxis   = 1,
	ControllerButton = 2,
	ControllerSwitch = 3,
	Keyboard         = 4,
	Mouse            = 5,
	Touch            = 8,
	Motion           = 12,
	ArcadeStick      = 16,
	FlightStick      = 17,
	Gamepad          = 18,
	RacingWheel      = 19,
	UiNavigation     = 24,
}
// Unknown          = 0x00000000,
// Controller       = 0x0000000E,
KIND_CONTROLLER :: Kind{.ControllerAxis, .ControllerButton, .ControllerSwitch}

EnumerationKind :: enum {
	NoEnumeration       = 0,
	AsyncEnumeration    = 1,
	BlockingEnumeration = 2,
}

FocusPolicy :: distinct bit_set[FocusPolicy_FLAG;u32]
FocusPolicy_FLAG :: enum {
	DisableBackgroundInput   = 0,
	ExclusiveForegroundInput = 1,
}
// DefaultFocusPolicy       = 0x00000000,

SwitchKind :: enum {
	Unknown      = -1,
	_2Way        = 0,
	_4Way        = 1,
	_8Way        = 2,
}

SwitchPosition :: enum {
	Center    = 0,
	Up        = 1,
	UpRight   = 2,
	Right     = 3,
	DownRight = 4,
	Down      = 5,
	DownLeft  = 6,
	Left      = 7,
	UpLeft    = 8,
}

KeyboardKind :: enum {
	Unknown = -1,
	Ansi    = 0,
	Iso     = 1,
	Ks      = 2,
	Abnt    = 3,
	Jis     = 4,
}

MouseButtons :: distinct bit_set[MouseButtons_FLAG;u32]
MouseButtons_FLAG :: enum {
	LeftButton     = 0,
	RightButton    = 1,
	MiddleButton   = 2,
	Button4        = 3,
	Button5        = 4,
	WheelTiltLeft  = 5,
	WheelTiltRight = 6,
}
// MouseNone           = 0x00000000,

TouchShape :: enum {
	Unknown       = -1,
	Point         = 0,
	_1DLinear      = 1,
	_1DRadial      = 2,
	_1DIrregular   = 3,
	_2DRectangular = 4,
	_2DElliptical  = 5,
	_2DIrregular   = 6,
}

MotionAccuracy :: enum {
	Unknown         = -1,
	Unavailable     = 0,
	Unreliable      = 1,
	Approximate     = 2,
	Accurate        = 3,
}

ArcadeStickButtons :: distinct bit_set[ArcadeStickButtons_FLAG;u32]
ArcadeStickButtons_FLAG :: enum {
	Menu     = 0,
	View     = 1,
	Up       = 2,
	Down     = 3,
	Left     = 4,
	Right    = 5,
	Action1  = 6,
	Action2  = 7,
	Action3  = 8,
	Action4  = 9,
	Action5  = 10,
	Action6  = 11,
	Special1 = 12,
	Special2 = 13,
}
// ArcadeStickNone     = 0x00000000,

FlightStickButtons :: distinct bit_set[FlightStickButtons_FLAG;u32]
FlightStickButtons_FLAG :: enum {
	Menu          = 0,
	View          = 1,
	FirePrimary   = 2,
	FireSecondary = 3,
}
// FlightStickNone          = 0x00000000,

GamepadButtons :: distinct bit_set[GamepadButtons_FLAG;u32]
GamepadButtons_FLAG :: enum {
	Menu            = 0,
	View            = 1,
	A               = 2,
	B               = 3,
	X               = 4,
	Y               = 5,
	DPadUp          = 6,
	DPadDown        = 7,
	DPadLeft        = 8,
	DPadRight       = 9,
	LeftShoulder    = 10,
	RightShoulder   = 11,
	LeftThumbstick  = 12,
	RightThumbstick = 13,
}
// GamepadNone            = 0x00000000,

RacingWheelButtons :: distinct bit_set[RacingWheelButtons_FLAG;u32]
RacingWheelButtons_FLAG :: enum {
	Menu         = 0,
	View         = 1,
	PreviousGear = 2,
	NextGear     = 3,
	DpadUp       = 4,
	DpadDown     = 5,
	DpadLeft     = 6,
	DpadRight    = 7,
}
// RacingWheelNone         = 0x00000000,

UiNavigationButtons :: distinct bit_set[UiNavigationButtons_FLAG;u32]
UiNavigationButtons_FLAG :: enum {
	Menu        = 0,
	View        = 1,
	Accept      = 2,
	Cancel      = 3,
	Up          = 4,
	Down        = 5,
	Left        = 6,
	Right       = 7,
	Context1    = 8,
	Context2    = 9,
	Context3    = 10,
	Context4    = 11,
	PageUp      = 12,
	PageDown    = 13,
	PageLeft    = 14,
	PageRight   = 15,
	ScrollUp    = 16,
	ScrollDown  = 17,
	ScrollLeft  = 18,
	ScrollRight = 19,
}
// UiNavigationNone        = 0x00000000,

DeviceStatus :: distinct bit_set[DeviceStatus_FLAG;u32]
DeviceStatus_FLAG :: enum {
	Connected     = 0,
	InputEnabled  = 1,
	OutputEnabled = 2,
	RawIoEnabled  = 3,
	AudioCapture  = 4,
	AudioRender   = 5,
	Synchronized  = 6,
	Wireless      = 7,
	UserIdle      = 20,
}
// DeviceNoStatus      = 0x00000000,
// DeviceAnyStatus     = 0x00FFFFFF,
DEVICE_ANY_STATUS := transmute(DeviceStatus)u32(0x00FFFFFF)
// FIXME

BatteryStatus :: enum {
	Unknown     = -1,
	NotPresent  = 0,
	Discharging = 1,
	Idle        = 2,
	Charging    = 3,
}

DeviceFamily :: enum {
	Virtual   = -1,
	Aggregate = 0,
	XboxOne   = 1,
	Xbox360   = 2,
	Hid       = 3,
	I8042     = 4,
}

DeviceCapabilities :: distinct bit_set[DeviceCapabilities_FLAG;u32]
DeviceCapabilities_FLAG :: enum {
	Audio           = 0,
	PluginModule    = 1,
	PowerOff        = 2,
	Synchronization = 3,
	Wireless        = 4,
}
// DeviceCapabilityNone            = 0x00000000,

RawDeviceReportKind :: enum {
	InputReport   = 0,
	OutputReport  = 1,
	FeatureReport = 2,
}

RawDeviceReportItemFlags :: distinct bit_set[RawDeviceReportItemFlags_FLAG;u32]
RawDeviceReportItemFlags_FLAG :: enum {
	Constant   = 0,
	Array      = 1,
	Relative   = 2,
	Wraparound = 3,
	Nonlinear  = 4,
	Stable     = 5,
	Nullable   = 6,
	Volatile   = 7,
	Buffered   = 8,
}
// DefaultItem    = 0x00000000,

RawDeviceItemCollectionKind :: enum {
	Unknown       = -1,
	Physical      = 0,
	Application   = 1,
	Logical       = 2,
	Report        = 3,
	NamedArray    = 4,
	UsageSwitch   = 5,
	UsageModifier = 6,
}

RawDevicePhysicalUnitKind :: enum {
	Unknown             = -1,
	None                = 0,
	Time                = 1,
	Frequency           = 2,
	Length              = 3,
	Velocity            = 4,
	Acceleration        = 5,
	Mass                = 6,
	Momentum            = 7,
	Force               = 8,
	Pressure            = 9,
	Angle               = 10,
	AngularVelocity     = 11,
	AngularAcceleration = 12,
	AngularMass         = 13,
	AngularMomentum     = 14,
	AngularTorque       = 15,
	ElectricCurrent     = 16,
	ElectricCharge      = 17,
	ElectricPotential   = 18,
	Energy              = 19,
	Power               = 20,
	Temperature         = 21,
	LuminousIntensity   = 22,
	LuminousFlux        = 23,
	Illuminance         = 24,
}

Label :: enum {
	Unknown                  = -1,
	None                     = 0,
	XboxGuide                = 1,
	XboxBack                 = 2,
	XboxStart                = 3,
	XboxMenu                 = 4,
	XboxView                 = 5,
	XboxA                    = 7,
	XboxB                    = 8,
	XboxX                    = 9,
	XboxY                    = 10,
	XboxDPadUp               = 11,
	XboxDPadDown             = 12,
	XboxDPadLeft             = 13,
	XboxDPadRight            = 14,
	XboxLeftShoulder         = 15,
	XboxLeftTrigger          = 16,
	XboxLeftStickButton      = 17,
	XboxRightShoulder        = 18,
	XboxRightTrigger         = 19,
	XboxRightStickButton     = 20,
	XboxPaddle1              = 21,
	XboxPaddle2              = 22,
	XboxPaddle3              = 23,
	XboxPaddle4              = 24,
	LetterA                  = 25,
	LetterB                  = 26,
	LetterC                  = 27,
	LetterD                  = 28,
	LetterE                  = 29,
	LetterF                  = 30,
	LetterG                  = 31,
	LetterH                  = 32,
	LetterI                  = 33,
	LetterJ                  = 34,
	LetterK                  = 35,
	LetterL                  = 36,
	LetterM                  = 37,
	LetterN                  = 38,
	LetterO                  = 39,
	LetterP                  = 40,
	LetterQ                  = 41,
	LetterR                  = 42,
	LetterS                  = 43,
	LetterT                  = 44,
	LetterU                  = 45,
	LetterV                  = 46,
	LetterW                  = 47,
	LetterX                  = 48,
	LetterY                  = 49,
	LetterZ                  = 50,
	Number0                  = 51,
	Number1                  = 52,
	Number2                  = 53,
	Number3                  = 54,
	Number4                  = 55,
	Number5                  = 56,
	Number6                  = 57,
	Number7                  = 58,
	Number8                  = 59,
	Number9                  = 60,
	ArrowUp                  = 61,
	ArrowUpRight             = 62,
	ArrowRight               = 63,
	ArrowDownRight           = 64,
	ArrowDown                = 65,
	ArrowDownLLeft           = 66,
	ArrowLeft                = 67,
	ArrowUpLeft              = 68,
	ArrowUpDown              = 69,
	ArrowLeftRight           = 70,
	ArrowUpDownLeftRight     = 71,
	ArrowClockwise           = 72,
	ArrowCounterClockwise    = 73,
	ArrowReturn              = 74,
	IconBranding             = 75,
	IconHome                 = 76,
	IconMenu                 = 77,
	IconCross                = 78,
	IconCircle               = 79,
	IconSquare               = 80,
	IconTriangle             = 81,
	IconStar                 = 82,
	IconDPadUp               = 83,
	IconDPadDown             = 84,
	IconDPadLeft             = 85,
	IconDPadRight            = 86,
	IconDialClockwise        = 87,
	IconDialCounterClockwise = 88,
	IconSliderLeftRight      = 89,
	IconSliderUpDown         = 90,
	IconWheelUpDown          = 91,
	IconPlus                 = 92,
	IconMinus                = 93,
	IconSuspension           = 94,
	Home                     = 95,
	Guide                    = 96,
	Mode                     = 97,
	Select                   = 98,
	Menu                     = 99,
	View                     = 100,
	Back                     = 101,
	Start                    = 102,
	Options                  = 103,
	Share                    = 104,
	Up                       = 105,
	Down                     = 106,
	Left                     = 107,
	Right                    = 108,
	LB                       = 109,
	LT                       = 110,
	LSB                      = 111,
	L1                       = 112,
	L2                       = 113,
	L3                       = 114,
	RB                       = 115,
	RT                       = 116,
	RSB                      = 117,
	R1                       = 118,
	R2                       = 119,
	R3                       = 120,
	P1                       = 121,
	P2                       = 122,
	P3                       = 123,
	P4                       = 124,
}

Location :: enum {
	Unknown  = -1,
	Chassis  = 0,
	Display  = 1,
	Axis     = 2,
	Button   = 3,
	Switch   = 4,
	Key      = 5,
	TouchPad = 6,
}

FeedbackAxes :: distinct bit_set[FeedbackAxes_FLAG;u32]
FeedbackAxes_FLAG :: enum {
	LinearX  = 0,
	LinearY  = 1,
	LinearZ  = 2,
	AngularX = 3,
	AngularY = 4,
	AngularZ = 5,
	Normal   = 6,
}
// FeedbackAxisNone     = 0x00000000,

FeedbackEffectState :: enum {
	Stopped = 0,
	Running = 1,
	Paused  = 2,
}

ForceFeedbackEffectKind :: enum {
	Constant         = 0,
	Ramp             = 1,
	SineWave         = 2,
	SquareWave       = 3,
	TriangleWave     = 4,
	SawtoothUpWave   = 5,
	SawtoothDownWave = 6,
	Spring           = 7,
	Friction         = 8,
	Damper           = 9,
	Inertia          = 10,
}

RumbleMotors :: distinct bit_set[RumbleMotors_FLAG;u32]
RumbleMotors_FLAG :: enum {
	LowFrequency  = 0,
	HighFrequency = 1,
	LeftTrigger   = 2,
	RightTrigger  = 3,
}
// RumbleNone          = 0x00000000,

IGameInput :: struct #raw_union {
	#subtype iUnknown       : win.IUnknown,
	using iGameInput_vtable : ^IGameInput_VTable,
}
IReading :: struct #raw_union {
	#subtype iUnknown     : win.IUnknown,
	using iReading_vtable : ^IReading_VTable,
}
IDevice :: struct #raw_union {
	#subtype iUnknown    : win.IUnknown,
	using iDevice_vtable : ^IDevice_VTable,
}
IDispatcher :: struct #raw_union {
	#subtype iUnknown        : win.IUnknown,
	using iDispatcher_vtable : ^IDispatcher_VTable,
}
IForceFeedbackEffect :: struct #raw_union {
	#subtype iUnknown                 : win.IUnknown,
	using iForceFeedbackEffect_vtable : ^IForceFeedbackEffect_VTable,
}
IRawDeviceReport :: struct #raw_union {
	#subtype iUnknown             : win.IUnknown,
	using iRawDeviceReport_vtable : ^IRawDeviceReport_VTable,
}

CallbackToken :: u64

CURRENT_CALLBACK_TOKEN_VALUE: win.c_ulonglong : 0xFFFFFFFFFFFFFFFF
INVALID_CALLBACK_TOKEN_VALUE: win.c_ulonglong : 0x0000000000000000

ReadingCallback :: #type proc "system" (
	callbackToken      : CallbackToken,
	ctx                : rawptr,
	reading            : ^IReading,
	hasOverrunOccurred : bool,
)

DeviceCallback :: #type proc "system" (
	callbackToken  : CallbackToken,
	ctx            : rawptr,
	device         : ^IDevice,
	timestamp      : u64,
	currentStatus  : DeviceStatus,
	previousStatus : DeviceStatus,
)

GuideButtonCallback :: #type proc "system" (
	callbackToken : CallbackToken,
	ctx           : rawptr,
	device        : ^IDevice,
	timestamp     : u64,
	isPressed     : bool,
)

KeyboardLayoutCallback :: #type proc "system" (
	callbackToken  : CallbackToken,
	ctx            : rawptr,
	device         : ^IDevice,
	timestamp      : u64,
	currentLayout  : u32,
	previousLayout : u32,
)

KeyState :: struct {
	scanCode   : u32,
	codePoint  : u32,
	virtualKey : u8,
	isDeadKey  : bool,
}

MouseState :: struct {
	buttons   : MouseButtons,
	positionX : i64,
	positionY : i64,
	wheelX    : i64,
	wheelY    : i64,
}

TouchState :: struct {
	touchId           : u64,
	sensorIndex       : u32,
	positionX         : f32,
	positionY         : f32,
	pressure          : f32,
	proximity         : f32,
	contactRectTop    : f32,
	contactRectLeft   : f32,
	contactRectRight  : f32,
	contactRectBottom : f32,
}

MotionState :: struct {
	accelerationX         : f32,
	accelerationY         : f32,
	accelerationZ         : f32,
	angularVelocityX      : f32,
	angularVelocityY      : f32,
	angularVelocityZ      : f32,
	magneticFieldX        : f32,
	magneticFieldY        : f32,
	magneticFieldZ        : f32,
	orientationW          : f32,
	orientationX          : f32,
	orientationY          : f32,
	orientationZ          : f32,
	accelerometerAccuracy : MotionAccuracy,
	gyroscopeAccuracy     : MotionAccuracy,
	magnetometerAccuracy  : MotionAccuracy,
	orientationAccuracy   : MotionAccuracy,
}

ArcadeStickState :: struct {
	buttons : ArcadeStickButtons,
}

FlightStickState :: struct {
	buttons   : FlightStickButtons,
	hatSwitch : SwitchPosition,
	roll      : f32,
	pitch     : f32,
	yaw       : f32,
	throttle  : f32,
}

GamepadState :: struct {
	buttons          : GamepadButtons,
	leftTrigger      : f32,
	rightTrigger     : f32,
	leftThumbstickX  : f32,
	leftThumbstickY  : f32,
	rightThumbstickX : f32,
	rightThumbstickY : f32,
}

RacingWheelState :: struct {
	buttons            : RacingWheelButtons,
	patternShifterGear : i32,
	wheel              : f32,
	throttle           : f32,
	brake              : f32,
	clutch             : f32,
	handbrake          : f32,
}

UiNavigationState :: struct {
	buttons : UiNavigationButtons,
}

BatteryState :: struct {
	chargeRate         : f32,
	maxChargeRate      : f32,
	remainingCapacity  : f32,
	fullChargeCapacity : f32,
	status             : BatteryStatus,
}

String :: struct {
	sizeInBytes    : u32,
	codePointCount : u32,
	data           : cstring,
}

Usage :: struct {
	page : u16,
	id   : u16,
}

Version :: struct {
	major    : u16,
	minor    : u16,
	build    : u16,
	revision : u16,
}

RawDeviceItemCollectionInfo :: struct {
	kind            : RawDeviceItemCollectionKind,
	childCount      : u32,
	siblingCount    : u32,
	usageCount      : u32,
	usages          : [^]Usage,
	parent          : ^RawDeviceItemCollectionInfo,
	firstSibling    : ^RawDeviceItemCollectionInfo,
	previousSibling : ^RawDeviceItemCollectionInfo,
	nextSibling     : ^RawDeviceItemCollectionInfo,
	lastSibling     : ^RawDeviceItemCollectionInfo,
	firstChild      : ^RawDeviceItemCollectionInfo,
	lastChild       : ^RawDeviceItemCollectionInfo,
}

RawDeviceReportItemInfo :: struct {
	bitOffset                : u32,
	bitSize                  : u32,
	logicalMin               : i64,
	logicalMax               : i64,
	physicalMin              : f64,
	physicalMax              : f64,
	physicalUnits            : RawDevicePhysicalUnitKind,
	rawPhysicalUnits         : u32,
	rawPhysicalUnitsExponent : i32,
	flags                    : RawDeviceReportItemFlags,
	usageCount               : u32,
	usages                   : [^]Usage,
	collection               : ^RawDeviceItemCollectionInfo,
	itemString               : ^String,
}

RawDeviceReportInfo :: struct {
	kind      : RawDeviceReportKind,
	id        : u32,
	size      : u32,
	itemCount : u32,
	items     : [^]RawDeviceReportItemInfo,
}

ControllerAxisInfo :: struct {
	mappedInputKinds  : Kind,
	label             : Label,
	isContinuous      : bool,
	isNonlinear       : bool,
	isQuantized       : bool,
	hasRestValue      : bool,
	restValue         : f32,
	resolution        : u64,
	legacyDInputIndex : u16,
	legacyHidIndex    : u16,
	rawReportIndex    : u32,
	inputReport       : ^RawDeviceReportInfo,
	inputReportItem   : ^RawDeviceReportItemInfo,
}

ControllerButtonInfo :: struct {
	mappedInputKinds  : Kind,
	label             : Label,
	legacyDInputIndex : u16,
	legacyHidIndex    : u16,
	rawReportIndex    : u32,
	inputReport       : ^RawDeviceReportInfo,
	inputReportItem   : ^RawDeviceReportItemInfo,
}

ControllerSwitchInfo :: struct {
	mappedInputKinds  : Kind,
	label             : Label,
	positionLabels    : [9]Label,
	kind              : SwitchKind,
	legacyDInputIndex : u16,
	legacyHidIndex    : u16,
	rawReportIndex    : u32,
	inputReport       : ^RawDeviceReportInfo,
	inputReportItem   : ^RawDeviceReportItemInfo,
}

KeyboardInfo :: struct {
	kind                : KeyboardKind,
	layout              : u32,
	keyCount            : u32,
	functionKeyCount    : u32,
	maxSimultaneousKeys : u32,
	platformType        : u32,
	platformSubtype     : u32,
	nativeLanguage      : ^String,
}

MouseInfo :: struct {
	supportedButtons : MouseButtons,
	sampleRate       : u32,
	sensorDpi        : u32,
	hasWheelX        : bool,
	hasWheelY        : bool,
}

TouchSensorInfo :: struct {
	mappedInputKinds : Kind,
	label            : Label,
	location         : Location,
	locationId       : u32,
	resolutionX      : u64,
	resolutionY      : u64,
	shape            : TouchShape,
	aspectRatio      : f32,
	orientation      : f32,
	physicalWidth    : f32,
	physicalHeight   : f32,
	maxPressure      : f32,
	maxProximity     : f32,
	maxTouchPoints   : u32,
}

MotionInfo :: struct {
	maxAcceleration          : f32,
	maxAngularVelocity       : f32,
	maxMagneticFieldStrength : f32,
}

ArcadeStickInfo :: struct {
	menuButtonLabel     : Label,
	viewButtonLabel     : Label,
	stickUpLabel        : Label,
	stickDownLabel      : Label,
	stickLeftLabel      : Label,
	stickRightLabel     : Label,
	actionButton1Label  : Label,
	actionButton2Label  : Label,
	actionButton3Label  : Label,
	actionButton4Label  : Label,
	actionButton5Label  : Label,
	actionButton6Label  : Label,
	specialButton1Label : Label,
	specialButton2Label : Label,
}

FlightStickInfo :: struct {
	menuButtonLabel          : Label,
	viewButtonLabel          : Label,
	firePrimaryButtonLabel   : Label,
	fireSecondaryButtonLabel : Label,
	hatSwitchKind            : SwitchKind,
}

GamepadInfo :: struct {
	menuButtonLabel            : Label,
	viewButtonLabel            : Label,
	aButtonLabel               : Label,
	bButtonLabel               : Label,
	xButtonLabel               : Label,
	yButtonLabel               : Label,
	dpadUpLabel                : Label,
	dpadDownLabel              : Label,
	dpadLeftLabel              : Label,
	dpadRightLabel             : Label,
	leftShoulderButtonLabel    : Label,
	rightShoulderButtonLabel   : Label,
	leftThumbstickButtonLabel  : Label,
	rightThumbstickButtonLabel : Label,
}

RacingWheelInfo :: struct {
	menuButtonLabel         : Label,
	viewButtonLabel         : Label,
	previousGearButtonLabel : Label,
	nextGearButtonLabel     : Label,
	dpadUpLabel             : Label,
	dpadDownLabel           : Label,
	dpadLeftLabel           : Label,
	dpadRightLabel          : Label,
	hasClutch               : bool,
	hasHandbrake            : bool,
	hasPatternShifter       : bool,
	minPatternShifterGear   : i32,
	maxPatternShifterGear   : i32,
	maxWheelAngle           : f32,
}

UiNavigationInfo :: struct {
	menuButtonLabel        : Label,
	viewButtonLabel        : Label,
	acceptButtonLabel      : Label,
	cancelButtonLabel      : Label,
	upButtonLabel          : Label,
	downButtonLabel        : Label,
	leftButtonLabel        : Label,
	rightButtonLabel       : Label,
	contextButton1Label    : Label,
	contextButton2Label    : Label,
	contextButton3Label    : Label,
	contextButton4Label    : Label,
	pageUpButtonLabel      : Label,
	pageDownButtonLabel    : Label,
	pageLeftButtonLabel    : Label,
	pageRightButtonLabel   : Label,
	scrollUpButtonLabel    : Label,
	scrollDownButtonLabel  : Label,
	scrollLeftButtonLabel  : Label,
	scrollRightButtonLabel : Label,
	guideButtonLabel       : Label,
}

ForceFeedbackMotorInfo :: struct {
	supportedAxes                     : FeedbackAxes,
	location                          : Location,
	locationId                        : u32,
	maxSimultaneousEffects            : u32,
	isConstantEffectSupported         : bool,
	isRampEffectSupported             : bool,
	isSineWaveEffectSupported         : bool,
	isSquareWaveEffectSupported       : bool,
	isTriangleWaveEffectSupported     : bool,
	isSawtoothUpWaveEffectSupported   : bool,
	isSawtoothDownWaveEffectSupported : bool,
	isSpringEffectSupported           : bool,
	isFrictionEffectSupported         : bool,
	isDamperEffectSupported           : bool,
	isInertiaEffectSupported          : bool,
}

HapticWaveformInfo :: struct {
	usage                  : Usage,
	isDurationSupported    : bool,
	isIntensitySupported   : bool,
	isRepeatSupported      : bool,
	isRepeatDelaySupported : bool,
	defaultDuration        : u64,
}

HapticFeedbackMotorInfo :: struct {
	mappedRumbleMotors : RumbleMotors,
	location           : Location,
	locationId         : u32,
	waveformCount      : u32,
	waveformInfo       : [^]HapticWaveformInfo,
}

DeviceInfo :: struct {
	infoSize                 : u32,
	vendorId                 : u16,
	productId                : u16,
	revisionNumber           : u16,
	interfaceNumber          : u8,
	collectionNumber         : u8,
	usage                    : Usage,
	hardwareVersion          : Version,
	firmwareVersion          : Version,
	deviceId                 : APP_LOCAL_DEVICE_ID,
	deviceRootId             : APP_LOCAL_DEVICE_ID,
	deviceFamily             : DeviceFamily,
	capabilities             : DeviceCapabilities,
	supportedInput           : Kind,
	supportedRumbleMotors    : RumbleMotors,
	inputReportCount         : u32,
	outputReportCount        : u32,
	featureReportCount       : u32,
	controllerAxisCount      : u32,
	controllerButtonCount    : u32,
	controllerSwitchCount    : u32,
	touchPointCount          : u32,
	touchSensorCount         : u32,
	forceFeedbackMotorCount  : u32,
	hapticFeedbackMotorCount : u32,
	deviceStringCount        : u32,
	deviceDescriptorSize     : u32,
	inputReportInfo          : [^]RawDeviceReportInfo,
	outputReportInfo         : [^]RawDeviceReportInfo,
	featureReportInfo        : [^]RawDeviceReportInfo,
	controllerAxisInfo       : [^]ControllerAxisInfo,
	controllerButtonInfo     : [^]ControllerButtonInfo,
	controllerSwitchInfo     : [^]ControllerSwitchInfo,
	keyboardInfo             : ^KeyboardInfo,
	mouseInfo                : ^MouseInfo,
	touchSensorInfo          : [^]TouchSensorInfo,
	motionInfo               : ^MotionInfo,
	arcadeStickInfo          : ^ArcadeStickInfo,
	flightStickInfo          : ^FlightStickInfo,
	gamepadInfo              : ^GamepadInfo,
	racingWheelInfo          : ^RacingWheelInfo,
	uiNavigationInfo         : ^UiNavigationInfo,
	forceFeedbackMotorInfo   : [^]ForceFeedbackMotorInfo,
	hapticFeedbackMotorInfo  : [^]HapticFeedbackMotorInfo,
	displayName              : ^String,
	deviceStrings            : [^]String,
	deviceDescriptorData     : rawptr,
}

ForceFeedbackEnvelope :: struct {
	attackDuration  : u64,
	sustainDuration : u64,
	releaseDuration : u64,
	attackGain      : f32,
	sustainGain     : f32,
	releaseGain     : f32,
	playCount       : u32,
	repeatDelay     : u64,
}

ForceFeedbackMagnitude :: struct {
	linearX  : f32,
	linearY  : f32,
	linearZ  : f32,
	angularX : f32,
	angularY : f32,
	angularZ : f32,
	normal   : f32,
}

ForceFeedbackConditionParams :: struct {
	magnitude            : ForceFeedbackMagnitude,
	positiveCoefficient  : f32,
	negativeCoefficient  : f32,
	maxPositiveMagnitude : f32,
	maxNegativeMagnitude : f32,
	deadZone             : f32,
	bias                 : f32,
}

ForceFeedbackConstantParams :: struct {
	envelope  : ForceFeedbackEnvelope,
	magnitude : ForceFeedbackMagnitude,
}

ForceFeedbackPeriodicParams :: struct {
	envelope  : ForceFeedbackEnvelope,
	magnitude : ForceFeedbackMagnitude,
	frequency : f32,
	phase     : f32,
	bias      : f32,
}

ForceFeedbackRampParams :: struct {
	envelope       : ForceFeedbackEnvelope,
	startMagnitude : ForceFeedbackMagnitude,
	endMagnitude   : ForceFeedbackMagnitude,
}

ForceFeedbackParams :: struct {
	kind: ForceFeedbackEffectKind,
	data: struct #raw_union {
		constant         : ForceFeedbackConstantParams,
		ramp             : ForceFeedbackRampParams,
		sineWave         : ForceFeedbackPeriodicParams,
		squareWave       : ForceFeedbackPeriodicParams,
		triangleWave     : ForceFeedbackPeriodicParams,
		sawtoothUpWave   : ForceFeedbackPeriodicParams,
		sawtoothDownWave : ForceFeedbackPeriodicParams,
		spring           : ForceFeedbackConditionParams,
		friction         : ForceFeedbackConditionParams,
		damper           : ForceFeedbackConditionParams,
		inertia          : ForceFeedbackConditionParams,
	},
}

HapticFeedbackParams :: struct {
	waveformIndex : u32,
	duration      : u64,
	intensity     : f32,
	playCount     : u32,
	repeatDelay   : u64,
}

RumbleParams :: struct {
	lowFrequency  : f32,
	highFrequency : f32,
	leftTrigger   : f32,
	rightTrigger  : f32,
}

// NOTE
// VTABLES CODE GOES HERE
// NOTE

@(default_calling_convention = "system", link_prefix="GameInput")
foreign lib {
	Create :: proc(gameInput: ^^IGameInput) -> win.HRESULT ---
}

FACILITY_GAMEINPUT :: 906

//
// MessageId: GAMEINPUT_E_DEVICE_DISCONNECTED
//
// MessageText:
//
// The device is not currently connected to the system.
//
// #define GAMEINPUT_E_DEVICE_DISCONNECTED _HRESULT_TYPEDEF_(0x838A0001L)
E_DEVICE_DISCONNECTED: u32 : 0x838A0001

//
// MessageId: GAMEINPUT_E_DEVICE_NOT_FOUND
//
// MessageText:
//
// The requested device could not be found.
//
// #define GAMEINPUT_E_DEVICE_NOT_FOUND _HRESULT_TYPEDEF_(0x838A0002L)
E_DEVICE_NOT_FOUND: u32 : 0x838A0002

//
// MessageId: GAMEINPUT_E_READING_NOT_FOUND
//
// MessageText:
//
// The requested reading could not be found.
//
// #define GAMEINPUT_E_READING_NOT_FOUND _HRESULT_TYPEDEF_(0x838A0003L)
E_READING_NOT_FOUND: u32 : 0x838A0003

//
// MessageId: GAMEINPUT_E_REFERENCE_READING_TOO_OLD
//
// MessageText:
//
// The reference reading no longer exists in the reading history.
//
// #define GAMEINPUT_E_REFERENCE_READING_TOO_OLD _HRESULT_TYPEDEF_(0x838A0004L)
E_REFERENCE_READING_TOO_OLD: u32 : 0x838A0004

//
// MessageId: GAMEINPUT_E_TIMESTAMP_OUT_OF_RANGE
//
// MessageText:
//
// The target timestamp for the temporal reading is too far in the past or future.
//
// #define GAMEINPUT_E_TIMESTAMP_OUT_OF_RANGE _HRESULT_TYPEDEF_(0x838A0005L)
E_TIMESTAMP_OUT_OF_RANGE: u32 : 0x838A0005

//
// MessageId: GAMEINPUT_E_INSUFFICIENT_FORCE_FEEDBACK_RESOURCES
//
// MessageText:
//
// The device does not have enough resources remaining to create the requested force feedback effect.
//
// #define GAMEINPUT_E_INSUFFICIENT_FORCE_FEEDBACK_RESOURCES _HRESULT_TYPEDEF_(0x838A0006L)
E_INSUFFICIENT_FORCE_FEEDBACK_RESOURCES: u32 : 0x838A0006
