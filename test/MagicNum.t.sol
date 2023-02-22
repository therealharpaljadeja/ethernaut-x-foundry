// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../src/levels/MagicNum/MagicNumFactory.sol";
import "../src/levels/MagicNum/SolverFactory.sol";
import "./BaseTest.sol";

contract MagicNumTest is BaseTest {
    MagicNumFactory magicNumFactory;

    function setUp() public {
        magicNumFactory = new MagicNumFactory();
        super.setUp(magicNumFactory);
    }

    function testIsMagicNumCleared() public testWrapper(magicNumFactory, 0) {
        SolverFactory solverFactory = new SolverFactory();
        address solver = solverFactory.deploy();

        MagicNum(instance).setSolver(solver);
    }
}
