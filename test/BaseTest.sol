// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../src/Ethernaut.sol";
import "ds-test/test.sol";
import "forge-std/vm.sol";

contract BaseTest is DSTest {
    Ethernaut ethernaut;
    address eoa = address(69);
    Vm constant vm = Vm(HEVM_ADDRESS);
    address instance;

    function setUp(Level _level) internal {
        ethernaut = new Ethernaut();
        ethernaut.registerLevel(_level);
        vm.deal(eoa, 100 ether);
    }

    modifier testWrapper(Level _level) {
        vm.startPrank(eoa);
        instance = ethernaut.createLevelInstance(_level);
        _;
        assertTrue(ethernaut.submitLevelInstance(payable(instance)));
        vm.stopPrank();
    }
}
