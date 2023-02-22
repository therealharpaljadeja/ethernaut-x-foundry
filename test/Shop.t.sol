// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../src/levels/Shop/Shop.sol";
import "../src/levels/Shop/ShopFactory.sol";
import "../src/levels/Shop/ShopAttacker.sol";
import "./BaseTest.sol";

contract ShopTest is BaseTest {
    ShopFactory shopFactory;

    function setUp() public {
        shopFactory = new ShopFactory();
        super.setUp(shopFactory);
    }

    function testIsShopCleared() public testWrapper(shopFactory, 0) {
        ShopAttacker shopAttacker = new ShopAttacker(instance);

        shopAttacker.attack();
    }
}
