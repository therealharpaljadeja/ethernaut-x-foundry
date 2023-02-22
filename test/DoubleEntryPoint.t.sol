// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../src/levels/DoubleEntryPoint/DoubleEntryPointFactory.sol";
import "../src/levels/DoubleEntryPoint/DoubleEntryPointFortaBot.sol";
import "./BaseTest.sol";

contract DoubleEntryPointTest is BaseTest {
    DoubleEntryPointFactory doubleEntryPointFactory;

    function setUp() public {
        doubleEntryPointFactory = new DoubleEntryPointFactory();
        super.setUp(doubleEntryPointFactory);
    }

    function testIsDoubleEntryPointCleared()
        public
        testWrapper(doubleEntryPointFactory, 0)
    {
        FortaBot doubleEntryPointFortaBot = new FortaBot();

        DoubleEntryPoint doubleEntryPoint = DoubleEntryPoint(instance);
        Forta(doubleEntryPoint.forta()).setDetectionBot(
            address(doubleEntryPointFortaBot)
        );
    }
}
