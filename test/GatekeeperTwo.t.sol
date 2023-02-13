// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "ds-test/test.sol";
import {Vm} from "forge-std/vm.sol";
import "../src/levels/GatekeeperTwo/GatekeeperTwoFactory.sol";
import "../src/levels/GatekeeperTwo/GatekeeperTwoAttacker.sol";
import "../src/Ethernaut.sol";

contract GatekeeperTwoTest is DSTest {
    Ethernaut ethernaut;
    GatekeeperTwoFactory gatekeeperTwoFactory;
    Vm private constant vm = Vm(HEVM_ADDRESS);

    function setUp() public {
        ethernaut = new Ethernaut();
        gatekeeperTwoFactory = new GatekeeperTwoFactory();
        ethernaut.registerLevel(gatekeeperTwoFactory);
    }

    function testIsGatekeeperTwoCleared() public {
        vm.startPrank(0x1804c8AB1F12E6bbf3894d4083f33e07309d1f38);
        address instance = ethernaut.createLevelInstance(gatekeeperTwoFactory);

        new GatekeeperTwoAttacker(instance);

        assertTrue(ethernaut.submitLevelInstance(payable(instance)));
        vm.stopPrank();
    }
}
