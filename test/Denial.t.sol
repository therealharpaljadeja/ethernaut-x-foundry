// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./BaseTest.sol";
import "../src/levels/Denial/DenialFactory.sol";
import "../src/levels/Denial/DenialReceiver.sol";

contract DenialTest is BaseTest {
    DenialFactory denialFactory;

    function setUp() public {
        denialFactory = new DenialFactory();
        super.setUp(denialFactory);
    }

    function testIsDenialCleared()
        public
        testWrapper(denialFactory, 0.001 ether)
    {
        DenialReceiver denialReceiver = new DenialReceiver();
        Denial denial = Denial(payable(instance));
        denial.setWithdrawPartner(address(denialReceiver));
    }
}
