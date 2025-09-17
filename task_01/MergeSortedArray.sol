// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.28;

// 用归并排序
contract MergeSortedArray {
    function merge(
        uint[] memory arr1,
        uint[] memory arr2
    ) external pure returns (uint[] memory) {
        uint[] memory res = new uint[](arr1.length + arr2.length);

        uint index1;
        uint index2;
        uint indexRes;

        while (index1 < arr1.length && index2 < arr2.length) {
            if (arr1[index1] <= arr2[index2]) {
                res[indexRes] = arr1[index1];
                index1++;
            } else {
                res[indexRes] = arr2[index2];
                index2++;
            }
            indexRes++;
        }

        while (index1 < arr1.length) {
            res[indexRes] = arr1[index1];
            index1++;
            indexRes++;
        }

        while (index2 < arr2.length) {
            res[indexRes] = arr2[index2];
            index2++;
            indexRes++;
        }

        return res;
    }
}
