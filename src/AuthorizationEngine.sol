// SPDX-License-Identifier: MPL-2.0

pragma solidity ^0.8.20;

import "./modules/MetaTxModuleStandalone.sol";
import "./modules/OpenZeppelin/AccessControlExternalModule.sol";
import "../lib/openzeppelin-contracts/contracts/access/AccessControl.sol";
import "CMTAT/interfaces/engine/IAuthorizationEngine.sol";
/**
@title Implementation of an AuthorizationEngine defined by the CMTAT
*/
contract AuthorizationEngine is AccessControl, MetaTxModuleStandalone,AccessControlExternalModule, IAuthorizationEngine {
    error AuthorizationEngine_AdminWithAddressZeroNotAllowed();
    /// @dev Role to manage the ruleEngine
    bytes32 public constant CMTAT_CONTRACT_ROLE = keccak256("CMTAT_CONTRACT_ROLE");

    /**
    * @param admin Address of the contract (Access Control)
    * @param forwarderIrrevocable Address of the forwarder, required for the gasless support
    * @param initialDelay delay before a new admin can accept the transfer
    * @param CMTAT_contract CMTAT contract, can be define later
    */
    constructor(
        address admin,
        address forwarderIrrevocable,
        uint48 initialDelay, 
        address CMTAT_contract
    ) MetaTxModuleStandalone(forwarderIrrevocable) AccessControlExternalModule(initialDelay) {
        if(admin == address(0))
        {
            revert AuthorizationEngine_AdminWithAddressZeroNotAllowed();
        }
        _grantRole(DEFAULT_ADMIN_ROLE, admin);
        _grantRole(AUTHORIZATION_ENGINE_ROLE, admin);
        if(address(CMTAT_contract) != address(0)){
            _grantRole(CMTAT_CONTRACT_ROLE, CMTAT_contract);
        }
    }

   

    /** 
    * @notice Validate an operation "GrantRole"
    * @return True if the operation is valid, false otherwise
    * @dev Requirements:
    * - the caller must have the `CMTAT_CONTRACT_ROLEE`
    * It means that only the CMTAT contract can call this function
    **/
    function operateOnGrantRole(
         bytes32 role, address account
    ) public view onlyRole(CMTAT_CONTRACT_ROLE) returns (bool)  {
        return AccessControlExternalModuleInternal.checkTransferAdmin(role, account);
    }

    /** 
    * @notice Validate an operation revokeRole, return only true
    * @return True if the operation is valid, false otherwise
    * @dev Requirements:
    * - the caller must have the `CMTAT_CONTRACT_ROLEE`
    * It means that only the CMTAT contract can call this function
    **/
    function operateOnRevokeRole(
         bytes32 /*role*/, address /*account*/
    ) public view onlyRole(CMTAT_CONTRACT_ROLE) returns (bool)  {
        return true;
    }


    /** 
    * @dev This surcharge is not necessary if you do not use the MetaTxModule
    */
    function _msgSender()
        internal
        view
        override(ERC2771Context, Context)
        returns (address sender)
    {
        return ERC2771Context._msgSender();
    }

    /** 
    * @dev This surcharge is not necessary if you do not use the MetaTxModule
    */
    function _msgData()
        internal
        view
        override(ERC2771Context, Context)
        returns (bytes calldata)
    {
        return ERC2771Context._msgData();
    }

    function _contextSuffixLength() internal view 
    override(ERC2771Context, Context)
    returns (uint256) {
         return ERC2771Context._contextSuffixLength();
    }
}
