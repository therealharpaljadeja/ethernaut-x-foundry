// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../src/levels/GatekeeperTwo/GatekeeperTwoFactory.sol";
import "../src/levels/GatekeeperTwo/GatekeeperTwoAttacker.sol";
import "./BaseTest.sol";

contract GatekeeperTwoTest is BaseTest {
    GatekeeperTwoFactory gatekeeperTwoFactory;

    function setUp() public {
        gatekeeperTwoFactory = new GatekeeperTwoFactory();
        super.setUp(gatekeeperTwoFactory);
    }

    function testIsGatekeeperTwoCleared()
        public
        testWrapper(gatekeeperTwoFactory, 0)
    {
        vm.startPrank(0x1804c8AB1F12E6bbf3894d4083f33e07309d1f38);

        new GatekeeperTwoAttacker(instance);
    }
}
