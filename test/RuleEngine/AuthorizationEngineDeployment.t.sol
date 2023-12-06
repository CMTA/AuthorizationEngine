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
contract AUTHORIZATIONEngineTest is Test, HelperContract {
    AuthorizationEngine authorizationEngineMock;
    uint8 resUint8;
    uint256 resUint256;
    bool resBool;
    string resString;

    // Arrange
    function setUp() public {
       
    }

    function testRightDeployment() public {
        // Arrange
        vm.prank(AUTHORIZATION_ENGINE_OPERATOR_ADDRESS);
        MinimalForwarderMock forwarder = new MinimalForwarderMock(
        );
        forwarder.initialize(ERC2771ForwarderDomain);

        // Act
        authorizationEngineMock = new AUTHORIZATIONEngine(
            AUTHORIZATION_ENGINE_OPERATOR_ADDRESS,
            address(forwarder)
        );

        // assert
        resBool = authorizationEngineMock.hasRole(AUTHORIZATION_ENGINE_ROLE, AUTHORIZATION_ENGINE_OPERATOR_ADDRESS);
        assertEq(resBool, true);
        resBool = authorizationEngineMock.isTrustedForwarder(address(forwarder));
        assertEq(resBool, true);
    }

    function testCannotDeployContractifAdminAddressIsZero() public {
        // Arrange
        vm.prank(WHITELIST_OPERATOR_ADDRESS);
        MinimalForwarderMock forwarder = new MinimalForwarderMock(
        );
        forwarder.initialize(ERC2771ForwarderDomain);
        vm.expectRevert(AuthorizationEngine_AdminWithAddressZeroNotAllowed.selector);
        // Act
        authorizationEngineMock = new AUTHORIZATIONEngine(
            address(0x0),
            address(forwarder)
        );
    }
}
