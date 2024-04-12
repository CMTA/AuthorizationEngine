# Technical choice

[TOC]

## Functionality

### Upgradeable

The AuthorizationEngine is not upgradeable. 

### Urgency mechanism

Pause
There are no functionalities to put in pause the contracts.


### Gasless support

The AuthorizationEngine supports client-side gasless transactions using the [Gas Station Network](https://docs.opengsn.org/#the-problem) (GSN) pattern, the main open standard for transfering fee payment to another account than that of the transaction issuer. The contract uses the OpenZeppelin contract `ERC2771Context`, which allows a contract to get the original client with `_msgSender()` instead of the fee payer given by `msg.sender` .

At deployment, the parameter  `forwarder` inside the contract constructor has to be set  with the defined address of the forwarder. Please note that the forwarder can not be changed after deployment.

Please see the OpenGSN [documentation](https://docs.opengsn.org/contracts/#receiving-a-relayed-call) for more details on what is done to support GSN in the contract.

## Schema

### UML

![uml](./schema/classDiagram.svg)



## Graph

### AuthorizationEngine

![surya_graph_AuthorizationEngine.sol](./schema/surya/surya_graph/surya_graph_AuthorizationEngine.sol.png)



### AccessControlExternalModule

![surya_graph_AccessControlExternalModule.sol](./schema/surya/surya_graph/surya_graph_AccessControlExternalModule.sol.png)

### AccessControlExternalModuleInternal

![surya_graph_AccessControlExternalModuleInternal.sol](./schema/surya/surya_graph/surya_graph_AccessControlExternalModuleInternal.sol.png)

