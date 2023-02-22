// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../src/levels/Delegation/Delegation.sol";
import "../src/levels/Delegation/DelegationFactory.sol";
import "./BaseTest.sol";

contract DelegationTest is BaseTest {
    DelegationFactory delegationFactory;

    function setUp() public {
        delegationFactory = new DelegationFactory();
        super.setUp(delegationFactory);
    }

    function testIsDelegationCleared()
        public
        testWrapper(delegationFactory, 0)
    {
        (bool pwnSuccess, ) = instance.call(abi.encodeWithSignature("pwn()"));
        require(pwnSuccess, "pwn() failed");
    }
}
