// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../src/levels/NaughtCoin/NaughtCoinFactory.sol";
import "../src/levels/NaughtCoin/NaughtCoin.sol";
import "./BaseTest.sol";

contract NaughtCoinTest is BaseTest {
    NaughtCoinFactory naughtCoinFactory;
    address spender = address(96);

    function setUp() public {
        naughtCoinFactory = new NaughtCoinFactory();
        super.setUp(naughtCoinFactory);
    }

    function testIsNaughtCoinCleared()
        public
        testWrapper(naughtCoinFactory, 0)
    {
        NaughtCoin naughtCoin = NaughtCoin(instance);

        uint256 amount = naughtCoin.balanceOf(eoa);
        naughtCoin.approve(spender, amount);
        vm.stopPrank();

        vm.prank(spender);
        naughtCoin.transferFrom(eoa, spender, amount);

        vm.startPrank(eoa);
    }
}
