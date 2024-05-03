//SPDX-License-Identifier: MPL-2.0
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "CMTAT/CMTAT_STANDALONE.sol";
import "CMTAT/interfaces/engine/IAuthorizationEngine.sol";
import "CMTAT/interfaces/engine/IRuleEngine.sol";
/**
@title Constants used by the tests
*/
abstract contract HelperContract {
    // EOA to perform tests
    address constant ZERO_ADDRESS = address(0);
    address constant DEFAULT_ADMIN_ADDRESS = address(1);
    address constant AUTHORIZATION_ENGINE_OPERATOR_ADDRESS = address(3);
    address constant ATTACKER = address(4);
    address constant ADDRESS1 = address(5);
    address constant ADDRESS2 = address(6);
    address constant ADDRESS3 = address(7);
    // role string
    string constant RULE_ENGINE_ROLE_HASH =
        "0x774b3c5f4a8b37a7da21d72b7f2429e4a6d49c4de0ac5f2b831a1a539d0f0fd2";
    string constant WHITELIST_ROLE_HASH =
        "0xdc72ed553f2544c34465af23b847953efeb813428162d767f9ba5f4013be6760";
    string constant DEFAULT_ADMIN_ROLE_HASH =
        "0x0000000000000000000000000000000000000000000000000000000000000000";
    
    // contract
    CMTAT_STANDALONE CMTAT_CONTRACT;

    bytes32 public constant AUTHORIZATION_ENGINE_ROLE = keccak256("AUTHORIZATION_ENGINE_ROLE");
    bytes32 public constant DEFAULT_ADMIN_ROLE = 0x00;
 

    // Forwarder
    string ERC2771ForwarderDomain = 'ERC2771ForwarderDomain';

    // AuthorizationEngine event

    // Custom error AuthorizationEngine
    error AuthorizationEngine_AdminWithAddressZeroNotAllowed();

    // CMTAT
    error CMTAT_AuthorizationModule_InvalidAuthorization();

    constructor() {}
}
