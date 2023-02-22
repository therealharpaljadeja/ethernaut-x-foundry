// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../src/levels/Elevator/ElevatorFactory.sol";
import "../src/levels/Elevator/Building.sol";
import "./BaseTest.sol";

contract ElevatorTest is BaseTest {
    ElevatorFactory elevatorFactory;

    function setUp() public {
        elevatorFactory = new ElevatorFactory();
        super.setUp(elevatorFactory);
    }

    function testIsElevatorCleared() public testWrapper(elevatorFactory, 0) {
        ElevatorHack building = new ElevatorHack();
        building.attack(instance);
    }
}
