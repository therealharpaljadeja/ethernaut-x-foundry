// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../../BaseLevel.sol";
import "./Dex.sol";
import "@openzeppelin/token/ERC20/ERC20.sol";

contract DexFactory is Level {
    function createInstance(address _player)
        public
        payable
        override
        returns (address)
    {
        Dex instance = new Dex();
        address instance = address(instance);

        SwappableToken tokenInstance = new SwappableToken(
            instance,
            "Token 1",
            "TKN1",
            110
        );
        SwappableToken tokenInstanceTwo = new SwappableToken(
            instance,
            "Token 2",
            "TKN2",
            110
        );

        address tokeninstance = address(tokenInstance);
        address tokenInstanceTwoAddress = address(tokenInstanceTwo);

        instance.setTokens(tokeninstance, tokenInstanceTwoAddress);

        tokenInstance.approve(instance, 100);
        tokenInstanceTwo.approve(instance, 100);

        instance.addLiquidity(tokeninstance, 100);
        instance.addLiquidity(tokenInstanceTwoAddress, 100);

        tokenInstance.transfer(_player, 10);
        tokenInstanceTwo.transfer(_player, 10);

        return instance;
    }

    function validateInstance(address payable _instance, address)
        public
        view
        override
        returns (bool)
    {
        address token1 = Dex(_instance).token1();
        address token2 = Dex(_instance).token2();
        return
            IERC20(token1).balanceOf(_instance) == 0 ||
            ERC20(token2).balanceOf(_instance) == 0;
    }
}
