// SPDX-License-Identifier: MPL-2.0
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../../HelperContract.sol";
import "src/AuthorizationEngine.sol";

/**
@title Tests on the Access Control
*/
contract AuthorizationEngineAccessControlTest is Test, HelperContract {
    // Custom error openZeppelin
    error AccessControlUnauthorizedAccount(address account, bytes32 neededRole);
    AuthorizationEngine authorizationEngineMock;
    uint8 resUint8;
    uint256 resUint256;
    bool resBool;
    string resString;
    uint8 CODE_NONEXISTENT = 255;
    uint256 FLAG = 5;
    uint48 DEFAULT_ADMIN_DELAY_WEB3 = 10;
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
}
