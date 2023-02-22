// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../src/levels/Fallout/Fallout.sol";
import "../src/levels/Fallout/FalloutFactory.sol";
import "./BaseTest.sol";

contract FalloutTest is BaseTest {
    Fallout public falloutInstance;
    FalloutFactory falloutFactory;

    function setUp() public {
        // Initializing Fallout contract.
        falloutFactory = new FalloutFactory();
        vm.label(0xb4c79daB8f259C7Aee6E5b2Aa729821864227e84, "Fallout Owner");
        super.setUp(falloutFactory);
    }

    function testIsFalloutCleared() public testWrapper(falloutFactory, 0) {
        falloutInstance = Fallout(payable(instance));
        falloutInstance.Fal1out();
    }
}
