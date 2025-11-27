// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

contract Algorithm {
    
    // 反转字符串 (Reverse String): 输入 "abcde"，输出 "edcba"
    function getReverseStr(string memory str) public pure returns(string memory) {
        bytes memory strBytes = bytes(str);
        uint256 length = strBytes.length;

        if (length <= 1) {
            return str;
        }

        bytes memory resBytes = new bytes(length);
        for (uint256 i = 0; i < length; i++) {
            resBytes[i] = strBytes[length - 1 - i];
        }

        return string(resBytes);
    }

    // 实现整数转罗马数字  3749
    function numToRoman(uint256 num) public pure returns(string memory) {
        string[10] memory units = ["", "I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX"];
        string[10] memory tens = ["", "X", "XX", "XXX", "XL", "L", "LX", "LXX", "LXXX", "XC"];
        string[10] memory hundreds = ["", "C", "CC", "CCC", "CD", "D", "DC", "DCC", "DCCC", "CM"];
        string[4] memory thousands = ["", "M", "MM", "MMM"];

        return string(abi.encodePacked(thousands[num/1000], hundreds[num/100%10], tens[num/10%10], units[num%10]));
    }

    //  实现罗马数字转数整数
    function romanToNum(string memory s) public pure returns(uint256 res) {
        bytes memory sBytes = bytes(s);
        uint256 length = sBytes.length;
        if (length == 0) {
            return 0;
        }

        res = getValue(sBytes[length - 1]); // 保证大于0, 从右往左遍历, 减值不为负
        uint256 rightVal = res;

        for (uint256 i = length - 1; i > 0; ) {
            i--;
            uint256 leftVal = getValue(sBytes[i]);

            if (leftVal < rightVal) {
                res -= leftVal;
            } else {
                res += leftVal;
            }
            rightVal = leftVal;
        }
        return res;
    }

    function getValue(bytes1 c) private pure returns (uint256) {
        if (c == "I") return 1;
        if (c == "V") return 5;
        if (c == "X") return 10;
        if (c == "L") return 50;
        if (c == "C") return 100;
        if (c == "D") return 500;
        if (c == "M") return 1000;
        revert("Invalid Roman numeral");
    }


    // 合并两个有序数组 (Merge Sorted Array): 将两个有序数组合并为一个有序数组。
    function merge(uint256[] memory arr1, uint256[] memory arr2) public pure returns(uint256[] memory) {
        uint256 len1 = arr1.length;
        uint256 len2 = arr2.length;

        uint256[] memory res = new uint256[](len1 + len2);

        uint256 i = 0; // arr1 point
        uint256 j = 0; // arr2 point
        uint256 m = 0; // res  point

        while(i < len1 && j < len2) {
            if (arr1[i] < arr2[j]) {
                res[m] = arr1[i];
                i++;
            } else {
                res[m] = arr2[j];
                j++; 
            }
            m++;
        }
        // 处理剩余的字段
        while(i < len1) {
            res[m] = arr1[i];
            i++;
            m++;
        }

        while(j < len2) {
            res[m] = arr2[j];
            j++;
            m++;
        }

        return res;
    }
    

    // 二分查找 (Binary Search): 在一个有序数组中查找目标值。
    function binarySearch(uint256[] memory arr, uint256 num) public pure returns(int256) {
        uint256 left = 0;
        uint256 right = arr.length;

        if (right == 0) {
            return -1;
        }

        // 二分查找  
        while(left < right) {
            // 计算中间值
            // uint256 mid = (left + right) / 2;
            uint256 mid = left + (right-left) / 2;

            if (num == arr[mid]) {
                return int256(mid);
            } else if (num > arr[mid]) {  // 假设:升序
                left = mid + 1;
            } else {
                right = mid;
            }

        }

        return -1;
    }


}