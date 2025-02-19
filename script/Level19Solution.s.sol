// SPDX-License-Identifier: MIT
pragma solidity ^0.5.0;

import "../src/Level19.sol";
// import "forge-std/Script.sol";
import "forge-std/console.sol";

contract AlienCodexSolution {
    AlienCodex public alienCodex =
        AlienCodex(0xC1561335bC14b66f95dE5cc426A9BdF538b3Eda6);

    function run() external {
        // vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        // vm.stopBroadcast();
    }
}
