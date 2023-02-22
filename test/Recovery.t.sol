// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../src/levels/Recovery/Recovery.sol";
import "../src/levels/Recovery/RecoveryFactory.sol";
import "./BaseTest.sol";

contract RecoveryTest is BaseTest {
    RecoveryFactory recoveryFactory;

    function setUp() public {
        recoveryFactory = new RecoveryFactory();
        super.setUp(recoveryFactory);
    }

    function testIsRecoveryCleared()
        public
        testWrapper(recoveryFactory, 0.001 ether)
    {
        address target = address(
            uint160(
                uint256(
                    keccak256(
                        abi.encodePacked(
                            uint8(0xd6),
                            uint8(0x94),
                            instance,
                            uint8(0x01)
                        )
                    )
                )
            )
        );

        (bool destroySuccess, ) = target.call(
            abi.encodeWithSignature("destroy(address)", eoa)
        );
        require(destroySuccess, "destroy() failed");
    }
}
