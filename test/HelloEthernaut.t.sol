// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "ds-test/test.sol";
import "../src/HelloEthernaut.sol";

contract HelloEthernautTest is DSTest {
    HelloEthernaut public helloEthernaut;

    function setUp() public {
        helloEthernaut = new HelloEthernaut("ethernaut0");
    }

    function testIsHelloEthernautCleared() public {
        helloEthernaut.authenticate(helloEthernaut.password());
        assertTrue(helloEthernaut.getCleared());
    }
}
