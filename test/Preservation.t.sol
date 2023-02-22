// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../src/levels/Preservation/PreservationFactory.sol";
import "../src/levels/Preservation/Preservation.sol";
import "../src/levels/Preservation/MaliciousLibraryContract.sol";
import "./BaseTest.sol";

contract PreservationTest is BaseTest {
    PreservationFactory preservationFactory;

    function setUp() public {
        preservationFactory = new PreservationFactory();
        super.setUp(preservationFactory);
    }

    function testIsPreservationCleared()
        public
        testWrapper(preservationFactory, 0)
    {
        Preservation preservation = Preservation(instance);

        MaliciousLibraryContract maliciousLibraryContract = new MaliciousLibraryContract();

        uint256 timeStamp = uint256(uint160(address(maliciousLibraryContract)));
        preservation.setFirstTime(timeStamp);

        timeStamp = uint256(uint160(eoa));
        preservation.setFirstTime(timeStamp);
    }
}
