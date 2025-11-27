// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

/* 包含以下功能
1. 一个mapping来存储候选人的得票数
2. 一个vote函数，允许用户投票给某个候选人
3. 一个getVotes函数，返回某个候选人的得票数
4. 一个resetVotes函数，重置所有候选人的得票数
*/
contract Voting {
    // 一个mapping来存储候选人的得票数
    mapping(string => uint256) public candidateToVotes;
    // 所有投票人
    string[] private allCadidates;
    // 投票人是否存在映射
    mapping(string => bool) private cadidateExsit;

    // 一个vote函数，允许用户投票给某个候选人
    function vote(string calldata cadidate) public {
        if (!cadidateExsit[cadidate]) {
            cadidateExsit[cadidate] = true;
            allCadidates.push(cadidate);
        }
        // 投票
        candidateToVotes[cadidate] += 1;
    }

    // 一个getVotes函数，返回某个候选人的得票数
    function getVotes(string calldata cadidate) public view returns(uint256) {
        return candidateToVotes[cadidate];
    }

    // 一个resetVotes函数，重置所有候选人的得票数
    function resetVotes() public {
        // 遍历所有投票人
        for (uint i=0; i<allCadidates.length; i++) {
            candidateToVotes[allCadidates[i]] = 0;
            cadidateExsit[allCadidates[i]] = false;
        }
        // 删除数组
        delete allCadidates;
    }

}