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
    address eoaAddress = address(69);

    function setUp() public {
        ethernaut = new Ethernaut();
        privacyFactory = new PrivacyFactory();
        ethernaut.registerLevel(privacyFactory);

        vm.deal(eoaAddress, 1 ether);
    }

    function testIsPrivacyCleared() public {
        vm.startPrank(eoaAddress);

        address levelAddress = ethernaut.createLevelInstance(privacyFactory);
        bytes32 slot = vm.load(levelAddress, bytes32(uint256(5)));
        bytes16 key = bytes16(slot);
        Privacy(levelAddress).unlock(key);

        assertTrue(ethernaut.submitLevelInstance(payable(levelAddress)));

        vm.stopPrank();
    }
}
