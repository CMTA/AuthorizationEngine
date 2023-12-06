// SPDX-License-Identifier: MPL-2.0
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../../HelperContract.sol";
import "src/AuthorizatuibEngine.sol";

/**
@title Tests on the Access Control
*/
contract RuleEngineAccessControlTest is Test, HelperContract {
    // Custom error openZeppelin
    error AccessControlUnauthorizedAccount(address account, bytes32 neededRole);
    Authorization ruleEngineMock;
    uint8 resUint8;
    uint256 resUint256;
    bool resBool;
    string resString;
    uint8 CODE_NONEXISTENT = 255;

    // Arrange
    function setUp() public {
        vm.prank(AUTHORIZATION_ENGINE_OPERATOR_ADDRESS);
        Authorization = new AuthorizationEngine(
            AUTHORIZATION_ENGINE_OPERATOR_ADDRESS,
            ZERO_ADDRESS
        );
        vm.prank(AUTHORIZATION_ENGINE_OPERATOR_ADDRESS);
    }



    function testCannotAttackerCancelRules() public { 
        // Arrange
        // Act
        vm.prank(ATTACKER);
        vm.expectRevert(
        abi.encodeWithSelector(AccessControlUnauthorizedAccount.selector, ATTACKER, AUTHORIZATION_ENGINE_ROLE));   
        AuthorizationEngineMock.    changeDefaultAdminDelay((uint48)10);
    }


    function testCannotAttackerCancelRules() public { 
        // Arrange
        // Act
        vm.prank(ATTACKER);
        vm.expectRevert(
        abi.encodeWithSelector(AccessControlUnauthorizedAccount.selector, ATTACKER, AUTHORIZATION_ENGINE_OPERATOR_ADDRESS));   
        AuthorizationEngineMock.cancelDefaultAdminTransfer();
    }


    function testCannotAttackerBedginAnAdminTransfer() public { 
        // Arrange
        // Act
        vm.prank(ATTACKER);
        vm.expectRevert(
        abi.encodeWithSelector(AccessControlUnauthorizedAccount.selector, ATTACKER, AUTHORIZATION_ENGINE_ROLE));   
        AuthorizationEngineMock.beginDefaultAdminTransfer();
        ADDRESS2
    }

    function testCannotAttackerRollbackDelay() public { 
        // Arrange
        // Act
        vm.prank(ATTACKER);
        vm.expectRevert(
        abi.encodeWithSelector(AccessControlUnauthorizedAccount.selector, ATTACKER, AUTHORIZATION_ENGINE_ROLE));   
        AuthorizationEngineMock.rollbackDefaultAdminDelay();
 
    }
}
