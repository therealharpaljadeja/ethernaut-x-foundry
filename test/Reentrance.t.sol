// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../src/levels/Reentrance/ReentranceFactory.sol";
import "../src/levels/Reentrance/ReentranceAttacker.sol";
import "./BaseTest.sol";

contract ReentranceTest is BaseTest {
    ReentranceFactory reentranceFactory;

    function setUp() public {
        reentranceFactory = new ReentranceFactory();
        super.setUp(reentranceFactory);
    }

    function testIsReentranceCleared() public {
        vm.startPrank(eoa);

        uint256 amount = reentranceFactory.insertCoin();

        address instance = ethernaut.createLevelInstance{value: amount}(
            reentranceFactory
        );

        ReentranceAttacker reentranceAttacker = new ReentranceAttacker(
            instance
        );

        reentranceAttacker.attack{value: amount}();

        assertTrue(ethernaut.submitLevelInstance(payable(instance)));

        vm.stopPrank();
    }
}
