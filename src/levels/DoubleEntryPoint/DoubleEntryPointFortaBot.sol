// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IDetectionBot, IForta} from "./DoubleEntryPoint.sol";

contract FortaBot is IDetectionBot {
    function handleTransaction(address user, bytes memory msgData) external {
        IForta(msg.sender).raiseAlert(user);
    }
}
