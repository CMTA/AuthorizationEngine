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
            IRuleEngineCMTAT(address(0)),
            "CMTAT_info",
            FLAG
        );
        // specific arrange
        vm.prank(DEFAULT_ADMIN_ADDRESS);
        authorizationEngineMock = new AuthorizationEngine(DEFAULT_ADMIN_ADDRESS, ZERO_ADDRESS,   uint48(10), address(CMTAT_CONTRACT));
        vm.prank(DEFAULT_ADMIN_ADDRESS);
    }

    /******* Grant new admin *******/
    function testCannotGrantNewAdminIfNotAuthorized() public {
        // Arrange
        /*vm.prank(ADDRESS1);
        vm.expectRevert(
        abi.encodeWithSelector(Errors.CMTAT_InvalidTransfer.selector, ADDRESS1, ADDRESS2, 21));   
        // Act
        CMTAT_CONTRACT.transfer(ADDRESS2, 21);*/
    }

    /******* Grant new admin *******/

    function testCanGrantNewAdminIfAuthorized() public {
        // Arrange
        /*uint256 amount = 21;
        vm.prank(DEFAULT_ADMIN_ADDRESS);
        ruleWhitelist.addAddressToTheWhitelist(ADDRESS2);

        vm.prank(ADDRESS1);
        vm.expectRevert(
        abi.encodeWithSelector(Errors.CMTAT_InvalidTransfer.selector, ADDRESS1, ADDRESS2, amount));   
        // Act
        CMTAT_CONTRACT.transfer(ADDRESS2, amount);*/
    }
}
