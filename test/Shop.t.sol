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
    address eoaAddress = address(69);

    function setUp() public {
        ethernaut = new Ethernaut();
        shopFactory = new ShopFactory();

        ethernaut.registerLevel(shopFactory);
    }

    function testIsShopCleared() public {
        vm.startPrank(eoaAddress);

        address instanceAddress = ethernaut.createLevelInstance(shopFactory);

        ShopAttacker shopAttacker = new ShopAttacker(instanceAddress);

        shopAttacker.attack();

        assertTrue(ethernaut.submitLevelInstance(payable(instanceAddress)));

        vm.stopPrank();
    }
}
