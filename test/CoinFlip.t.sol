// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/console.sol";
import "ds-test/test.sol";
import "../src/Ethernaut.sol";
import "../src/levels/CoinFlip/CoinFlipFactory.sol";
import "../src/levels/CoinFlip/CoinFlipAttacker.sol";
import {Vm} from "forge-std/Vm.sol";

contract CoinFlipTest is DSTest {
    Ethernaut ethernaut;
    CoinFlipFactory coinFlipFactory;
    Vm private constant vm = Vm(HEVM_ADDRESS);
    address eoaAddress = address(69);

    function setUp() public {
        ethernaut = new Ethernaut();
        coinFlipFactory = new CoinFlipFactory();
        ethernaut.registerLevel(coinFlipFactory);
        vm.deal(eoaAddress, 1 ether);
    }

    function testIsCoinFlipCleared() public {
        vm.startPrank(eoaAddress);
        address levelAddress = ethernaut.createLevelInstance(coinFlipFactory);
        CoinFlipAttacker coinFlipAttacker = new CoinFlipAttacker(
            payable(levelAddress)
        );
        for (uint8 i = 0; i <= 10; i++) {
            coinFlipAttacker.attack();
            vm.roll(block.number + 1);
        }
        assertTrue(ethernaut.submitLevelInstance(payable(levelAddress)));
        vm.stopPrank();
    }
}
