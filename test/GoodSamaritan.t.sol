// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../src/levels/GoodSamaritan/GoodSamaritanFactory.sol";
import "../src/levels/GoodSamaritan/BadSamaritan.sol";
import "./BaseTest.sol";

contract GoodSamaritanTest is BaseTest {
    GoodSamaritanFactory goodSamaritanFactory;

    function setUp() public {
        goodSamaritanFactory = new GoodSamaritanFactory();
        super.setUp(goodSamaritanFactory);
    }

    function testIsGoodSamaritanCleared()
        public
        testWrapper(goodSamaritanFactory, 0)
    {
        BadSamaritan badSamaritan = new BadSamaritan();
        badSamaritan.requestDonation(instance);
    }
}
