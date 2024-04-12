**THIS CHECKLIST IS NOT COMPLETE**. Use `--show-ignored-findings` to show all the results.
Summary
 - [incorrect-equality](#incorrect-equality) (1 results) (Medium)
 - [timestamp](#timestamp) (7 results) (Low)
 - [pragma](#pragma) (1 results) (Informational)
 - [dead-code](#dead-code) (1 results) (Informational)
 - [solc-version](#solc-version) (2 results) (Informational)
## incorrect-equality

> We have to use a strict equality in this case

Impact: Medium
Confidence: High
 - [ ] ID-0
	[AccessControlExternalModuleInternal.checkTransferAdmin(bytes32,address)](src/modules/OpenZeppelin/AccessControlExternalModuleInternal.sol#L99-L108) uses a dangerous strict equality:
	- [(_pendingDefaultAdmin == newAdmin) && (_pendingDefaultAdminSchedule == 0)](src/modules/OpenZeppelin/AccessControlExternalModuleInternal.sol#L101)

src/modules/OpenZeppelin/AccessControlExternalModuleInternal.sol#L99-L108

## timestamp

> With the Proof of Work, it was possible for a miner to modify the timestamp in a range of about 15 seconds
>
> With the Proof Of Stake, a new block is created every 12 seconds
>
> In all cases, we are not looking for such precision

Impact: Low
Confidence: Medium
 - [ ] ID-1
	[AccessControlExternalModuleInternal._acceptDefaultAdminTransfer()](src/modules/OpenZeppelin/AccessControlExternalModuleInternal.sol#L179-L193) uses timestamp for comparisons
	Dangerous comparisons:
	- [! _isScheduleSet(schedule) || ! _hasSchedulePassed(schedule)](src/modules/OpenZeppelin/AccessControlExternalModuleInternal.sol#L181)

src/modules/OpenZeppelin/AccessControlExternalModuleInternal.sol#L179-L193


 - [ ] ID-2
	[AccessControlExternalModuleInternal._isScheduleSet(uint48)](src/modules/OpenZeppelin/AccessControlExternalModuleInternal.sol#L297-L299) uses timestamp for comparisons
	Dangerous comparisons:
	- [schedule != 0](src/modules/OpenZeppelin/AccessControlExternalModuleInternal.sol#L298)

src/modules/OpenZeppelin/AccessControlExternalModuleInternal.sol#L297-L299


 - [ ] ID-3
	[AccessControlExternalModuleInternal.pendingDefaultAdminDelay()](src/modules/OpenZeppelin/AccessControlExternalModuleInternal.sol#L133-L136) uses timestamp for comparisons
	Dangerous comparisons:
	- [(_isScheduleSet(schedule) && ! _hasSchedulePassed(schedule))](src/modules/OpenZeppelin/AccessControlExternalModuleInternal.sol#L135)

src/modules/OpenZeppelin/AccessControlExternalModuleInternal.sol#L133-L136


 - [ ] ID-4
	[AccessControlExternalModuleInternal.checkTransferAdmin(bytes32,address)](src/modules/OpenZeppelin/AccessControlExternalModuleInternal.sol#L99-L108) uses timestamp for comparisons
	Dangerous comparisons:
	- [(_pendingDefaultAdmin == newAdmin) && (_pendingDefaultAdminSchedule == 0)](src/modules/OpenZeppelin/AccessControlExternalModuleInternal.sol#L101)

src/modules/OpenZeppelin/AccessControlExternalModuleInternal.sol#L99-L108


 - [ ] ID-5
	[AccessControlExternalModuleInternal._hasSchedulePassed(uint48)](src/modules/OpenZeppelin/AccessControlExternalModuleInternal.sol#L304-L306) uses timestamp for comparisons
	Dangerous comparisons:
	- [schedule < block.timestamp](src/modules/OpenZeppelin/AccessControlExternalModuleInternal.sol#L305)

src/modules/OpenZeppelin/AccessControlExternalModuleInternal.sol#L304-L306


 - [ ] ID-6
	[AccessControlExternalModuleInternal.defaultAdminDelay()](src/modules/OpenZeppelin/AccessControlExternalModuleInternal.sol#L125-L128) uses timestamp for comparisons
	Dangerous comparisons:
	- [(_isScheduleSet(schedule) && _hasSchedulePassed(schedule))](src/modules/OpenZeppelin/AccessControlExternalModuleInternal.sol#L127)

src/modules/OpenZeppelin/AccessControlExternalModuleInternal.sol#L125-L128


 - [ ] ID-7
	[AccessControlExternalModule.acceptDefaultAdminTransfer()](src/modules/OpenZeppelin/AccessControlExternalModule.sol#L66-L73) uses timestamp for comparisons
	Dangerous comparisons:
	- [_msgSender() != newDefaultAdmin](src/modules/OpenZeppelin/AccessControlExternalModule.sol#L68)

src/modules/OpenZeppelin/AccessControlExternalModule.sol#L66-L73

## pragma

> Concerns the CMTAT lib, will be fixed in the CMTAT lib.

Impact: Informational
Confidence: High
 - [ ] ID-8
	2 different versions of Solidity are used:
	- Version constraint ^0.8.0 is used by:
 		- lib/CMTAT/contracts/interfaces/engine/IAuthorizationEngine.sol#3
	- Version constraint ^0.8.20 is used by:
 		- lib/openzeppelin-contracts/contracts/access/AccessControl.sol#4
		- lib/openzeppelin-contracts/contracts/access/IAccessControl.sol#4
		- lib/openzeppelin-contracts/contracts/metatx/ERC2771Context.sol#4
		- lib/openzeppelin-contracts/contracts/utils/Context.sol#4
		- lib/openzeppelin-contracts/contracts/utils/introspection/ERC165.sol#4
		- lib/openzeppelin-contracts/contracts/utils/introspection/IERC165.sol#4
		- lib/openzeppelin-contracts/contracts/utils/math/Math.sol#4
		- lib/openzeppelin-contracts/contracts/utils/math/SafeCast.sol#5
		- src/AuthorizationEngine.sol#3
		- src/modules/MetaTxModuleStandalone.sol#3
		- src/modules/OpenZeppelin/AccessControlExternalModule.sol#4
		- src/modules/OpenZeppelin/AccessControlExternalModuleInternal.sol#4

## dead-code

> - Implemented to be gasless compatible (see MetaTxModule)
>
> - If we remove this function, we will have the following error:
>
>   "Derived contract must override function "_msgData". Two or more base classes define function wit

Impact: Informational
Confidence: Medium
 - [ ] ID-9
[AuthorizationEngine._msgData()](src/AuthorizationEngine.sol#L84-L91) is never used and should be removed

src/AuthorizationEngine.sol#L84-L91

## solc-version

> The version set in the config file is 0.8.22

Impact: Informational
Confidence: High
 - [ ] ID-10
Version constraint ^0.8.20 contains known severe issues (https://solidity.readthedocs.io/en/latest/bugs.html)
	- VerbatimInvalidDeduplication
	- FullInlinerNonExpressionSplitArgumentEvaluationOrder
	- MissingSideEffectsOnSelectorAccess.
 It is used by:
	- lib/openzeppelin-contracts/contracts/access/AccessControl.sol#4
	- lib/openzeppelin-contracts/contracts/access/IAccessControl.sol#4
	- lib/openzeppelin-contracts/contracts/metatx/ERC2771Context.sol#4
	- lib/openzeppelin-contracts/contracts/utils/Context.sol#4
	- lib/openzeppelin-contracts/contracts/utils/introspection/ERC165.sol#4
	- lib/openzeppelin-contracts/contracts/utils/introspection/IERC165.sol#4
	- lib/openzeppelin-contracts/contracts/utils/math/Math.sol#4
	- lib/openzeppelin-contracts/contracts/utils/math/SafeCast.sol#5
	- src/AuthorizationEngine.sol#3
	- src/modules/MetaTxModuleStandalone.sol#3
	- src/modules/OpenZeppelin/AccessControlExternalModule.sol#4
	- src/modules/OpenZeppelin/AccessControlExternalModuleInternal.sol#4

 - [ ] ID-11
	Version constraint ^0.8.0 contains known severe issues (https://solidity.readthedocs.io/en/latest/bugs.html)
	- FullInlinerNonExpressionSplitArgumentEvaluationOrder
	- MissingSideEffectsOnSelectorAccess
	- AbiReencodingHeadOverflowWithStaticArrayCleanup
	- DirtyBytesArrayToStorage
	- DataLocationChangeInInternalOverride
	- NestedCalldataArrayAbiReencodingSizeValidation
	- SignedImmutables
	- ABIDecodeTwoDimensionalArrayMemory
	- KeccakCaching.
	 It is used by:
	- lib/CMTAT/contracts/interfaces/engine/IAuthorizationEngine.sol#3

