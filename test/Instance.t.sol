// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "ds-test/test.sol";
import "../src/levels/Instance/Instance.sol";
import "../src/levels/Instance/InstanceFactory.sol";
import "../src/Ethernaut.sol";
import {Vm} from "forge-std/Vm.sol";

contract InstanceTest is DSTest {
    Vm private constant vm = Vm(HEVM_ADDRESS);
    Ethernaut ethernaut;
    Instance instance;
    address instance;
    InstanceFactory instanceFactory;

    function setUp() public {
        ethernaut = new Ethernaut();
        instanceFactory = new InstanceFactory();
        ethernaut.registerLevel(instanceFactory);

        assertTrue(ethernaut.registeredLevels(address(instanceFactory)));
    }

    function testInstanceCleared() public {
        vm.startPrank(address(69));
        instance = ethernaut.createLevelInstance(instanceFactory);
        instance = Instance(instance);
        // Skipping through all the functions and directly calling authenticate with the password.
        instance.authenticate(instance.password());
        // Checking if level is cleared!
        assertTrue(ethernaut.submitLevelInstance(payable(instance)));
        vm.stopPrank();
    }
}
