// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "ds-test/test.sol";
import {Vm} from "forge-std/vm.sol";
import "../src/levels/MagicNum/MagicNumFactory.sol";
import "../src/levels/MagicNum/SolverFactory.sol";
import "../src/Ethernaut.sol";

contract MagicNumTest is DSTest {
    Ethernaut ethernaut;
    MagicNumFactory magicNumFactory;
    Vm private constant vm = Vm(HEVM_ADDRESS);
    address eoaAddress = address(69);

    function setUp() public {
        ethernaut = new Ethernaut();
        magicNumFactory = new MagicNumFactory();
        ethernaut.registerLevel(magicNumFactory);
    }

    function testIsMagicNumCleared() public {
        vm.startPrank(eoaAddress);

        address instanceAddress = ethernaut.createLevelInstance(
            magicNumFactory
        );

        SolverFactory solverFactory = new SolverFactory();
        address solver = solverFactory.deploy();

        MagicNum(instanceAddress).setSolver(solver);

        assertTrue(ethernaut.submitLevelInstance(payable(instanceAddress)));

        vm.stopPrank();
    }
}
