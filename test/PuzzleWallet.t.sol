// SPDX-License-Identifer: MIT

pragma solidity ^0.8.0;

import "../src/levels/PuzzleWallet/PuzzleWalletFactory.sol";
import "./BaseTest.sol";

contract PuzzleWalletTest is BaseTest {
    PuzzleWalletFactory puzzleWalletFactory;

    function setUp() public {
        puzzleWalletFactory = new PuzzleWalletFactory();
        super.setUp(puzzleWalletFactory);
    }

    function testIsPuzzleWalletCleared()
        public
        testWrapper(puzzleWalletFactory, 0.001 ether)
    {
        PuzzleProxy puzzleProxy = PuzzleProxy(payable(instance));
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
    }
}
