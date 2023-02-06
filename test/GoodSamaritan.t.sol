// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/vm.sol";
import "ds-test/test.sol";
import "../src/levels/GoodSamaritan/GoodSamaritanFactory.sol";
import "../src/levels/GoodSamaritan/BadSamaritan.sol";
import "../src/Ethernaut.sol";

contract GoodSamaritanTest is DSTest {
    Ethernaut ethernaut;
    GoodSamaritanFactory goodSamaritanFactory;
    address eoaAddress = address(69);
    Vm private constant vm = Vm(HEVM_ADDRESS);

    function setUp() public {
        ethernaut = new Ethernaut();
        goodSamaritanFactory = new GoodSamaritanFactory();
        ethernaut.registerLevel(goodSamaritanFactory);
    }

    function testIsGoodSamaritanCleared() public {
        vm.startPrank(eoaAddress);

        address instance = ethernaut.createLevelInstance(goodSamaritanFactory);
        BadSamaritan badSamaritan = new BadSamaritan();

        badSamaritan.requestDonation(instance);

        ethernaut.submitLevelInstance(payable(instance));

        vm.stopPrank();
    }
}
