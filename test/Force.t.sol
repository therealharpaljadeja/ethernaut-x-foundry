// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "ds-test/test.sol";
import "../src/Ethernaut.sol";
import "../src/levels/Force/ForceFactory.sol";
import "../src/levels/Force/ForceAttacker.sol";
import {Vm} from "forge-std/Vm.sol";

contract ForceTest is DSTest {
    Ethernaut ethernaut;
    ForceFactory forceFactory;
    Vm private constant vm = Vm(HEVM_ADDRESS);
    address eoa = address(69);

    function setUp() public {
        ethernaut = new Ethernaut();
        forceFactory = new ForceFactory();
        ethernaut.registerLevel(forceFactory);
        vm.deal(eoa, 1 ether);
    }

    function testIsForceCleared() public {
        vm.startPrank(eoa);
        ForceAttacker forceAttacker = new ForceAttacker();
        vm.deal(address(forceAttacker), 1 ether);

        address instance = ethernaut.createLevelInstance(forceFactory);
        forceAttacker.attack(payable(instance));

        assertTrue(ethernaut.submitLevelInstance(payable(instance)));
        vm.stopPrank();
    }
}
