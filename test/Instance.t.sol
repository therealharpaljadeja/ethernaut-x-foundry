// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../src/levels/Instance/Instance.sol";
import "../src/levels/Instance/InstanceFactory.sol";
import "./BaseTest.sol";

contract InstanceTest is BaseTest {
    InstanceFactory instanceFactory;

    function setUp() public {
        instanceFactory = new InstanceFactory();
        super.setUp(instanceFactory);
    }

    function testInstanceCleared() public testWrapper(instanceFactory, 0) {
        Instance instanceContract = Instance(instance);
        // Skipping through all the functions and directly calling authenticate with the password.
        instanceContract.authenticate(instanceContract.password());
    }
}
