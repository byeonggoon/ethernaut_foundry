// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../src/Level22.sol";
import "forge-std/Script.sol";
import "forge-std/console.sol";

contract DexSolution is Script {
    Dex public dex = Dex(0x7Ec2b9dd5f7dC28Bd41E7a9295bac79d66c45A4a);

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        vm.stopBroadcast();
    }
}
