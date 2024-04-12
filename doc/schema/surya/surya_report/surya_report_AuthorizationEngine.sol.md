## Sūrya's Description Report

### Files Description Table


|  File Name  |  SHA-1 Hash  |
|-------------|--------------|
| ./AuthorizationEngine.sol | c603a7730a8372c9fb270d632cf013407ea1f838 |


### Contracts Description Table


|  Contract  |         Type        |       Bases      |                  |                 |
|:----------:|:-------------------:|:----------------:|:----------------:|:---------------:|
|     └      |  **Function Name**  |  **Visibility**  |  **Mutability**  |  **Modifiers**  |
||||||
| **AuthorizationEngine** | Implementation | AccessControl, MetaTxModuleStandalone, AccessControlExternalModule, IAuthorizationEngine |||
| └ | <Constructor> | Public ❗️ | 🛑  | MetaTxModuleStandalone AccessControlExternalModule |
| └ | operateOnGrantRole | Public ❗️ |   | onlyRole |
| └ | operateOnRevokeRole | Public ❗️ |   | onlyRole |
| └ | _msgSender | Internal 🔒 |   | |
| └ | _msgData | Internal 🔒 |   | |
| └ | _contextSuffixLength | Internal 🔒 |   | |


### Legend

|  Symbol  |  Meaning  |
|:--------:|-----------|
|    🛑    | Function can modify state |
|    💵    | Function is payable |
