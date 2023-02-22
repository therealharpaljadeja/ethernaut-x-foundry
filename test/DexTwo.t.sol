// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../src/levels/DexTwo/DexTwoFactory.sol";
import "../src/levels/DexTwo/MaliciousToken.sol";
import "./BaseTest.sol";

contract DexTwoTest is BaseTest {
    DexTwoFactory dexTwoFactory;

    function setUp() public {
        dexTwoFactory = new DexTwoFactory();
        super.setUp(dexTwoFactory);
    }

    function testIsDexTwoCleared() public testWrapper(dexTwoFactory, 0) {
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
    }
}
