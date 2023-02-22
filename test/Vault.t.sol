// SDPX-Identifier: MIT
pragma solidity ^0.8.0;

import "../src/levels/Vault/Vault.sol";
import "../src/levels/Vault/VaultFactory.sol";
import "./BaseTest.sol";

contract VaultTest is BaseTest {
    VaultFactory vaultFactory;

    function setUp() public {
        vaultFactory = new VaultFactory();
        super.setUp(vaultFactory);
    }

    function testIsVaultCleared() public testWrapper(vaultFactory, 0) {
        bytes32 password = vm.load(instance, bytes32(uint256(1)));
        emit log_bytes(abi.encodePacked(password));

        uint8 i = 0;
        while (i < 32 && password[i] != 0) {
            i++;
        }

        bytes memory bytesArray = new bytes(i);

        for (i = 0; i < 32 && password[i] != 0; i++) {
            bytesArray[i] = password[i];
        }

        Vault(instance).unlock(password);

        emit log_string(string(bytesArray));
    }
}
