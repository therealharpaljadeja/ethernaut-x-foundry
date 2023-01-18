// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "ds-test/test.sol";
import "../src/levels/Reentrance/ReentranceFactory.sol";
import "../src/levels/Reentrance/ReentranceAttacker.sol";
import "../src/Ethernaut.sol";
import {Vm} from "forge-std/Vm.sol";

contract ReentranceTest is DSTest {
    Ethernaut ethernaut;
    ReentranceFactory reentranceFactory;
    Vm private constant vm = Vm(HEVM_ADDRESS);
    address eoaAddress = address(69);

    function setUp() public {
        ethernaut = new Ethernaut();
        reentranceFactory = new ReentranceFactory();
        ethernaut.registerLevel(reentranceFactory);
        vm.deal(eoaAddress, 1 ether);
    }

    function testIsReentranceCleared() public {
        vm.startPrank(eoaAddress);

        uint256 amount = reentranceFactory.insertCoin();

        address levelAddress = ethernaut.createLevelInstance{value: amount}(
            reentranceFactory
        );

        ReentranceAttacker reentranceAttacker = new ReentranceAttacker(
            levelAddress
        );

        reentranceAttacker.attack{value: amount}();

        assertTrue(ethernaut.submitLevelInstance(payable(levelAddress)));

        vm.stopPrank();
    }
}
