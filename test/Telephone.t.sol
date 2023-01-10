// SPDX-Identifer: MIT
pragma solidity ^0.8.0;

import "ds-test/test.sol";
import "../src/Ethernaut.sol";
import "../src/levels/Telephone/TelephoneFactory.sol";
import "../src/levels/Telephone/TelephoneAttacker.sol";
import {Vm} from "forge-std/Vm.sol";

contract TelephoneTest is DSTest {
    Vm private constant vm = Vm(HEVM_ADDRESS);
    Ethernaut ethernaut;
    TelephoneFactory telephoneFactory;
    address eoaAddress = address(69);

    function setUp() public {
        ethernaut = new Ethernaut();
        telephoneFactory = new TelephoneFactory();
        ethernaut.registerLevel(telephoneFactory);
        vm.deal(eoaAddress, 1 ether);
    }

    function testIsTelephoneCleared() public {
        vm.startPrank(eoaAddress);

        address victim = ethernaut.createLevelInstance(telephoneFactory);
        TelephoneAttacker telephoneAttacker = new TelephoneAttacker(victim);
        telephoneAttacker.attack();

        assertTrue(ethernaut.submitLevelInstance(payable(victim)));

        vm.stopPrank();
    }
}
