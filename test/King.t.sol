// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../src/levels/King/King.sol";
import "../src/levels/King/KingFactory.sol";
import "../src/levels/King/KingAttacker.sol";
import "./BaseTest.sol";

contract KingTest is BaseTest {
    KingFactory kingFactory;

    function setUp() public {
        kingFactory = new KingFactory();
        super.setUp(kingFactory);
    }

    function testInstanceCleared() public testWrapper(kingFactory, 0) {
        KingAttacker kingAttacker = new KingAttacker();
        uint256 prize = King(payable(instance)).prize();
        kingAttacker.attack{value: prize}(payable(instance));
    }
}
