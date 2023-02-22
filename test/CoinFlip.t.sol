// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./BaseTest.sol";
import "../src/levels/CoinFlip/CoinFlipFactory.sol";
import "../src/levels/CoinFlip/CoinFlipAttacker.sol";

contract CoinFlipTest is BaseTest {
    CoinFlipFactory coinFlipFactory;

    function setUp() public {
        coinFlipFactory = new CoinFlipFactory();
        super.setUp(coinFlipFactory);
    }

    function testIsCoinFlipCleared() public testWrapper(coinFlipFactory) {
        CoinFlipAttacker coinFlipAttacker = new CoinFlipAttacker(
            payable(instance)
        );
        for (uint8 i = 0; i <= 10; i++) {
            coinFlipAttacker.attack();
            vm.roll(block.number + 1);
        }
    }
}
