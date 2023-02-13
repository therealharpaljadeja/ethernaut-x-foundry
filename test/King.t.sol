// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "ds-test/test.sol";
import "../src/levels/King/King.sol";
import "../src/levels/King/KingFactory.sol";
import "../src/levels/King/KingAttacker.sol";
import "../src/Ethernaut.sol";
import {Vm} from "forge-std/Vm.sol";

contract KingTest is DSTest {
    Vm private constant vm = Vm(HEVM_ADDRESS);
    Ethernaut ethernaut;
    KingFactory kingFactory;
    address eoa = address(69);

    function setUp() public {
        ethernaut = new Ethernaut();
        kingFactory = new KingFactory();
        ethernaut.registerLevel(kingFactory);
        vm.deal(eoa, 1 ether);
    }

    function testInstanceCleared() public {
        vm.startPrank(eoa);
        address instance = ethernaut.createLevelInstance{value: 0.001 ether}(
            kingFactory
        );
        KingAttacker kingAttacker = new KingAttacker();

        uint256 prize = King(payable(instance)).prize();

        kingAttacker.attack{value: prize}(payable(instance));

        assertTrue(ethernaut.submitLevelInstance(payable(instance)));

        vm.stopPrank();
    }
}
