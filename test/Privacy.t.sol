// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../src/levels/Privacy/Privacy.sol";
import "../src/levels/Privacy/PrivacyFactory.sol";
import "./BaseTest.sol";

contract PrivacyTest is BaseTest {
    PrivacyFactory privacyFactory;

    function setUp() public {
        privacyFactory = new PrivacyFactory();
        super.setUp(privacyFactory);
    }

    function testIsPrivacyCleared() public testWrapper(privacyFactory, 0) {
        bytes32 slot = vm.load(instance, bytes32(uint256(5)));
        bytes16 key = bytes16(slot);
        Privacy(instance).unlock(key);
    }
}
