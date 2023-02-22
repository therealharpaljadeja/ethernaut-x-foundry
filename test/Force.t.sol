// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../src/levels/Force/ForceFactory.sol";
import "../src/levels/Force/ForceAttacker.sol";
import "./BaseTest.sol";

contract ForceTest is BaseTest {
    ForceFactory forceFactory;

    function setUp() public {
        forceFactory = new ForceFactory();
        super.setUp(forceFactory);
    }

    function testIsForceCleared() public testWrapper(forceFactory, 0) {
        ForceAttacker forceAttacker = new ForceAttacker();
        vm.deal(address(forceAttacker), 1 ether);

        forceAttacker.attack(payable(instance));
    }
}
