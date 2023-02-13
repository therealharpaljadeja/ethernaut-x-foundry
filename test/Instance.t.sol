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
    InstanceFactory instanceFactory;

    function setUp() public {
        ethernaut = new Ethernaut();
        instanceFactory = new InstanceFactory();
        ethernaut.registerLevel(instanceFactory);

        assertTrue(ethernaut.registeredLevels(address(instanceFactory)));
    }

    function testInstanceCleared() public {
        vm.startPrank(address(69));
        address instance = ethernaut.createLevelInstance(instanceFactory);
        Instance instanceContract = Instance(instance);
        // Skipping through all the functions and directly calling authenticate with the password.
        instanceContract.authenticate(instanceContract.password());
        // Checking if level is cleared!
        assertTrue(ethernaut.submitLevelInstance(payable(instance)));
        vm.stopPrank();
    }
}
