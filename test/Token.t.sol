// SDPX-Identifier: MIT
pragma solidity ^0.8.0;

import "../src/levels/Token/Token.sol";
import "../src/levels/Token/TokenFactory.sol";
import "./BaseTest.sol";

contract TokenTest is BaseTest {
    TokenFactory tokenFactory;

    function setUp() public {
        tokenFactory = new TokenFactory();
        super.setUp(tokenFactory);
    }

    function testIsTokenCleared() public testWrapper(tokenFactory, 0) {
        Token token = Token(instance);

        token.transfer(address(101), 21);
    }
}
