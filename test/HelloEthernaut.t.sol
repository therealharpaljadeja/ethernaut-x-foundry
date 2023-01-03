// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "ds-test/test.sol";
import "../src/HelloEthernaut.sol";

contract HelloEthernautTest is DSTest {
    HelloEthernaut public helloEthernaut;

    function setUp() public {
        // Initializing contract with password - "ethernaut0" is the password used by Ethernaut.
        helloEthernaut = new HelloEthernaut("ethernaut0");
    }

    function testIsHelloEthernautCleared() public {
        // Skipping through all the functions and directly calling authenticate with the password.
        helloEthernaut.authenticate(helloEthernaut.password());
        // Checking if level is cleared!
        assertTrue(helloEthernaut.getCleared());
    }
}
