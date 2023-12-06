// SPDX-License-Identifier: MPL-2.0
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../../HelperContract.sol";
import "src/AuthorizationEngine.sol";

/**
@title Tests on the Access Control
*/
contract RuleEngineAccessControlTest is Test, HelperContract {
    // Custom error openZeppelin
    error AccessControlUnauthorizedAccount(address account, bytes32 neededRole);
    AuthorizationEngine authorizationEngineMock;
    uint8 resUint8;
    uint256 resUint256;
    bool resBool;
    string resString;
    uint8 CODE_NONEXISTENT = 255;
    uint256 FLAG = 5;
    // Arrange
    function setUp() public {
        uint8 decimals = 0;
        vm.prank(DEFAULT_ADMIN_ADDRESS);
        CMTAT_CONTRACT = new CMTAT_STANDALONE(
            ZERO_ADDRESS,
            DEFAULT_ADMIN_ADDRESS,
            IAuthorizationEngine(address(0)),
            "CMTA Token",
            "CMTAT",
            decimals,
            "CMTAT_ISIN",
            "https://cmta.ch",
            IRuleEngineCMTAT(address(0)),
            "CMTAT_info",
            FLAG
        );
        vm.prank(AUTHORIZATION_ENGINE_OPERATOR_ADDRESS);
        authorizationEngineMock = new AuthorizationEngine(
            AUTHORIZATION_ENGINE_OPERATOR_ADDRESS,
            ZERO_ADDRESS,
             uint48(10),
            address(CMTAT_CONTRACT)
        );
        vm.prank(AUTHORIZATION_ENGINE_OPERATOR_ADDRESS);
    }



    function testCannotAttackerChangeDefaultAdminDelay() public { 
        // Arrange
        // Act
        vm.prank(ATTACKER);
        vm.expectRevert(
        abi.encodeWithSelector(AccessControlUnauthorizedAccount.selector, ATTACKER, AUTHORIZATION_ENGINE_ROLE));   
        authorizationEngineMock.    changeDefaultAdminDelay(uint48(48));
    }


    function testCannotAttackerCancelAdminTransfer() public { 
        // Arrange
        // Act
        vm.prank(ATTACKER);
        vm.expectRevert(
        abi.encodeWithSelector(AccessControlUnauthorizedAccount.selector, ATTACKER, AUTHORIZATION_ENGINE_ROLE));   
        authorizationEngineMock.cancelDefaultAdminTransfer();
    }


    function testCannotAttackerBedginAnAdminTransfer() public { 
        // Arrange
        // Act
        vm.prank(ATTACKER);
        vm.expectRevert(
        abi.encodeWithSelector(AccessControlUnauthorizedAccount.selector, ATTACKER, AUTHORIZATION_ENGINE_ROLE));   
        authorizationEngineMock.beginDefaultAdminTransfer(ADDRESS2);
    }

    function testCannotAttackerRollbackDelay() public { 
        // Arrange
        // Act
        vm.prank(ATTACKER);
        vm.expectRevert(
        abi.encodeWithSelector(AccessControlUnauthorizedAccount.selector, ATTACKER, AUTHORIZATION_ENGINE_ROLE));   
        authorizationEngineMock.rollbackDefaultAdminDelay();
    }
}
