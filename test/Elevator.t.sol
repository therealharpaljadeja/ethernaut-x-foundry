// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "ds-test/test.sol";
import {Vm} from "forge-std/Vm.sol";
import "../src/levels/Elevator/ElevatorFactory.sol";
import "../src/levels/Elevator/Building.sol";
import "../src/Ethernaut.sol";

contract ElevatorTest is DSTest {
    Ethernaut ethernaut;
    ElevatorFactory elevatorFactory;
    Vm private constant vm = Vm(HEVM_ADDRESS);
    address eoa = address(69);

    function setUp() public {
        ethernaut = new Ethernaut();
        elevatorFactory = new ElevatorFactory();
        ethernaut.registerLevel(elevatorFactory);

        vm.deal(eoa, 1 ether);
    }

    function testIsElevatorCleared() public {
        vm.startPrank(eoa);

        address instance = ethernaut.createLevelInstance(elevatorFactory);
        ElevatorHack building = new ElevatorHack();

        building.attack(instance);

        ethernaut.submitLevelInstance(payable(instance));

        vm.stopPrank();
    }
}
