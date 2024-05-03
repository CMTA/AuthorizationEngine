// SPDX-License-Identifier: MPL-2.0
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../../HelperContract.sol";
import "src/AuthorizationEngine.sol";

/**
@title Tests on the Access Control
*/
contract AuthorizationEngineAccessControlTest is Test, HelperContract {
    error AccessControlInvalidDefaultAdmin(address defaultAdmin);
    // Custom error openZeppelin
    error AccessControlUnauthorizedAccount(address account, bytes32 neededRole);
    error AccessControlEnforcedDefaultAdminDelay(uint48 schedule);
    AuthorizationEngine authorizationEngineMock;
    uint8 resUint8;
    uint256 resUint256;
    bool resBool;
    string resString;
    uint8 CODE_NONEXISTENT = 255;
    uint256 FLAG = 5;
    uint48 DEFAULT_ADMIN_DELAY_WEB3 = 10;
    uint48 DEFAULT_ADMIN_NEW_DELAY_WEB3 = 200;
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
            IRuleEngine(address(0)),
            "CMTAT_info",
            FLAG
        );
        vm.prank(AUTHORIZATION_ENGINE_OPERATOR_ADDRESS);
        authorizationEngineMock = new AuthorizationEngine(
            AUTHORIZATION_ENGINE_OPERATOR_ADDRESS,
            ZERO_ADDRESS,
            DEFAULT_ADMIN_DELAY_WEB3,
            address(CMTAT_CONTRACT)
        );
        // Set the CMTAT to use the authorizationEngine
        vm.prank(DEFAULT_ADMIN_ADDRESS);
        CMTAT_CONTRACT.setAuthorizationEngine(authorizationEngineMock);
    }


    function testAdminCanTransferAdminiship() public { 
        // Arrange
        // Act 1
        // Starts an admin transfer
        // Act
        vm.prank(AUTHORIZATION_ENGINE_OPERATOR_ADDRESS);
        authorizationEngineMock.beginDefaultAdminTransfer(ADDRESS1);


        // Wait for acceptance
        // We jump into the future
        vm.warp(DEFAULT_ADMIN_DELAY_WEB3 + 2);

        // New admin accept the transfer
        vm.prank(ADDRESS1);
        AuthorizationEngine(authorizationEngineMock).acceptDefaultAdminTransfer();
    }

    function testAdminCanTransferAdminishipWithCMTAT() public { 
        // Initial assert
        vm.expectRevert(
        abi.encodeWithSelector(CMTAT_AuthorizationModule_InvalidAuthorization.selector));   
        vm.prank(DEFAULT_ADMIN_ADDRESS);
        CMTAT_CONTRACT.grantRole(bytes32(0x0), ADDRESS1);
        // Arrange
        // Act 1
        // Starts an admin transfer
        // Act
        vm.prank(AUTHORIZATION_ENGINE_OPERATOR_ADDRESS);
        authorizationEngineMock.beginDefaultAdminTransfer(ADDRESS1);


        // Wait for acceptance
        // We jump into the future
        vm.warp(DEFAULT_ADMIN_DELAY_WEB3 + 2);

        // New admin accept the transfer
        vm.prank(ADDRESS1);
        authorizationEngineMock.acceptDefaultAdminTransfer();

        vm.prank(DEFAULT_ADMIN_ADDRESS);
        CMTAT_CONTRACT.grantRole(bytes32(0x0), ADDRESS1);
    }

    function testCannotAcceptAdminishipIfWrongSender() public { 
        // Arrange
        // Act 1
        // Starts an admin transfer
        vm.prank(AUTHORIZATION_ENGINE_OPERATOR_ADDRESS);
        authorizationEngineMock.beginDefaultAdminTransfer(ADDRESS1);


        // Wait for acceptance
        // We jump into the future
        vm.warp(DEFAULT_ADMIN_DELAY_WEB3 + 2);

        // Act
        // Wrong admin accept the transfer
        vm.expectRevert(
        abi.encodeWithSelector(AccessControlInvalidDefaultAdmin.selector, ADDRESS2)); 
        vm.prank(ADDRESS2);
        AuthorizationEngine(authorizationEngineMock).acceptDefaultAdminTransfer();
    }

    function testAdminCanRollbackDelay() public { 
        // Arrange
        // Act 
        vm.prank(AUTHORIZATION_ENGINE_OPERATOR_ADDRESS);
        authorizationEngineMock.rollbackDefaultAdminDelay();
    }


    function testAdminCanChangeDefaultAdminDelay() public { 
        // Act 
        vm.prank(AUTHORIZATION_ENGINE_OPERATOR_ADDRESS);
        authorizationEngineMock.changeDefaultAdminDelay(DEFAULT_ADMIN_NEW_DELAY_WEB3);


        // We jump into the future with the default delay to have the change 
        // When increasing the delay, we schedule the delay change to occur after a period of "new delay" has passed, up
        // to a maximum given by defaultAdminDelayIncreaseWait, by default 5 days. For example, if increasing from 1 day
        // to 3 days, the new delay will come into effect after 3 days. If increasing from 1 day to 10 days, the new
        // delay will come into effect after 5 days. The 5 day wait period is intended to be able to fix an error like
        // using milliseconds instead of seconds.
        //
        // Act + Assert
        uint256 newScheduleDelay;
        uint256 schduleApply;
        (newScheduleDelay, schduleApply) = authorizationEngineMock.pendingDefaultAdminDelay();
        assertEq(newScheduleDelay, DEFAULT_ADMIN_NEW_DELAY_WEB3);
        assertEq(schduleApply,DEFAULT_ADMIN_NEW_DELAY_WEB3  + 1);
        uint256 jump= DEFAULT_ADMIN_DELAY_WEB3 + DEFAULT_ADMIN_NEW_DELAY_WEB3 + 2;
        vm.warp(jump);


        // Act + assert
        (newScheduleDelay, schduleApply) = authorizationEngineMock.pendingDefaultAdminDelay();
        assertEq(newScheduleDelay, 0);
        assertEq(schduleApply,0);

        // vm.warp(block.timestamp + 2000000);
        uint256 schedule = block.timestamp + DEFAULT_ADMIN_NEW_DELAY_WEB3;
        // Arrange
        vm.prank(AUTHORIZATION_ENGINE_OPERATOR_ADDRESS);
        authorizationEngineMock.beginDefaultAdminTransfer(ADDRESS1);
        jump = block.timestamp + DEFAULT_ADMIN_DELAY_WEB3 + 2;
        vm.warp(jump);
        // Assert
        // old delay failed
        vm.prank(ADDRESS1);
        vm.expectRevert(
        abi.encodeWithSelector(AccessControlEnforcedDefaultAdminDelay.selector, schedule));
        AuthorizationEngine(authorizationEngineMock).acceptDefaultAdminTransfer();

        // We jump into the future with the default delay to have the change (5 days)
        vm.warp(block.timestamp + 2000000);

        // Assert
        vm.prank(ADDRESS1);
        AuthorizationEngine(authorizationEngineMock).acceptDefaultAdminTransfer();
    }

    function testAdminCanCancelDefaultAdminTransfer() public {
        // Arrange
        vm.prank(AUTHORIZATION_ENGINE_OPERATOR_ADDRESS);
        authorizationEngineMock.beginDefaultAdminTransfer(ADDRESS1);

        // Act
        vm.prank(AUTHORIZATION_ENGINE_OPERATOR_ADDRESS);
        authorizationEngineMock.cancelDefaultAdminTransfer();


        // Wait for acceptance
        // We jump into the future
        vm.warp(DEFAULT_ADMIN_DELAY_WEB3 + 2);

        // New admin can not accept the transfer
        vm.expectRevert(
        abi.encodeWithSelector(AccessControlInvalidDefaultAdmin.selector, ADDRESS1));
        vm.prank(ADDRESS1);
        AuthorizationEngine(authorizationEngineMock).acceptDefaultAdminTransfer();
    }
}
