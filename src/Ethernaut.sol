// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./BaseLevel.sol";
import "@openzeppelin/access/Ownable.sol";

contract Ethernaut is Ownable {
    // ----------------------------------
    // Owner interaction
    // ----------------------------------

    mapping(address => bool) public registeredLevels;

    // Only registered levels will be allowed to generate and validate level instances.
    function registerLevel(Level _level) public onlyOwner {
        registeredLevels[address(_level)] = true;
    }

    // ----------------------------------
    // Get/submit level instances
    // ----------------------------------

    struct EmittedInstanceData {
        address player;
        Level level;
        bool completed;
    }

    mapping(address => EmittedInstanceData) public emittedInstances;

    event LevelInstanceCreatedLog(
        address indexed player,
        address indexed instance,
        address indexed level
    );
    event LevelCompletedLog(
        address indexed player,
        address indexed instance,
        address indexed level
    );

    function createLevelInstance(Level _level)
        public
        payable
        returns (address)
    {
        // Ensure level is registered.
        require(registeredLevels[address(_level)], "This level doesn't exists");

        // Get level factory to create an instance.
        address instance = _level.createInstance{value: msg.value}(msg.sender);

        // Store emitted instance relationship with player and level.
        emittedInstances[instance] = EmittedInstanceData(
            msg.sender,
            _level,
            false
        );

        // Retrieve created instance via logs.
        emit LevelInstanceCreatedLog(msg.sender, instance, address(_level));

        return instance;
    }

    function submitLevelInstance(address payable _instance)
        public
        returns (bool)
    {
        // Get player and level.
        EmittedInstanceData storage data = emittedInstances[_instance];
        require(
            data.player == msg.sender,
            "This instance doesn't belong to the current user"
        ); // instance was emitted for this player
        require(data.completed == false, "Level has been completed already"); // not already submitted

        // Have the level check the instance.
        if (data.level.validateInstance(_instance, msg.sender)) {
            // Register instance as completed.
            data.completed = true;

            // Notify success via logs.
            emit LevelCompletedLog(msg.sender, _instance, address(data.level));

            return true;
        }

        return false;
    }
}
