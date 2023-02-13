// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/vm.sol";
import "ds-test/test.sol";
import "../src/Ethernaut.sol";
import "../src/levels/DoubleEntryPoint/DoubleEntryPointFactory.sol";
import "../src/levels/DoubleEntryPoint/DoubleEntryPointFortaBot.sol";

contract DoubleEntryPointTest is DSTest {
    Ethernaut ethernaut;
    DoubleEntryPointFactory doubleEntryPointFactory;
    Vm private constant vm = Vm(HEVM_ADDRESS);
    address eoa = address(69);

    function setUp() public {
        ethernaut = new Ethernaut();
        doubleEntryPointFactory = new DoubleEntryPointFactory();
        ethernaut.registerLevel(doubleEntryPointFactory);
    }

    function testIsDoubleEntryPointCleared() public {
        vm.startPrank(eoa);

        address instance = ethernaut.createLevelInstance(
            doubleEntryPointFactory
        );

        FortaBot doubleEntryPointFortaBot = new FortaBot();

        DoubleEntryPoint doubleEntryPoint = DoubleEntryPoint(instance);
        Forta(doubleEntryPoint.forta()).setDetectionBot(
            address(doubleEntryPointFortaBot)
        );

        assertTrue(ethernaut.submitLevelInstance(payable(instance)));

        vm.stopPrank();
    }
}
