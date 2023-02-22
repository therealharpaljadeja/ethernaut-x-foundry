// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../src/levels/Fallback/Fallback.sol";
import "../src/levels/Fallback/FallbackFactory.sol";
import "./BaseTest.sol";

contract FallbackTest is BaseTest {
    Fallback public fallbackInstance;
    FallbackFactory fallbackFactory;

    function setUp() public {
        // Initializing Fallback contract.
        fallbackFactory = new FallbackFactory();
        vm.label(0xb4c79daB8f259C7Aee6E5b2Aa729821864227e84, "Fallback Owner");
        super.setUp(fallbackFactory);
    }

    function testIsFallbackCleared() public testWrapper(fallbackFactory, 0) {
        fallbackInstance = Fallback(payable(instance));
        fallbackInstance.contribute{value: 1 wei}();
        assertEq(fallbackInstance.contributions(eoa), 1 wei);
        (bool success, ) = payable(fallbackInstance).call{value: 1 wei}("");
        assertTrue(success);
        fallbackInstance.withdraw();
    }
}
