// SPDX-License-Identifier: MPL-2.0
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../HelperContract.sol";
import "CMTAT/mocks/MinimalForwarderMock.sol";

import "src/AuthorizationEngine.sol";
import "src/AuthorizationEngine.sol";
/**
@title General functions of the AuthorizationEngine
*/
contract AuthorizationEngineTest is Test, HelperContract {
    AuthorizationEngine authorizationEngineMock;
    uint8 resUint8;
    uint256 resUint256;
    bool resBool;
    string resString;
   uint256 FLAG = 5;
    // Arrange
    function setUp() public {
        // CMTAT
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
    }

    function testRightDeployment() public {
        // Arrange
        vm.prank(AUTHORIZATION_ENGINE_OPERATOR_ADDRESS);
        MinimalForwarderMock forwarder = new MinimalForwarderMock(
        );
        forwarder.initialize(ERC2771ForwarderDomain);

 

        // Act
        authorizationEngineMock = new AuthorizationEngine(
            AUTHORIZATION_ENGINE_OPERATOR_ADDRESS,
            address(forwarder),
            uint48(10),
            address(CMTAT_CONTRACT)
        );

        // assert
        resBool = authorizationEngineMock.hasRole(AUTHORIZATION_ENGINE_ROLE, AUTHORIZATION_ENGINE_OPERATOR_ADDRESS);
        assertEq(resBool, true);
        resBool = authorizationEngineMock.isTrustedForwarder(address(forwarder));
        assertEq(resBool, true);
    }

    function testCannotDeployContractifAdminAddressIsZero() public {
        // Arrange
        vm.prank(AUTHORIZATION_ENGINE_OPERATOR_ADDRESS);
        MinimalForwarderMock forwarder = new MinimalForwarderMock(
        );
        forwarder.initialize(ERC2771ForwarderDomain);
        vm.expectRevert(AuthorizationEngine_AdminWithAddressZeroNotAllowed.selector);
        // Act
        authorizationEngineMock = new AuthorizationEngine(
            address(0x0),
            address(forwarder),
            uint48(10),
            address(CMTAT_CONTRACT)
        );
    }
}
