// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.28;

contract BinarySearch {
    function binarySearch(
        uint8[] memory arr,
        uint target
    ) external pure returns (int) {
        uint left;
        uint right = arr.length;

        while (left < right) {
            uint middle = left + (right - left) / 2;

            if (target == arr[middle]) {
                return int(middle);
            }

            if (target < arr[middle]) {
                right = middle;
            } else {
                left = middle + 1;
            }
        }

        return -1;
    }
}
