## Sūrya's Description Report

### Files Description Table


|  File Name  |  SHA-1 Hash  |
|-------------|--------------|
| ./modules/OpenZeppelin/AccessControlExternalModuleInternal.sol | 321dcb6bfdbcc4de003800a29425bd1b9787265f |


### Contracts Description Table


|  Contract  |         Type        |       Bases      |                  |                 |
|:----------:|:-------------------:|:----------------:|:----------------:|:---------------:|
|     └      |  **Function Name**  |  **Visibility**  |  **Mutability**  |  **Modifiers**  |
||||||
| **AccessControlExternalModuleInternal** | Implementation |  |||
| └ | <Constructor> | Public ❗️ | 🛑  |NO❗️ |
| └ | checkTransferAdmin | Internal 🔒 |   | |
| └ | pendingDefaultAdmin | Public ❗️ |   |NO❗️ |
| └ | defaultAdminDelay | Public ❗️ |   |NO❗️ |
| └ | pendingDefaultAdminDelay | Public ❗️ |   |NO❗️ |
| └ | defaultAdminDelayIncreaseWait | Public ❗️ |   |NO❗️ |
| └ | _beginDefaultAdminTransfer | Internal 🔒 | 🛑  | |
| └ | _cancelDefaultAdminTransfer | Internal 🔒 | 🛑  | |
| └ | _acceptDefaultAdminTransfer | Internal 🔒 | 🛑  | |
| └ | _changeDefaultAdminDelay | Internal 🔒 | 🛑  | |
| └ | _rollbackDefaultAdminDelay | Internal 🔒 | 🛑  | |
| └ | _delayChangeWait | Internal 🔒 |   | |
| └ | _setPendingDefaultAdmin | Private 🔐 | 🛑  | |
| └ | _setPendingDelay | Private 🔐 | 🛑  | |
| └ | _isScheduleSet | Private 🔐 |   | |
| └ | _hasSchedulePassed | Private 🔐 |   | |


### Legend

|  Symbol  |  Meaning  |
|:--------:|-----------|
|    🛑    | Function can modify state |
|    💵    | Function is payable |
