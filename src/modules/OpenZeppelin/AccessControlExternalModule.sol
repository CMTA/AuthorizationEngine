// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts (last updated v5.0.0) (access/extensions/AccessControlDefaultAdminRules.sol)

pragma solidity ^0.8.20;

import {AccessControl} from "../../../lib/openzeppelin-contracts/contracts/access/AccessControl.sol";
import {AccessControlExternalModuleInternal} from "./AccessControlExternalModuleInternal.sol";

/**
 * @dev 
 * This contract is a modified version of the contract AccessControlDefaultAdminRule from OpenZeppelin.
 * See OpenZeppelin Contracts (last updated v5.0.0) (access/extensions/AccessControlDefaultAdminRules.sol)
 * The main difference is in the case of OZ, the rules apply to the actual contract admin.
 *
 *
 * This contract implements the following risk mitigations on top of {AccessControl}:
 *
 * * Only one account holds the `DEFAULT_ADMIN_ROLE` since deployment until it's potentially renounced.
 * * Enforces a 2-step process to transfer the `DEFAULT_ADMIN_ROLE` to another account.
 * * Enforces a configurable delay between the two steps, with the ability to cancel before the transfer is accepted.
 * * The delay can be changed by scheduling, see {changeDefaultAdminDelay}.
 */
abstract contract AccessControlExternalModule is AccessControl, AccessControlExternalModuleInternal {
    address private _currentDefaultAdmin;

    /// @dev Role to manage the authorization
    bytes32 public constant AUTHORIZATION_ENGINE_ROLE = keccak256("AUTHORIZATION_ENGINE_ROLE");


    /**
    * 
    */
    constructor (
        uint48 initialDelay
    ) AccessControlExternalModuleInternal(initialDelay) {

    }

    ///
    /// Override AccessControl role management
    ///

    ///
    /// AccessControlDefaultAdminRules public and internal setters for defaultAdminDelay/pendingDefaultAdminDelay
    ///

    /**
     * See IAccessControlDefaultAdminRules
     */
    function changeDefaultAdminDelay(uint48 newDelay) public virtual onlyRole(AUTHORIZATION_ENGINE_ROLE) {
        _changeDefaultAdminDelay(newDelay);
    }

    /**
     * See IAccessControlDefaultAdminRules
     */
    function acceptDefaultAdminTransfer() public virtual {
        (address newDefaultAdmin, ) = pendingDefaultAdmin();
        if (_msgSender() != newDefaultAdmin) {
            // Enforce newDefaultAdmin explicit acceptance.
            revert AccessControlInvalidDefaultAdmin(_msgSender());
        }
        _acceptDefaultAdminTransfer();
    }

    /**
     * See IAccessControlDefaultAdminRules
     */
    function cancelDefaultAdminTransfer() public virtual onlyRole(AUTHORIZATION_ENGINE_ROLE) {
        _cancelDefaultAdminTransfer();
    }

    /**
     * See IAccessControlDefaultAdminRules
     */
    function beginDefaultAdminTransfer(address newAdmin) public virtual onlyRole(AUTHORIZATION_ENGINE_ROLE) {
        _beginDefaultAdminTransfer(newAdmin);
    }

    /**
     * See IAccessControlDefaultAdminRules
     */
    function rollbackDefaultAdminDelay() public virtual onlyRole(AUTHORIZATION_ENGINE_ROLE) {
        _rollbackDefaultAdminDelay();
    }


}