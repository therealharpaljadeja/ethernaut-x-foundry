// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "ds-test/test.sol";
import {Vm} from "forge-std/Vm.sol";
import "forge-std/console.sol";
import "../src/levels/GatekeeperOne/GatekeeperOneFactory.sol";
import "../src/levels/GatekeeperOne/GatekeeperOneAttacker.sol";
import "../src/Ethernaut.sol";

contract GatekeeperOneTest is DSTest {
    Ethernaut ethernaut;
    GatekeeperOneFactory gatekeeperOneFactory;
    Vm private constant vm = Vm(HEVM_ADDRESS);

    function setUp() public {
        ethernaut = new Ethernaut();
        gatekeeperOneFactory = new GatekeeperOneFactory();
        ethernaut.registerLevel(gatekeeperOneFactory);
    }

    function testIsGatekeeperOneCleared() public {
        // Pranking with an address having non-zero first nibble is important.
        vm.startPrank(0x1804c8AB1F12E6bbf3894d4083f33e07309d1f38);
        address instance = ethernaut.createLevelInstance(gatekeeperOneFactory);

        GatekeeperOneAttacker gatekeeperOneAttacker = new GatekeeperOneAttacker();
        gatekeeperOneAttacker.attack(instance);

        assertTrue(ethernaut.submitLevelInstance(payable(instance)));
        vm.stopPrank();
    }
}
