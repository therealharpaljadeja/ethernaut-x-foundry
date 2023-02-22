// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../src/levels/GatekeeperOne/GatekeeperOneFactory.sol";
import "../src/levels/GatekeeperOne/GatekeeperOneAttacker.sol";
import "./BaseTest.sol";

contract GatekeeperOneTest is BaseTest {
    GatekeeperOneFactory gatekeeperOneFactory;

    function setUp() public {
        gatekeeperOneFactory = new GatekeeperOneFactory();
        super.setUp(gatekeeperOneFactory);
    }

    function testIsGatekeeperOneCleared()
        public
        testWrapper(gatekeeperOneFactory, 0)
    {
        // Pranking with an address having non-zero first nibble is important.
        vm.startPrank(0x1804c8AB1F12E6bbf3894d4083f33e07309d1f38);

        GatekeeperOneAttacker gatekeeperOneAttacker = new GatekeeperOneAttacker();
        gatekeeperOneAttacker.attack(instance);
    }
}
