// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../../BaseLevel.sol";
import "./DexTwo.sol";
import "@openzeppelin/token/ERC20/ERC20.sol";

contract DexTwoFactory is Level {
    function createInstance(address _player)
        public
        payable
        override
        returns (address)
    {
        DexTwo instance = new DexTwo();
        address instance = address(instance);

        SwappableTokenTwo tokenInstance = new SwappableTokenTwo(
            instance,
            "Token 1",
            "TKN1",
            110
        );
        SwappableTokenTwo tokenInstanceTwo = new SwappableTokenTwo(
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

        instance.add_liquidity(tokeninstance, 100);
        instance.add_liquidity(tokenInstanceTwoAddress, 100);

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
        address token1 = DexTwo(_instance).token1();
        address token2 = DexTwo(_instance).token2();
        return
            IERC20(token1).balanceOf(_instance) == 0 &&
            ERC20(token2).balanceOf(_instance) == 0;
    }
}
