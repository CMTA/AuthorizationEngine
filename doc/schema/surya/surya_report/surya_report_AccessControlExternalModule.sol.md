## Sūrya's Description Report

### Files Description Table


|  File Name  |  SHA-1 Hash  |
|-------------|--------------|
| ./modules/OpenZeppelin/AccessControlExternalModule.sol | fb2f7493c1215d2fb82b45e8eb623d7b928cd972 |


### Contracts Description Table


|  Contract  |         Type        |       Bases      |                  |                 |
|:----------:|:-------------------:|:----------------:|:----------------:|:---------------:|
|     └      |  **Function Name**  |  **Visibility**  |  **Mutability**  |  **Modifiers**  |
||||||
| **AccessControlExternalModule** | Implementation | AccessControl, AccessControlExternalModuleInternal |||
| └ | <Constructor> | Public ❗️ | 🛑  | AccessControlExternalModuleInternal |
| └ | changeDefaultAdminDelay | Public ❗️ | 🛑  | onlyRole |
| └ | acceptDefaultAdminTransfer | Public ❗️ | 🛑  |NO❗️ |
| └ | cancelDefaultAdminTransfer | Public ❗️ | 🛑  | onlyRole |
| └ | beginDefaultAdminTransfer | Public ❗️ | 🛑  | onlyRole |
| └ | rollbackDefaultAdminDelay | Public ❗️ | 🛑  | onlyRole |


### Legend

|  Symbol  |  Meaning  |
|:--------:|-----------|
|    🛑    | Function can modify state |
|    💵    | Function is payable |
