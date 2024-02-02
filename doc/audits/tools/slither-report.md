**THIS CHECKLIST IS NOT COMPLETE**. Use `--show-ignored-findings` to show all the results.
Summary
 - [shadowing-state](#shadowing-state) (5 results) (High)
 - [incorrect-equality](#incorrect-equality) (1 results) (Medium)
 - [timestamp](#timestamp) (7 results) (Low)
 - [dead-code](#dead-code) (1 results) (Informational)
 - [solc-version](#solc-version) (5 results) (Informational)
## shadowing-state
Impact: High
Confidence: High
 - [ ] ID-0
[AccessControlExternalModule._currentDelay](src/modules/OpenZeppelin/AccessControlExternalModule.sol#L46) shadows:
	- [AccessControlExternalModuleInternal._currentDelay](src/modules/OpenZeppelin/AccessControlExternalModuleInternal.sol#L90)

src/modules/OpenZeppelin/AccessControlExternalModule.sol#L46


 - [ ] ID-1
[AccessControlExternalModule._pendingDelay](src/modules/OpenZeppelin/AccessControlExternalModule.sol#L50) shadows:
	- [AccessControlExternalModuleInternal._pendingDelay](src/modules/OpenZeppelin/AccessControlExternalModuleInternal.sol#L94)

src/modules/OpenZeppelin/AccessControlExternalModule.sol#L50


 - [ ] ID-2
[AccessControlExternalModule._pendingDefaultAdminSchedule](src/modules/OpenZeppelin/AccessControlExternalModule.sol#L44) shadows:
	- [AccessControlExternalModuleInternal._pendingDefaultAdminSchedule](src/modules/OpenZeppelin/AccessControlExternalModuleInternal.sol#L88)

src/modules/OpenZeppelin/AccessControlExternalModule.sol#L44


 - [ ] ID-3
[AccessControlExternalModule._pendingDefaultAdmin](src/modules/OpenZeppelin/AccessControlExternalModule.sol#L43) shadows:
	- [AccessControlExternalModuleInternal._pendingDefaultAdmin](src/modules/OpenZeppelin/AccessControlExternalModuleInternal.sol#L87)

src/modules/OpenZeppelin/AccessControlExternalModule.sol#L43


 - [ ] ID-4
[AccessControlExternalModule._pendingDelaySchedule](src/modules/OpenZeppelin/AccessControlExternalModule.sol#L51) shadows:
	- [AccessControlExternalModuleInternal._pendingDelaySchedule](src/modules/OpenZeppelin/AccessControlExternalModuleInternal.sol#L95)

src/modules/OpenZeppelin/AccessControlExternalModule.sol#L51


## incorrect-equality
Impact: Medium
Confidence: High
 - [ ] ID-5
[AccessControlExternalModuleInternal.checkTransferAdmin(bytes32,address)](src/modules/OpenZeppelin/AccessControlExternalModuleInternal.sol#L115-L124) uses a dangerous strict equality:
	- [(_pendingDefaultAdmin == newAdmin) && (_pendingDefaultAdminSchedule == 0)](src/modules/OpenZeppelin/AccessControlExternalModuleInternal.sol#L117)

src/modules/OpenZeppelin/AccessControlExternalModuleInternal.sol#L115-L124


## timestamp
Impact: Low
Confidence: Medium
 - [ ] ID-6
[AccessControlExternalModuleInternal.pendingDefaultAdminDelay()](src/modules/OpenZeppelin/AccessControlExternalModuleInternal.sol#L149-L152) uses timestamp for comparisons
	Dangerous comparisons:
	- [(_isScheduleSet(schedule) && ! _hasSchedulePassed(schedule))](src/modules/OpenZeppelin/AccessControlExternalModuleInternal.sol#L151)

src/modules/OpenZeppelin/AccessControlExternalModuleInternal.sol#L149-L152


 - [ ] ID-7
[AccessControlExternalModuleInternal._hasSchedulePassed(uint48)](src/modules/OpenZeppelin/AccessControlExternalModuleInternal.sol#L320-L322) uses timestamp for comparisons
	Dangerous comparisons:
	- [schedule < block.timestamp](src/modules/OpenZeppelin/AccessControlExternalModuleInternal.sol#L321)

src/modules/OpenZeppelin/AccessControlExternalModuleInternal.sol#L320-L322


 - [ ] ID-8
[AccessControlExternalModule.acceptDefaultAdminTransfer()](src/modules/OpenZeppelin/AccessControlExternalModule.sol#L84-L91) uses timestamp for comparisons
	Dangerous comparisons:
	- [_msgSender() != newDefaultAdmin](src/modules/OpenZeppelin/AccessControlExternalModule.sol#L86)

src/modules/OpenZeppelin/AccessControlExternalModule.sol#L84-L91


 - [ ] ID-9
[AccessControlExternalModuleInternal._acceptDefaultAdminTransfer()](src/modules/OpenZeppelin/AccessControlExternalModuleInternal.sol#L195-L209) uses timestamp for comparisons
	Dangerous comparisons:
	- [! _isScheduleSet(schedule) || ! _hasSchedulePassed(schedule)](src/modules/OpenZeppelin/AccessControlExternalModuleInternal.sol#L197)

src/modules/OpenZeppelin/AccessControlExternalModuleInternal.sol#L195-L209


 - [ ] ID-10
[AccessControlExternalModuleInternal.checkTransferAdmin(bytes32,address)](src/modules/OpenZeppelin/AccessControlExternalModuleInternal.sol#L115-L124) uses timestamp for comparisons
	Dangerous comparisons:
	- [(_pendingDefaultAdmin == newAdmin) && (_pendingDefaultAdminSchedule == 0)](src/modules/OpenZeppelin/AccessControlExternalModuleInternal.sol#L117)

src/modules/OpenZeppelin/AccessControlExternalModuleInternal.sol#L115-L124


 - [ ] ID-11
[AccessControlExternalModuleInternal._isScheduleSet(uint48)](src/modules/OpenZeppelin/AccessControlExternalModuleInternal.sol#L313-L315) uses timestamp for comparisons
	Dangerous comparisons:
	- [schedule != 0](src/modules/OpenZeppelin/AccessControlExternalModuleInternal.sol#L314)

src/modules/OpenZeppelin/AccessControlExternalModuleInternal.sol#L313-L315


 - [ ] ID-12
[AccessControlExternalModuleInternal.defaultAdminDelay()](src/modules/OpenZeppelin/AccessControlExternalModuleInternal.sol#L141-L144) uses timestamp for comparisons
	Dangerous comparisons:
	- [(_isScheduleSet(schedule) && _hasSchedulePassed(schedule))](src/modules/OpenZeppelin/AccessControlExternalModuleInternal.sol#L143)

src/modules/OpenZeppelin/AccessControlExternalModuleInternal.sol#L141-L144


## dead-code
Impact: Informational
Confidence: Medium
 - [ ] ID-13
[AuthorizationEngine._msgData()](src/AuthorizationEngine.sol#L84-L91) is never used and should be removed

src/AuthorizationEngine.sol#L84-L91


## solc-version
Impact: Informational
Confidence: High
 - [ ] ID-14
solc-0.8.20 is not recommended for deployment

 - [ ] ID-15
Pragma version[^0.8.20](src/modules/MetaTxModuleStandalone.sol#L3) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.

src/modules/MetaTxModuleStandalone.sol#L3


 - [ ] ID-16
Pragma version[^0.8.20](src/modules/OpenZeppelin/AccessControlExternalModuleInternal.sol#L5) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.

src/modules/OpenZeppelin/AccessControlExternalModuleInternal.sol#L5


 - [ ] ID-17
Pragma version[^0.8.20](src/AuthorizationEngine.sol#L3) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.

src/AuthorizationEngine.sol#L3


 - [ ] ID-18
Pragma version[^0.8.20](src/modules/OpenZeppelin/AccessControlExternalModule.sol#L4) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.

src/modules/OpenZeppelin/AccessControlExternalModule.sol#L4


