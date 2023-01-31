// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "ds-test/test.sol";
import "forge-std/vm.sol";
import "../src/levels/Denial/DenialFactory.sol";
import "../src/Ethernaut.sol";
import "../src/levels/Denial/DenialReceiver.sol";

contract DenialTest is DSTest {
    Ethernaut ethernaut;
    DenialFactory denialFactory;
    Vm private constant vm = Vm(HEVM_ADDRESS);
    address eoaAddress = address(69);

    function setUp() public {
        ethernaut = new Ethernaut();
        denialFactory = new DenialFactory();

        ethernaut.registerLevel(denialFactory);
    }

    function testIsDenialCleared() public {
        vm.startPrank(eoaAddress);
        vm.deal(eoaAddress, 1 ether);

        address instanceAddress = ethernaut.createLevelInstance{
            value: 0.001 ether
        }(denialFactory);

        DenialReceiver denialReceiver = new DenialReceiver();
        Denial denial = Denial(payable(instanceAddress));
        denial.setWithdrawPartner(address(denialReceiver));

        assertTrue(ethernaut.submitLevelInstance(payable(instanceAddress)));

        vm.stopPrank();
    }
}