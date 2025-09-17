// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.28;

// 用贪心算法
contract Greedy {
    function num2Roman(uint input) external pure returns (string memory) {
        bytes memory res;
        uint16[13] memory values = [
            1000,
            900,
            500,
            400,
            100,
            90,
            50,
            40,
            10,
            9,
            5,
            4,
            1
        ];
        string[13] memory keys = [
            "M",
            "CM",
            "D",
            "CD",
            "C",
            "XC",
            "L",
            "XL",
            "X",
            "IX",
            "V",
            "IV",
            "I"
        ];

        for (uint i; i < values.length; i++) {
            while (input >= values[i]) {
                input -= values[i];
                res = bytes.concat(res, bytes(keys[i]));
            }
        }

        return string(res);
    }
}
