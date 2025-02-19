// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../src/Level18.sol";
import "forge-std/Script.sol";
import "forge-std/console.sol";

contract AttckTest {
    function whatIsTheMeaningOfLife() external pure returns (uint256) {
        return 42;
    }
}

contract Attack {
    //풀이1
    constructor(address _target) {
        address deployedContract;
        assembly {
            let bytecode := mload(0x40)
            mstore(bytecode, 0x14)
            mstore(
                add(bytecode, 0x20),
                0x69602a60005260206000f3600052600a6016f3
            )
            deployedContract := create(0, bytecode, 0x14)
        }
        MagicNum(_target).setSolver(deployedContract);
    }
    //풀이2
    /**
    constructor(address _target) {
        bytes
            memory deploymentBytecode = hex"69602a60005260206000f3600052600a6016f3";
        address minimalContractAddress;
        assembly {
            minimalContractAddress := create(
                0,
                add(deploymentBytecode, 0x20),
                mload(deploymentBytecode)
            )
        }
        MagicNum(_target).setSolver(minimalContractAddress);
    }
     */
}
contract MagicNumSolution is Script {
    // MagicNum address = > 0x5cCE181AE975845002358B8a4221DcC008D0Ef69);
    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        address deployedContract;
        Attack attack = new Attack(0x5cCE181AE975845002358B8a4221DcC008D0Ef69); //
        vm.stopBroadcast();
    }
}
