// SPDX-Identifer: MIT
pragma solidity ^0.8.0;

import "../src/levels/Telephone/TelephoneFactory.sol";
import "../src/levels/Telephone/TelephoneAttacker.sol";
import "./BaseTest.sol";

contract TelephoneTest is BaseTest {
    TelephoneFactory telephoneFactory;

    function setUp() public {
        telephoneFactory = new TelephoneFactory();
        super.setUp(telephoneFactory);
    }

    function testIsTelephoneCleared() public testWrapper(telephoneFactory, 0) {
        TelephoneAttacker telephoneAttacker = new TelephoneAttacker(instance);
        telephoneAttacker.attack();
    }
}
