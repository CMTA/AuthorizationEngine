// SPDX-License-Identifier: MPL-2.0
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "CMTAT/CMTAT_STANDALONE.sol";
import "./HelperContract.sol";
import "src/AuthorizationEngine.sol";

/**
@title Integration test with the CMTAT
*/
contract CMTATIntegration is Test, HelperContract {
    // Defined in CMTAT.sol
    uint8 constant TRANSFER_OK = 0;
    string constant TEXT_TRANSFER_OK = "No restriction";

    AuthorizationEngine authorizationEngineMock;
    uint256 resUint256;
    bool resBool;

    uint256 ADDRESS1_BALANCE_INIT = 31;
    uint256 ADDRESS2_BALANCE_INIT = 32;
    uint256 ADDRESS3_BALANCE_INIT = 33;

    uint256 FLAG = 5;

    uint48 DEFAULT_ADMIN_DELAY_WEB3 = 10;
    bytes32 PAUSER_ROLE = 0x65d7a28e3265b37a6474929f336521b332c1681b933f6cb9f3376673440d862a;

    // Arrange
    function setUp() public {
        // global arrange
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
        // specific arrange
        vm.prank(DEFAULT_ADMIN_ADDRESS);
        authorizationEngineMock = new AuthorizationEngine(DEFAULT_ADMIN_ADDRESS, ZERO_ADDRESS,   uint48(10), address(CMTAT_CONTRACT));
    }

    /******* Grant new admin *******/
    function testCannotGrantNewAdminIfNotAuthorized() public {
        // Arrange
        vm.prank(DEFAULT_ADMIN_ADDRESS);
        CMTAT_CONTRACT.setAuthorizationEngine(authorizationEngineMock);
        vm.expectRevert(
        abi.encodeWithSelector(Errors.CMTAT_AuthorizationModule_InvalidAuthorization.selector));
        // Act
        vm.prank(DEFAULT_ADMIN_ADDRESS);
        CMTAT_CONTRACT.grantRole(DEFAULT_ADMIN_ROLE, ADDRESS2);
    }

    /******* Grant new admin *******/

    function testCanGrantNewAdminIfAuthorized() public {
        // Arrange CMTAT
        vm.prank(DEFAULT_ADMIN_ADDRESS);
        CMTAT_CONTRACT.setAuthorizationEngine(authorizationEngineMock);
        
        // Arrange AuthorizationEngine
        // Starts an admin transfer
        vm.prank(DEFAULT_ADMIN_ADDRESS);
        authorizationEngineMock.beginDefaultAdminTransfer(ADDRESS1);

        // Wait for acceptance
        // We jump into the future
        vm.warp(DEFAULT_ADMIN_DELAY_WEB3 + 2);

        // New admin accept the transfer
        vm.prank(ADDRESS1);
        AuthorizationEngine(authorizationEngineMock).acceptDefaultAdminTransfer();
        
        // Act
        vm.prank(DEFAULT_ADMIN_ADDRESS);
        CMTAT_CONTRACT.grantRole(DEFAULT_ADMIN_ROLE, ADDRESS1);
    }
    function testCanGrantOtherRoleWithoutRestriction() public {
        // Arrange CMTAT
        vm.prank(DEFAULT_ADMIN_ADDRESS);
        CMTAT_CONTRACT.setAuthorizationEngine(authorizationEngineMock);
        
        // Act
        vm.prank(DEFAULT_ADMIN_ADDRESS);
        CMTAT_CONTRACT.grantRole(PAUSER_ROLE, ADDRESS1);
    }
}
