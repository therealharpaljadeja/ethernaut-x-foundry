// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "ds-test/test.sol";
import "forge-std/vm.sol";
import "../src/levels/Shop/Shop.sol";
import "../src/levels/Shop/ShopFactory.sol";
import "../src/levels/Shop/ShopAttacker.sol";
import "../src/Ethernaut.sol";

contract ShopTest is DSTest {
    Ethernaut ethernaut;
    ShopFactory shopFactory;
    Vm private constant vm = Vm(HEVM_ADDRESS);
    address eoa = address(69);

    function setUp() public {
        ethernaut = new Ethernaut();
        shopFactory = new ShopFactory();

        ethernaut.registerLevel(shopFactory);
    }

    function testIsShopCleared() public {
        vm.startPrank(eoa);

        address instance = ethernaut.createLevelInstance(shopFactory);

        ShopAttacker shopAttacker = new ShopAttacker(instance);

        shopAttacker.attack();

        assertTrue(ethernaut.submitLevelInstance(payable(instance)));

        vm.stopPrank();
    }
}
