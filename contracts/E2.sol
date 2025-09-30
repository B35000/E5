//SPDX-License-Identifier: Unlicense
// Copyright (c) 2022 Bry Onyoni
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE, TITLE AND NON-INFRINGEMENT. IN NO EVENT
// SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR
// OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
// FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
// IN THE SOFTWARE.
pragma solidity 0.8.4;

// import "hardhat/console.sol";
// import "./E5D/E5.sol"; /* import "./E5Data/E5.sol"; */
// import "./E5D/E52.sol"; /* import "./E5Data/E52.sol"; */

import "./E5D/E3.sol"; /* import "./E5Data/E5HelperFunctions.sol"; */
import "./E5D/E32.sol"; /* import "./E5Data/E5HelperFunctions2.sol"; */
import "./E5D/E33.sol"; /* import "./E5Data/E5HelperFunctions3.sol"; */
import "./E5D/E34.sol"; /* import "./E5Data/E5HelperFunctions4.sol"; */

// import "./F5D/F5.sol"; /* import "../SubscriptionData/SubscriptionData.sol"; */
import "./F5D/F3.sol"; /* import "./SubscriptionData/SubscriptionHelperFunctions.sol"; */
import "./F5D/F32.sol"; /* import "./SubscriptionData/SubscriptionHelperFunctions2.sol"; */
import "./F5D/F33.sol"; /* import "./SubscriptionData/SubscriptionHelperFunctions3.sol"; */

// import "./G5D/G5.sol"; /* import "./ContractsData/ContractsData.sol"; */
// import "./G5D/G52.sol"; /* import "./ContractsData/ContractsData2.sol"; */

import "./G5D/G3.sol"; /* import "./ContractsData/ContractsHelperFunctions.sol"; */
import "./G5D/G32.sol"; /* import "./ContractsData/ContractsHelperFunctions2.sol"; */
import "./G5D/G33.sol"; /* import "./ContractsData/ContractsHelperFunctions3.sol"; */

// import "./H5D/H5.sol"; /* import "./TokensData/TokensData.sol"; */
// import "./H5D/H52.sol"; /* import "./TokensData/TokensData2.sol"; */

import "./H5D/H3.sol"; /* import "./TokensData/TokensHelperFunctions.sol"; */
import "./H5D/H32.sol"; /* import "./TokensData/TokensHelperFunctions2.sol"; */

contract E2 {
    //---------------------------for_H32_library---------------------------------------
    // function set_preset_data(uint256[][] calldata preset_data) public {
    //     for ( uint256 r = 0; r < preset_data.length; r++ ) {
    //         if(preset_data[r][0] == 1){
    //             num_data.num[ preset_data[r][1] ][ preset_data[r][2] ][ preset_data[r][3] ] = preset_data[r][4];
    //         }
    //         else if(preset_data[r][0] == 2){
    //             num_data.int_int_int[ preset_data[r][1] ][preset_data[r][2]][ preset_data[r][3]] [ preset_data[r][4] ] = preset_data[r][5];

    //             if(preset_data[r].length > 6){
    //                 if(preset_data[r][5] == 1){
    //                     num_data.int_int_int[ preset_data[r][1] ][preset_data[r][2]][ preset_data[r][3]][ preset_data[r][4]] = block.number;
    //                 }
    //                 else if(preset_data[r][5] == 2){
    //                     num_data.int_int_int[ preset_data[r][1] ][preset_data[r][2]][ preset_data[r][3]][ preset_data[r][4]] = block.timestamp;
    //                 }
    //                 if(preset_data[r].length > 7){
    //                     if(preset_data[r][6] == 5){
    //                         num_data.int_int_int[ preset_data[r][1] ][preset_data[r][2]][ preset_data[r][3]][ preset_data[r][4]] += preset_data[r][7];
    //                     }else{
    //                         //3
    //                         num_data.int_int_int[ preset_data[r][1] ][preset_data[r][2]][ preset_data[r][3]][ preset_data[r][4]] -= preset_data[r][7];
    //                     }
    //                 }
    //             }
    //         }
    //         else if(preset_data[r][0] == 3){
    //             num_data.num_str_metas[ preset_data[r][1] ][ preset_data[r][2] ] = preset_data[r][4];
    //         }
    //     }
    // }

    // function delete_preset_data(uint256[][] calldata preset_data) public {
    //     for ( uint256 r = 0; r < preset_data.length; r++ ) {
    //         if(preset_data[r][0] == 1){
    //             num_data.num[ preset_data[r][1] ][ preset_data[r][2] ][ preset_data[r][3] ] = 0;
    //         }
    //         else if(preset_data[r][0] == 2){
    //             num_data.int_int_int[ preset_data[r][1] ][preset_data[r][2]][ preset_data[r][3]][ preset_data[r][4]] = 0;
    //         }
    //         else if(preset_data[r][0] == 3){
    //             num_data.num_str_metas[ preset_data[r][1] ][ preset_data[r][2] ] = 0;
    //         }
    //     }
    // }

    // function read_preset_data(uint256[][] calldata preset_data) 
    // public view returns(uint256[] memory return_data) {
    //     return_data = new uint256[](preset_data.length);
    //     for ( uint256 r = 0; r < preset_data.length; r++ ) {
    //         if(preset_data[r][0] == 1){
    //             return_data[r] = num_data.num[ preset_data[r][1] ][ preset_data[r][2] ][ preset_data[r][3] ];
    //         }
    //         else if(preset_data[r][0] == 2){
    //             return_data[r] = num_data.int_int_int[ preset_data[r][1] ][preset_data[r][2]][ preset_data[r][3]][ preset_data[r][4]];
    //         }
    //         else if(preset_data[r][0] == 3){
    //             return_data[r] = num_data.num_str_metas[ preset_data[r][1] ][ preset_data[r][2] ];
    //         }
    //     }
    // }
    //---------------------------for_H32_library---------------------------------------


    // function set_preset_data(uint256[][] calldata preset_data) public {
    //     for ( uint256 r = 0; r < preset_data.length; r++ ) {
    //         if(preset_data[r][0] == 1){
    //             num_data.num[ preset_data[r][1] ][ preset_data[r][2] ][ preset_data[r][3] ] = preset_data[r][4];
    //         }
    //         else if(preset_data[r][0] == 2){
    //             num_data.int_int_int[ preset_data[r][1] ][preset_data[r][2]][ preset_data[r][3]] = preset_data[r][4];

    //             if(preset_data[r].length > 5){
    //                 if(preset_data[r][5] == 1){
    //                     num_data.int_int_int[ preset_data[r][1] ][preset_data[r][2]][ preset_data[r][3]] = block.number;
    //                 }
    //                 else if(preset_data[r][5] == 2){
    //                     num_data.int_int_int[ preset_data[r][1] ][preset_data[r][2]][ preset_data[r][3]] = block.timestamp;
    //                 }
    //                 if(preset_data[r].length > 6){
    //                     if(preset_data[r][6] == 5){
    //                         num_data.int_int_int[ preset_data[r][1] ][preset_data[r][2]][ preset_data[r][3]] += preset_data[r][7];
    //                     }else{
    //                         //3
    //                         num_data.int_int_int[ preset_data[r][1] ][preset_data[r][2]][ preset_data[r][3]] -= preset_data[r][7];
    //                     }
    //                 }
    //             }
    //         }
    //         else if(preset_data[r][0] == 3){
    //             num_data.num_str_metas[ preset_data[r][1] ][ preset_data[r][2] ][ preset_data[r][3] ] = preset_data[r][4];
    //         }
    //         else if(preset_data[r][0] == 4){
    //             num_data.num_metas[ preset_data[r][1] ][ preset_data[r][2] ] = preset_data[r][3];
    //         }
    //     }
    // }

    // function delete_preset_data(uint256[][] calldata preset_data) public {
    //     for ( uint256 r = 0; r < preset_data.length; r++ ) {
    //         if(preset_data[r][0] == 1){
    //             num_data.num[ preset_data[r][1] ][ preset_data[r][2] ][ preset_data[r][3] ] = 0;
    //         }
    //         else if(preset_data[r][0] == 2){
    //             num_data.int_int_int[ preset_data[r][1] ][preset_data[r][2]][ preset_data[r][3]] = 0;
    //         }
    //         else if(preset_data[r][0] == 3){
    //             num_data.num_str_metas[ preset_data[r][1] ][ preset_data[r][2] ][ preset_data[r][3] ] = 0;
    //         }
    //         else if(preset_data[r][0] == 4){
    //             num_data.num_metas[ preset_data[r][1] ][ preset_data[r][2] ] = 0;
    //         }
    //     }
    // }

    // function read_preset_data(uint256[][] calldata preset_data) 
    // public view returns(uint256[] memory return_data) {
    //     return_data = new uint256[](preset_data.length);
    //     for ( uint256 r = 0; r < preset_data.length; r++ ) {
    //         if(preset_data[r][0] == 1){
    //             return_data[r] = num_data.num[ preset_data[r][1] ][ preset_data[r][2] ][ preset_data[r][3] ];
    //         }
    //         else if(preset_data[r][0] == 2){
    //             return_data[r] = num_data.int_int_int[ preset_data[r][1] ][preset_data[r][2]][ preset_data[r][3]];
    //         }
    //         else if(preset_data[r][0] == 3){
    //             return_data[r] = num_data.num_str_metas[ preset_data[r][1] ][ preset_data[r][2] ][ preset_data[r][3] ];
    //         }
    //         else if(preset_data[r][0] == 4){
    //             return_data[r] = num_data.num_metas[ preset_data[r][1] ][ preset_data[r][2] ];
    //         }
    //     }
    // }






    function time() external view returns(uint256){
        return block.timestamp;
    }

    function get_block() external view returns(uint256){
        return block.number;
    }

    function get_block_gaslimit() external view returns(uint256){
        return block.gaslimit;
    }




    /* balance_of_multiple_accounts */
    // H32.NumData private num_data;
    // function f270(
    //     uint256[] calldata p1/* exchanges_or_accounts */, 
    //     uint256[][] calldata p2/* accounts_or_exchanges */, 
    //     uint256[] calldata p4/* depths */,
    //     uint256 p5/* unfroozen_or_froozen */,
    //     uint256 p6/* action */
    // ) external view returns(uint256[] memory v1/* return_data */) {
    //     uint256[][] memory v2/* data */ = H32.f270(p1/* exchanges_or_accounts */, p2/* accounts_or_exchanges */, num_data, p4/* depths */, p5/* unfroozen_or_froozen */, p6/* action */);

    //     v1/* return_data */ = new uint256[](100);
    //     uint256 v4/* pos */ = 0;

    //     for (uint256 e = 0; e < v2/* data */.length; e++) {
    //         for (uint256 f = 0; f < v2/* data */[e].length; f++) {
    //             v1/* return_data */[v4/* pos */] = v2/* data */[e][f];
    //             v4/* pos */++;
    //         }
    //     }
    // }

    /* get_account_entry_expiry_time(3) | entry_time_to_expiry(4) */
    // G32.NumData private num_data;
    // function f266(
    //     uint256[] memory p1/* contract_targets */, 
    //     uint256[][] calldata p2/* voter_accounts */, 
    //     uint256 p3/* action */
    // ) public view returns(uint256[] memory v1/* return_data */){
    //     uint256[][] memory v2/* data */ = G32.f266(p1/* consensus_targets */, p2/* voter_accounts */, p3/* action */, num_data);

    //     v1/* return_data */ = new uint256[](100);
    //     uint256 v4/* pos */ = 0;

    //     for (uint256 e = 0; e < v2/* data */.length; e++) {
    //         for (uint256 f = 0; f < v2/* data */[e].length; f++) {
    //             v1/* return_data */[v4/* pos */] = v2/* data */[e][f];
    //             v4/* pos */++;
    //         }
    //     }
    // }

    /* get_contains_subscription_contract_mod_work */
    // function f264(uint256[21] memory v1/* consensus_type_data */) 
    // public pure returns(bool[3] memory){
    //     return G32.f264(v1/* consensus_type_data */);
    // }

    /* get_consensus_moderator_action_data */
    // function f274(
    //     uint256[][][] calldata p1/* target_nums */,
    //     uint256[21] memory p2/* consensus_type_data */
    // ) public pure returns (uint256[] memory v1/* return_data */) {
    //     uint256[][5][5] memory v3/* data2 */ = F32.f274(p1/* target_nums */, p2/* consensus_type_data */);

    //     v1/* return_data */ = new uint256[](100);
    //     uint256 v4/* pos */ = 0;

    //     for (uint256 t = 0; t < v3/* data2 */.length; t++) {
    //         for (uint256 e = 0; e < v3/* data2 */[t].length; e++) {
    //             for (uint256 f = 0; f < v3/* data2 */[t][e].length; f++) {
    //                 v1/* return_data */[v4/* pos */] = v3/* data2 */[t][e][f];
    //                 v4/* pos */++;
    //             }
    //         }
    //     }

    // }

    /* get_consensus_moderator_action_targets_count */
    // function f273(uint256[21] calldata p1/* consensus_type_data */)
    // public pure returns (uint256[] memory v1/* return_data */) {
    //     uint256[][5][5] memory v2/* data */ = F32.f273(p1/* consensus_type_data */);

    //     v1/* return_data */ = new uint256[](100);
    //     uint256 v4/* pos */ = 0;

    //     for (uint256 t = 0; t < 5; t++) {
    //         for (uint256 f = 0; f < 5; f++) {
    //             v1/* return_data */[v4/* pos */] = v2/* data */[t][f].length;
    //             v4/* pos */++;
    //         }
    //     }
    // }


    /* get_consensus_contract_data */
    // function f262(
    //     uint256[][][] calldata p1/* target_nums */,
    //     uint256[21] memory p2/* consensus_type_data */
    // ) public pure returns (uint256[] memory v1/* return_data */) {
    //     uint256[][5][5] memory v3/* data2 */ = F32.f262(p1/* target_nums */, p2/* consensus_type_data */);

    //     v1/* return_data */ = new uint256[](100);
    //     uint256 v4/* pos */ = 0;

    //     for (uint256 t = 0; t < v3/* data2 */.length; t++) {
    //         for (uint256 e = 0; e < v3/* data2 */[t].length; e++) {
    //             for (uint256 f = 0; f < v3/* data2 */[t][e].length; f++) {
    //                 v1/* return_data */[v4/* pos */] = v3/* data2 */[t][e][f];
    //                 v4/* pos */++;
    //             }
    //         }
    //     }

    // }

    /* get_consensus_contract_action_targets_count */
    // function f261(uint256[21] calldata p1/* consensus_type_data */)
    // public pure returns (uint256[] memory v1/* return_data */) {
    //     uint256[][5][5] memory v2/* data */ = F32.f261(p1/* consensus_type_data */);

    //     v1/* return_data */ = new uint256[](100);
    //     uint256 v4/* pos */ = 0;

    //     for (uint256 t = 0; t < 5; t++) {
    //         for (uint256 f = 0; f < 5; f++) {
    //             v1/* return_data */[v4/* pos */] = v2/* data */[t][f].length;
    //             v4/* pos */++;
    //         }
    //     }
    // }



    /* require_target_moderators */
    // E34.NumData private num_data;
    // function f283(
    //     uint256[] memory p1/* targets */, 
    //     uint256 p2/* sender_acc_id */, 
    //     uint256[] memory p3/* sender_accounts */
    // ) external {
    //     E34.f283/* require_target_moderators */(p1/* targets */, p2/* sender_acc_id */, p3/* sender_accounts */, num_data);

    //     if(p2/* sender_acc_id */ != 0){
    //         E34.f242/* require_target_moderator */(p1/* targets */, p2/* sender_acc_id */, num_data);
    //     }
    // }

    /* revoke_author_owner_privelages */
    // E34.NumData private num_data;
    // function f277(
    //     uint256[][5] calldata p1/* target_id_data */,
    //     uint256 p2/* sender_acc_id */
    // ) external {
    //     E34.f277/* revoke_author_owner_privelages */(p1/* target_id_data */, num_data, p2/* sender_acc_id */);
    // }


    /* calculate_max_consumable_gas */
    // E33.NumData private num_data;
    // function f280(uint256[] calldata p1/* gas_prices */) 
    // external view returns(uint256[] memory v1/* return_data */){
    //     v1/* return_data */ = E33.f280/* calculate_max_consumable_gas */(p1/* gas_prices */, num_data);
    // }

    /* get_last_transaction_block & last_transaction_time & entered_contracts_count & transaction_count_data */
    // E33.NumData private num_data;
    // function f170(uint256[] calldata p1/* accounts */ ) 
    // external view returns(uint256[] memory v1/* return_data */){
    //     uint256[4][] memory v2/* data */ = E33.f170/* get_last_transaction_block & last_transaction_time & entered_contracts_count & transaction_count_data */(p1/* accounts */, num_data);

    //     v1/* return_data */ = new uint256[](100);
    //     uint256 v4/* pos */ = 0;

    //     for (uint256 t = 0; t < v2/* data */.length; t++) {
    //         for (uint256 e = 0; e < v2/* data */[t].length; e++) {
    //             v1/* return_data */[v4/* pos */] = v2/* data */[t][e];
    //             v4/* pos */++;
    //         }
    //     }
    // }


    /* get_total_consensus_data_as_percentages */
    // function f278( uint256[][] calldata p1/* raw_vote_data */ ) 
    // external pure returns(uint256[] memory v1/* return_data */){
    //     uint256[][] memory v2/* data */ = E32.f278/* get_total_consensus_data_as_percentages */(p1/* raw_vote_data */);

    //     v1/* return_data */ = new uint256[](100);
    //     uint256 v4/* pos */ = 0;

    //     for (uint256 t = 0; t < v2/* data */.length; t++) {
    //         for (uint256 e = 0; e < v2/* data */[t].length; e++) {
    //             v1/* return_data */[v4/* pos */] = v2/* data */[t][e];
    //             v4/* pos */++;
    //         }
    //     }
    // }



    /* calculate_yes_vote_proportion */
    // function f272(
    //     uint256 p1/* total_wait */, 
    //     uint256 p2/* total_yes */, 
    //     uint256 p3/* total_no */
    // ) public pure returns(uint256 v1/* proportion */){
    //     v1/* proportion */ = E32.f272/* calculate_yes_vote_proportion */(p1/* total_wait */, p2/* total_yes */, p3/* total_no */);

    //     uint256 v2/* proportion */ = G32.f272/* calculate_yes_vote_proportion */(p1/* total_wait */, p2/* total_yes */, p3/* total_no */);

    //     if(v1/* proportion */ != v2/* proportion */){
    //         v1/* proportion */ = 1;
    //     }
    // }


    /* ensure_interactibles_for_multiple_accounts */
    // E34.NumData private num_data;
    // function f257(uint256[] calldata p1/* targets */, uint256[] calldata p2/* accounts */) 
    // external {
    //     E34.f257/* ensure_interactibles_for_multiple_accounts */(p1/* targets */, num_data, p2/* accounts */);
    // }

    /* get_interactible_time_limits | blocked_account_time_limits */
    // E34.NumData private num_data;
    // function f256(
    //     uint256[] calldata p1/* targets */, 
    //     uint256[][] calldata p2/* accounts */, 
    //     uint256 p3/* time_or_amount */,
    //     uint256 p4/* action */
    // ) external view returns (uint256[] memory v1/* return_data */) {
    //     uint256[][] memory v2/* data */ = E34.f256/* get_interactible_time_limits */(p1/* targets */, p2/* accounts */, p3/* time_or_amount */, num_data, p4/* action */);

    //     v1/* return_data */ = new uint256[](100);
    //     uint256 v4/* pos */ = 0;

    //     for (uint256 t = 0; t < v2/* data */.length; t++) {
    //         for (uint256 e = 0; e < v2/* data */[t].length; e++) {
    //             v1/* return_data */[v4/* pos */] = v2/* data */[t][e];
    //             v4/* pos */++;
    //         }
    //     }
    // }

    /* get_moderator_settings */
    // E34.NumData private num_data;
    // function f255(uint256[] calldata p1/* targets */, uint256[][] calldata p2/* accounts */) 
    // external view returns (bool[] memory v1/* return_data */) {
    //     bool[][] memory v2/* data */ = E34.f255/* get_moderator_settings */(p1/* targets */, p2/* accounts */, num_data);

    //     v1/* return_data */ = new bool[](100);
    //     uint256 v4/* pos */ = 0;

    //     for (uint256 t = 0; t < v2/* data */.length; t++) {
    //         for (uint256 e = 0; e < v2/* data */[t].length; e++) {
    //             v1/* return_data */[v4/* pos */] = v2/* data */[t][e];
    //             v4/* pos */++;
    //         }
    //     }
    // }


    // /* get_interactible_checker_settings */
    // E34.NumData private num_data;
    // function f254(uint256[] calldata p1/* targets */) 
    // external view returns (bool[] memory v1/* data */) {
    //     v1/* data */ = E34.f254/* get_interactible_checker_settings */(p1/* targets */, num_data, 0);
    // }

    /* get_auth_privelages_setting */
    // function f2542(uint256[] calldata p1/* targets */) 
    // external view returns (bool[] memory v1/* data */) {
    //     v1/* data */ = E34.f254/* get_auth_privelages_setting */(p1/* targets */, num_data, 1);
    // }

    /* scan_int_int_int */
    // G32.NumData private num_data;
    // function f167(uint256[][] calldata p1/* _ids */) 
    // external view returns (uint256[] memory v1/* data */) {
    //     v1/* data */ = G32.f167/* scan_int_int_int */(p1/* _ids */, num_data);
    // }

    /* get_collect_subscription_data */
    // function f251(
    //     uint256[][][] calldata p1/* target_nums */,
    //     uint256[21] memory p2/* consensus_type_data */
    // ) public pure returns (uint256[] memory v1/* return_data */) {
    //     uint256[][3][3] memory v3/* data2 */ = F33.f251(p1/* target_nums */, p2/* consensus_type_data */);

    //     v1/* return_data */ = new uint256[](100);
    //     uint256 v4/* pos */ = 0;

    //     for (uint256 t = 0; t < 3; t++) {
    //         for (uint256 e = 0; e < v3/* data2 */[t].length; e++) {
    //             for (uint256 f = 0; f < v3/* data2 */[t][e].length; f++) {
    //                 v1/* return_data */[v4/* pos */] = v3/* data2 */[t][e][f];
    //                 v4/* pos */++;
    //             }
    //         }
    //     }

    // }



    /* get_collect_subscription_targets_count */
    // function f252(uint256[20] calldata p1/* consensus_type_data */)
    // public pure returns (uint256[] memory v1/* return_data */) {
    //     uint256[][3][3] memory v2/* data */ = F32.f252(p1/* consensus_type_data */);

    //     v1/* return_data */ = new uint256[](100);
    //     uint256 v4/* pos */ = 0;

    //     for (uint256 t = 0; t < 3; t++) {
    //         for (uint256 f = 0; f < 3; f++) {
    //             v1/* return_data */[v4/* pos */] = v2/* data */[t][f].length;
    //             v4/* pos */++;
    //         }
    //     }
    // }



    /* get_consensus_collect_subscription_payers_data */
    // function f253(
    //     uint256[][3] memory p1/* temp_transaction_data_group */,
    //     uint256 p2/* user_acc_id */,
    //     uint256[][][] calldata p3/* _ints */,
    //     address[] calldata p4/* _adds */,
    //     string[][] calldata p5/* _strs */
    // ) public pure returns (uint256[] memory v1/* return_data */) {
    //     E3.TD memory v2/* tx_data */ = E3.TD( p2/* user_acc_id */, false/* can_sender_vote_in_main_contract */, p1/* temp_transaction_data_group */[0], p3/* _ints */[0], p4/* _adds */, p5/* _strs */, 0, /* t */ 0, /* new_obj_id */ 500 /* msg.value */, [ 3/* transaction_count */, uint256(5)/* entered_contracts */ ], false );

    //     (uint256[][] memory v3/* payer_accounts */, uint256[][][2] memory v5/* target_bounty_exchanges_depth-data */) = E3.f253/* get_consensus_collect_subscription_payers_data */(v2/* tx_data */);


    //     v1/* return_data */ = new uint256[](100);
    //     uint256 v4/* pos */ = 0;
    //     for (uint256 r = 0; r < v3/* payer_accounts */.length; r++) {
    //         for (uint256 e = 0; e < v3/* payer_accounts */[r].length; e++) {
    //             v1/* return_data */[v4/* pos */] = v3/* payer_accounts */[r][e];
    //             v4/* pos */++;
    //         }
    //     }

    //     for (uint256 r = 0; r < v5/* target_bounty_exchanges_depth-data */.length; r++) {
    //         for (uint256 e = 0; e < v5/* target_bounty_exchanges_depth-data */[r].length; e++) {
    //             for (uint256 f = 0; f < v5/* target_bounty_exchanges_depth-data */[r][e].length; f++) {
    //                 v1/* return_data */[v4/* pos */] = v5/* target_bounty_exchanges_depth-data */[r][e][f];
    //                 v4/* pos */++;
    //             }
    //         }
    //     }

    // }

    /* scan_num */
    // E34.NumData private num_data;
    // function f207(uint256[][] calldata p1/* _ids */) 
    // external view returns (uint256[] memory v1/* data */) {
    //     v1/* data */ = E34.f207/* scan_num */(p1/* _ids */, num_data);
    // }

    /* calculate_mock_tokens_to_receive */
    // function f250(
    //     uint256[][5] calldata p1/* data */,
    //     uint256[][][] calldata p2/* exchange_nums */
    // ) external pure returns (uint256[] memory v1/* tokens_to_receive */){
    //     v1/* tokens_to_receive */ = E32.f250/* calculate_mock_tokens_to_receive */(p1/* data */, p2/* exchange_nums */);
    // }

    /* update_mock_reduction_proportion_ratios */
    // function f249(
    //     uint256[][5] calldata p1/* data */,
    //     uint256[][][] memory p2/* exchange_nums */,
    //     uint256[] calldata p3/* new_ratios */
    // ) external pure returns (uint256[] memory v1/* return_data */) {
    //     uint256[][][] memory v2/* updated_exchange_nums */ = E32.f249/* update_mock_reduction_proportion_ratios */(p1/* data */, p2/* exchange_nums */, p3/* new_ratios */);

    //     v1/* return_data */ = new uint256[](100);
    //     uint256 v4/* pos */ = 0;

    //     for (uint256 t = 0; t < v2/* updated_exchange_nums */.length; t++) {
    //         for (uint256 e = 0; e < v2/* updated_exchange_nums */[t].length; e++) {
    //             for (uint256 v = 0; v < v2/* updated_exchange_nums */[t][e].length; v++) {
    //                 v1/* return_data */[v4/* pos */] = v2/* updated_exchange_nums */[t][e][v];
    //                 v4/* pos */++;
    //             }
    //         }
    //     }
    // }


    /* set_up_mock_data */
    // function f248( uint256[] calldata p1/* exchanges */, uint256[][][] calldata p2/* exchange_nums */ ) 
    // external pure returns(uint256[] memory v1/* return_data */){
    //     uint256[][5] memory v2/* data */ = H32.f248/* set_up_mock_data */(p1/* exchanges */, p2/* exchange_nums */);

    //     v1/* return_data */ = new uint256[](100);
    //     uint256 v4/* pos */ = 0;

    //     for (uint256 t = 0; t < v2/* data */.length; t++) {
    //         for (uint256 e = 0; e < v2/* data */[t].length; e++) {
    //             v1/* return_data */[v4/* pos */] = v2/* data */[t][e];
    //             v4/* pos */++;
    //         }
    //     }
    // }

    /* calculate_price_of_tokens */
    // function f245(
    //     uint256[] calldata p1/* exchanges */,
    //     uint256[][] calldata p2/* amounts */,
    //     uint256[] calldata p3/* actions */,
    //     uint256[][][] calldata p4/* exchange_data */
    // ) public pure returns (uint256[] memory v1/* return_data */){
    //     uint256[][] memory v2/* data */ =  E34.f245/* calculate_price_of_tokens */(p1/* exchanges */, p2/* amounts */, p3/* actions */, p4/* exchange_data */);

    //     v1/* return_data */ = new uint256[](100);
    //     uint256 v4/* pos */ = 0;

    //     for (uint256 t = 0; t < v2/* data */.length; t++) {
    //         for (uint256 e = 0; e < v2/* data */[t].length; e++) {
    //             v1/* return_data */[v4/* pos */] = v2/* data */[t][e];
    //             v4/* pos */++;
    //         }
    //     }
    // }

    // /* calculate_resulting_tokens */
    // function f246(
    //     uint256[][] memory p1/* exchange_data */,
    //     uint256[] memory p2/* provided_amount_data */,
    //     uint256 p3/* amount */,
    //     uint256 p4/* action */
    // ) public pure returns (uint256[] memory v1/* price_data */){
    //     return E34.f246/* calculate_resulting_tokens */(p1/* exchange_data */, p2/* provided_amount_data */, p3/* amount */, p4/* action */);
    // }


    /* modify_targets */
    // G3.NumData private num_data;
    // function f243(
    //     uint256[][5] calldata p1/* data */, 
    //     uint256 p2/* action */
    // ) external {
    //     G3.f243/* modify_targets */(p1/* data */, num_data, p2/* action */);
    // }


    /* get_consensus_stack_depth_swap */
    // function f241(
    //     uint256[] calldata p1/* targets */,
    //     uint256[][][] calldata p2/* target_nums */,
    //     uint256[8] memory p3/* consensus_type_data */
    // ) public pure returns (uint256[] memory v1/* return_data */) {
    //     uint256[][6] memory v3/* data2 */ = E33.f241(p1/* targets */, p2/* target_nums */, p3/* consensus_type_data */);

    //     v1/* return_data */ = new uint256[](100);
    //     uint256 v4/* pos */ = 0;

    //     for (uint256 t = 0; t < 6; t++) {
    //         for (uint256 e = 0; e < v3/* data2 */[t].length; e++) {
    //             v1/* return_data */[v4/* pos */] = v3/* data2 */[t][e];
    //             v4/* pos */++;
    //         }
    //     }

    // }



    /* get_stack_depth_swap_count */
    // function f240(uint256 p1/* size */)
    // public pure returns (uint256[] memory v1/* return_data */) {
    //     uint256[][6] memory v2/* data */ = E33.f240(p1/* size */);

    //     v1/* return_data */ = new uint256[](100);
    //     uint256 v4/* pos */ = 0;

    //     for (uint256 t = 0; t < 6; t++) {
    //         v1/* return_data */[v4/* pos */] = v2/* data */[t].length;
    //         v4/* pos */++;
    //     }
    // }


    /* account_balance_of */
    // H32.NumData private num_data;
    // function f140e(
    //     uint256[] calldata p1/* exchanges */, 
    //     uint256 p2/* account */, 
    //     uint256[] calldata p3/* depths */
    // ) external view returns(uint256[] memory v1/* data */) {
    //     v1/* data */ = H32.f140e/* account_balance_of */(p1, p2, num_data, p3);
    // }

    /* balance_of */
    // H32.NumData private num_data;
    // function f140(
    //     uint256[] calldata p1/* exchanges */, 
    //     uint256[] calldata p2/* accounts */, 
    //     uint256[] calldata p3/* depths */,
    //     uint256 p4/* unfroozen_or_froozen */
    // ) external view returns(uint256[] memory v1/* data */) {
    //     v1/* data */ = H32.f140/* balance_of */(p1, p2, num_data, p3, p4);
    // }

    /* scan_account_exchange_data */
    // H3.NumData private num_data;
    // function f241(
    //     uint256[] calldata p1/* accounts */, 
    //     uint256[] calldata p2/* exchanges */
    // ) external view returns (uint256[] memory v1/* return_data */){
    //     uint256[3][] memory v2/* account_exchange_data */ = H3.f241(p1/* accounts */, num_data, p2/* exchanges */);

    //     v1/* return_data */ = new uint256[](100);
    //     uint256 v3/* pos */ = 0;

    //     for (uint256 t = 0; t < v2/* account_exchange_data */.length; t++) {
    //         for (uint256 e = 0; e < v2/* account_exchange_data */[t].length; e++) {
    //             v1/* return_data */[v3/* pos */] = v2/* account_exchange_data */[t][e];
    //             v3/* pos */++;
    //         }
    //     }
    // }

    /* modify_proposal */
    // G3.NumData private num_data;
    // function f238(uint256[][5] calldata p1/* data */) external {
    //     G3.f238(p1/* data */, num_data);
    // }

    /* get_account votes_data */
    // G32.NumData private num_data;
    // function f237(
    //     uint256[] calldata p1/* consensus_targets */, 
    //     uint256[][] calldata p2/* voter_accounts */
    // ) external view returns (uint256[] memory v1/* return_data */){
    //     uint256[][] memory v2/* vote_data */ = G32.f237/* get_account votes_data */(p1/* consensus_targets */, p2/* voter_accounts */, num_data);

    //     v1/* return_data */ = new uint256[](100);
    //     uint256 v3/* pos */ = 0;

    //     for (uint256 t = 0; t < v2/* total_vote_data */.length; t++) {
    //         for (uint256 e = 0; e < v2/* total_vote_data */[t].length; e++) {
    //             v1/* return_data */[v3/* pos */] = v2/* total_vote_data */[t][e];
    //             v3/* pos */++;
    //         }
    //     }
    // }

    /* get_total_consensus_data */
    // G32.NumData private num_data;
    // function f236(
    //     uint256[] calldata p1/* data */
    // ) external view returns (uint256[] memory v1/* return_data */){
    //     uint256[][] memory v2/* total_vote_data */ = G32.f236/* get_total_consensus_data */(p1/* data */, num_data, 0);

    //     v1/* return_data */ = new uint256[](100);
    //     uint256 v3/* pos */ = 0;

    //     for (uint256 t = 0; t < v2/* total_vote_data */.length; t++) {
    //         for (uint256 e = 0; e < 3; e++) {
    //             v1/* return_data */[v3/* pos */] = v2/* data2 */[t][e];
    //             v3/* pos */++;
    //         }
    //     }
    // }


    // /* contract_voter_count_data */
    // function f2362(
    //     uint256[] calldata p1/* data */
    // ) external view returns (uint256[] memory v1/* return_data */){
    //     uint256[][] memory v2/* total_vote_data */ = G32.f236/* get_total_consensus_data */(p1/* data */, num_data, 2);

    //     v1/* return_data */ = new uint256[](100);
    //     uint256 v3/* pos */ = 0;

    //     for (uint256 t = 0; t < v2/* total_vote_data */.length; t++) {
    //         for (uint256 e = 0; e < v2/* total_vote_data */[t].length; e++) {
    //             v1/* return_data */[v3/* pos */] = v2/* data2 */[t][e];
    //             v3/* pos */++;
    //         }
    //     }
    // }


    /* run_exchange_transfer_checkers */
    // H3.NumData private num_data;
    // function f231(
    //     uint256[][6] calldata p1/* data */,
    //     uint256 p2/* initiator_account */
    // ) external view returns (uint256[] memory v1/* return_data */){
    //     uint256[][5] memory v3/* data2 */ = H3.f231(p1/* data */, p2/* initiator_account */, num_data);

    //     v1/* return_data */ = new uint256[](100);
    //     uint256 v4/* pos */ = 0;

    //     for (uint256 t = 0; t < 5; t++) {
    //         for (uint256 e = 0; e < v3/* data2 */[t].length; e++) {
    //             v1/* return_data */[v4/* pos */] = v3/* data2 */[t][e];
    //             v4/* pos */++;
    //         }
    //     }
    // }

    /* get_consensus_exchange_transfer_data */
    // function f233(
    //     uint256[] calldata p1/* targets */,
    //     uint256[][][] calldata p2/* target_nums */,
    //     uint256[7] memory p3/* consensus_type_data */
    // ) public pure returns (uint256[] memory v1/* return_data */) {
    //     uint256[][6] memory v3/* data2 */ = G32.f233(p1/* targets */, p2/* target_nums */, p3/* consensus_type_data */);

    //     v1/* return_data */ = new uint256[](100);
    //     uint256 v4/* pos */ = 0;

    //     for (uint256 t = 0; t < 6; t++) {
    //         for (uint256 e = 0; e < v3/* data2 */[t].length; e++) {
    //             v1/* return_data */[v4/* pos */] = v3/* data2 */[t][e];
    //             v4/* pos */++;
    //         }
    //     }

    // }



    /* get_exchange_transfer_count */
    // function f234(uint256 p1/* size */)
    // public pure returns (uint256[] memory v1/* return_data */) {
    //     uint256[][6] memory v2/* data */ = G32.f234(p1/* size */);

    //     v1/* return_data */ = new uint256[](100);
    //     uint256 v4/* pos */ = 0;

    //     for (uint256 t = 0; t < 6; t++) {
    //         v1/* return_data */[v4/* pos */] = v2/* data */[t].length;
    //         v4/* pos */++;
    //     }
    // }


    /* get_stack_depth_swap_data */
    // function f36(
    //     uint256[][3] memory p1/* temp_transaction_data_group */,
    //     uint256 p2/* user_acc_id */,
    //     uint256[][][] calldata p3/* _ints */,
    //     address[][] calldata p4/* _adds */,
    //     string[][][] calldata p5/* _strs */
    // ) public pure returns (uint256[] memory v1/* return_data */) {
    //     E3.TD/* TransactionData */ memory v2/* tx_data */ = E3.TD/* TransactionData */( p2/* user_acc_id */, false/* can_sender_vote_in_main_contract */, p1/* temp_transaction_data_group */, p3/* _ints */, p4/* _adds */, p5/* _strs */, 0, /* t */ 0, /* new_obj_id */ 500 /* msg.value */, [ 3/* transaction_count */, uint256(5)/* entered_contracts */ ], false );

    //     uint256[][5] memory v3/* awward_targets_data */ = E3.f226/* get_stack_depth_swap_data */(v2/* tx_data */);

    //     v1/* return_data */ = new uint256[](100);
    //     uint256 v5/* pos */ = 0;
    //     for (uint256 r = 0; r < v3/* awward_targets_data */.length; r++) {
    //         for (uint256 t = 0; t < v3/* awward_targets_data */[r].length; t++) {
    //             v1/* return_data */[v5/* pos */] = v3/* awward_targets_data */[r][t];
    //             v5/* pos */++;
    //         }
    //     }

    // }


    /* get_nested_exch_data_for_bounties */
    // function f228(
    //     uint256[][] calldata p1/* t_vals */,
    //     uint256[] calldata p2/* targets */,
    //     uint256 p3/* start_from */,
    //     uint256[] calldata p4/* temp_transaction_data */,
    //     uint256 p5/* sender_acc_id */
    // ) external pure returns (uint256[] memory v1/* return_data */) {
    //     uint256[][][2] memory v2/* target_bounty_exchanges_depth-data */ = E32.f228(p1/* t_vals */, p2/* targets */, p3/* start_from */, p4/* temp_transaction_data */, p5/* sender_acc_id */);

    //     v1/* return_data */ = new uint256[](100);
    //     uint256 v3/* pos */ = 0;
    //     for (uint256 u = 0; u < v2/* target_bounty_exchanges_depth-data */.length; u++) {
    //         for (uint256 r = 0; r < v2/* target_bounty_exchanges_depth-data */[u].length; r++) {
    //             for (uint256 t = 0; t < v2/* target_bounty_exchanges_depth-data */[u][r].length; t++) {
    //                 v1/* return_data */[v3/* pos */] = v2/* target_bounty_exchanges_depth-data */[u][r][t];
    //                 v3/* pos */++;
    //             }
    //         }
    //     }
    // }

    /* stack_depth_swap */
    // H32.NumData private num_data;
    // function f227(uint256[][6] memory p1/* data */, uint256 p2/* sender_acc_id */, uint256[][][] memory p3/* num */) external {
    //     H32.f227(p1/* data */, num_data, p2/* sender_acc_id */, p3/* num */);
    // }


    /* run_exchange_transfers */
    // H32.NumData private num_data;
    // function f131(uint256[][5] calldata p1/* data */, uint256[] calldata p2/* tokens_to_receive */, uint256 p3/* sender_account */, uint256[][][] calldata p4/* exchange_nums */, bool p5/* authority_mint */) external {
    //     H32.f131(p1/* data */, p2/* tokens_to_receive */, p3/* sender_account */, p4/* exchange_nums */, p5/* authority_mint */, num_data);
    // }

    /* run_exchange_transfer */
    // H32.NumData private num_data;
    // function f130(uint256[4] memory p1/* amount_sender_acc_receiver_acc */, uint256 p2/* exchange_id */) public {
    //     H32.f130(p1/* amount_sender_acc_receiver_acc */, p2/* exchange_id */, num_data);
    // }

    /* update_balances */
    // H32.NumData private num_data;
    // function f129(uint256[][6] calldata p1/* data */, uint256[] memory p2/* tokens_to_receive */, uint256 p3/* sender_account */, uint256[][][] calldata p4/* exchange_nums */, bool p5/* authority_mint */) public {
    //     H32.f129(p1/* data */, p2/* tokens_to_receive */, p3/* sender_account */, num_data, p4/* exchange_nums */, p5/* authority_mint */);
    // }

    /* execute_freeze_unfreeze_tokens */
    // H32.NumData private num_data;
    // function f127(uint256[][6] memory p1/* data */, uint256 p2/* sender_acc_id */, uint256[][][] memory p3/* num */) external {
    //     H32.f127(p1/* data */, p2/* sender_acc_id */, num_data, p3/* num */);
    // }

    /* link_exchanges */
    // H32.NumData private num_data;
    // function f126(uint256[][5] calldata p1/* target_id_data */, uint256 p2/* entered_contracts_count */, uint256 p3/* transaction_count */, uint256[][][][2] memory p4/* data */) external {
    //     H32.f126(p1/* target_id_data */, p2/* entered_contracts_count */, p3/* transaction_count */, num_data, p4/* data */);
    // }

    /* update_exchange_ratios */
    // H3.NumData private num_data;
    // function f125( uint256[][6] memory p1/* data */, uint256[] memory p2/* tokens_to_receive */ ) external {
    //     H3.f125(p1/* data */, p2/* tokens_to_receive */, num_data);
    // }

    /* update_reduction_proportion_ratios */
    // H3.NumData private num_data;
    // uint256[][][] q/* updated_exchange_nums */;
    // function f124(uint256[][5] calldata p1/* data */, uint256[][][] calldata p2/* exchange_nums */, uint256[] memory p3/* new_ratios */) external {
    //     q/* updated_exchange_nums */ = H3.f124(p1/* data */, p2/* exchange_nums */, num_data, p3/* new_ratios */);
    // }

    /* read_data */
    // function f1242() public view returns (uint256[] memory v1/* return_data */){
    //     v1/* return_data */ = new uint256[](101);
    //     uint256 v2/* pos */ = 0;
    //     for (uint256 e = 0; e < q/* updated_exchange_nums */.length; e++) {
    //         for (uint256 l = 0; l < q/* updated_exchange_nums */[e].length; l++) {
    //             for (uint256 f = 0; f < q/* updated_exchange_nums */[e][l].length; f++) {
    //                 v1/* return_data */[v2/* pos */] = q/* updated_exchange_nums */[e][l][f];
    //                 v2/* pos */++;
    //             }
    //         }
    //     }
    // }

    // /* run_exchange_checkers */
    // H3.NumData private num_data;
    // function f123(uint256[][6] memory p1/* data */, uint256[4] calldata p2/* metas */, bool p3/* authority_mint */, uint256[][] calldata p4/* preset_data */) external {
    //     set_preset_data(p4/* preset_data */);
    //     uint256[][][] memory v1/* exchange_data */ = H3.f123(p1/* data */, p2/* metas */, p3/* authority_mint */, num_data);
    // }

    // /* get_block_number */
    // function f1232() external view returns (uint256){
    //     return block.number;
    // }

    /* modify_token_exchange */
    // H3.NumData private num_data;
    // function f122(uint256[][5] memory p1/* data */, uint256 p2/* sender_account */) external {
    //     H3.f122(p1/* data */, num_data, p2/* sender_account */);
    // }

    /* boot */
    // H3.NumData private num_data;
    // function f121(uint256[][][] calldata p1/* boot_data */, uint256[][] calldata p2/* boot_id_data_type_data */) external {
    //     H3.f121(p1/* boot_data */, p2/* boot_id_data_type_data */, num_data);
    // }

    /* record_voter_work */
    // G32.NumData private num_data;
    // function f119( uint256 p1/* target_contract_id */, uint256 p2/* sender_acc_id */, bool p3/* record_target_payer_for_buy */, uint256 p4/* proposal_id */, uint256 p5/* contract_auto_wait */, uint256 p6/* allow_external_buy_proposals */) external {
    //     G32.f119(p1/* target_contract_id */, p2/* sender_acc_id */, p3/* record_target_payer_for_buy */, p4/* proposal_id */, p5/* contract_auto_wait */, num_data, p6/* allow_external_buy_proposals */);
    // }

    /* archive_data */
    // G32.NumData private num_data;
    // bool q/* includes_transfers */;
    // function f118( 
    //     uint256[] calldata p1/* targets */, 
    //     uint256[][][] calldata p2/* target_data */, 
    //     uint256[][][3] calldata p3/* accounts_exchanges */ 
    // ) external {
    //     q/* includes_transfers */ = G32.f118(p1/* targets */, p2/* target_data */, num_data, p3/* accounts_exchanges */);
    // }

    // /* read_include_transfers */
    // function f1182() public view returns (bool){
    //     return q/* includes_transfers */;
    // }

    /* run_all_consensus_checkers */
    // uint256[21] w/* consensus_type_data */;
    // bool[3] b/* contains_subscription_contract_mod_work */ ;
    // G32.NumData private num_data;
    // function f117( 
    //     uint256[] calldata p1/* targets */, 
    //     uint256[][][] memory p2/* target_nums_data */ 
    // ) external {
    //     (w/* consensus_type_data */, b/* contains_subscription_contract_mod_work */) = G32.f117(p1/* targets */, p2/* target_nums_data */, num_data);
    // }

    // // /* get_return_data */
    // function f1172() public view returns(uint256[] memory v1/* return_data */){
    //     v1/* return_data */ = new uint256[](101);
    //     uint256 v2/* pos */ = 0;
    //     for (uint256 e = 0; e < w/* consensus_type_data */.length; e++) {
    //         v1/* return_data */[v2/* pos */] = w/* consensus_type_data */[e];
    //         v2/* pos */++;
    //     }
    // }

    // /* return contains_subscriptions_contract_mod_work value */
    // function f1173() public view returns(bool[3] memory){
    //     return b/* contains_subscription_contract_mod_work */;
    // }

    /* execute_vote_proposal_checkers */
    // bool[] q/* include_transfers */;
    // bool w/* transfer_work */;
    // G32.NumData private num_data;
    // function f116(
    //     uint256[] memory p1/* targets */, 
    //     uint256 p2/* sender_account */, 
    //     uint256[] memory p3/* votes */,  
    //     bool p4/* can_sender_vote_in_main_contract */, 
    //     uint256[][][] memory p5/* target_nums_data */, 
    //     uint256[][] memory p6/* target_bounty_exchanges */
    // ) public {
    //     q/* include_transfers */ = new bool[](0);
    //     w/* transfer_work */ = false;

    //     uint256[] memory e = new uint256[](0);
    //     uint256[] memory v2/* voter_weight_exchanges */ = new uint256[](p1/* targets */.length);
    //     uint256[][5] memory v1/* target_data */ = [p1/* targets */, p3/* votes */, e, v2/* voter_weight_exchanges */, v2/* voter_weight_exchanges */];

    //     (q/* include_transfers */, w/* transfer_work */) = G32.f116(v1/* target_data */, p2/* sender_account */, p4/* can_sender_vote_in_main_contract */, p5/* target_nums_data */, num_data, p6/* target_bounty_exchanges */);
    // }

    /* get_return_data */
    // function f1162() public view returns(uint256[] memory v1/* return_data */){
    //     v1/* return_data */ = new uint256[](101);
    //     uint256 v2/* pos */ = 0;
    //     for (uint256 e = 0; e < q/* include_transfers */.length; e++) {
    //         v1/* return_data */[v2/* pos */] = (q/* include_transfers */[e] == true ? 1 : 0);
    //         v2/* pos */++;
    //     }
    //     v1/* return_data */[v2/* pos */] = (w/* transfer_work */ == true ? 1 : 0);
    // }

    // function f1163(
    //     uint256[] memory p1/* targets */, 
    //     uint256 p2/* sender_account */, 
    //     uint256[] memory p3/* votes */,  
    //     bool p4/* can_sender_vote_in_main_contract */, 
    //     uint256[][][] memory p5/* target_nums_data */, 
    //     uint256[][] memory p6/* target_bounty_exchanges */,
    //     uint256[] memory p7/* voter_weight_exchanges */,
    //     uint256[] memory p8/* weight_balances */
    // ) public {
    //     q/* include_transfers */ = new bool[](0);
    //     w/* transfer_work */ = false;

    //     uint256[] memory e = new uint256[](0);
    //     uint256[][5] memory v1/* target_data */ = [p1/* targets */, p3/* votes */, e, p7/* voter_weight_exchanges */, p8/* voter_weight_exchanges */];

    //     (q/* include_transfers */, w/* transfer_work */) = G32.f116(v1/* target_data */, p2/* sender_account */, p4/* can_sender_vote_in_main_contract */, p5/* target_nums_data */, num_data, p6/* target_bounty_exchanges */);
    // }

    /* update_vote_data */
    // bool[] q/* include_transfers */;
    // bool w/* transfer_work */;
    // G32.NumData private num_data;
    // function f115(
    //     uint256[] memory p1/* targets */, 
    //     uint256 p2/* sender_account */, 
    //     uint256[] memory p3/* votes */, 
    //     uint256[][] memory p4/* target_bounty_exchanges */
    // ) public {
    //     q/* include_transfers */ = new bool[](0);
    //     w/* transfer_work */ = false;

    //     uint256[] memory e = new uint256[](0);
    //     uint256[] memory v2/* voter_weight_exchanges */ = new uint256[](p1/* targets */.length);
    //     uint256[][5] memory v1/* target_data */ = [p1/* targets */, p3/* votes */, e, v2/* voter_weight_exchanges */, v2/* voter_weight_exchanges */];

    //     (q/* include_transfers */, w/* transfer_work */) = G32.f115(v1/* target_data */, p2/* sender_account */, num_data, p4/* target_bounty_exchanges */);
    // }

    // /* get_return_data */
    // function f1152() public view returns(uint256[] memory v1/* return_data */){
    //     v1/* return_data */ = new uint256[](101);
    //     uint256 v2/* pos */ = 0;
    //     for (uint256 e = 0; e < q/* include_transfers */.length; e++) {
    //         v1/* return_data */[v2/* pos */] = (q/* include_transfers */[e] == true ? 1 : 0);
    //         v2/* pos */++;
    //     }
    //     v1/* return_data */[v2/* pos */] = (w/* transfer_work */ == true ? 1 : 0);
    // }



    // function f1153(
    //     uint256[] memory p1/* targets */, 
    //     uint256 p2/* sender_account */, 
    //     uint256[] memory p3/* votes */, 
    //     uint256[][] memory p4/* target_bounty_exchanges */,
    //     uint256[] memory p5/* voter_weight_exchanges */,
    //     uint256[] memory p6/* weight_balances */
    // ) public {
    //     q/* include_transfers */ = new bool[](0);
    //     w/* transfer_work */ = false;

    //     uint256[] memory e = new uint256[](0);
    //     uint256[][5] memory v1/* target_data */ = [p1/* targets */, p3/* votes */, e, p5/* voter_weight_exchanges */, p6/* weight_balances */];

    //     (q/* include_transfers */, w/* transfer_work */) = G32.f115(v1/* target_data */, p2/* sender_account */, num_data, p4/* target_bounty_exchanges */);
    // }


    /* execute_force_exit_contract_work */
    // function f1142( 
    //     uint256[] calldata p1/* targets */, 
    //     uint256 p2/* sender_account */,
    //     uint256[][][] calldata p3/* targets_data */,
    //     uint256[] calldata p4/* target_force_exit_accounts */
    // ) external {
    //     uint256[] memory e = new uint256[](0);
    //     G32.f114([p1/* targets */, e, e, p4/* target_force_exit_accounts */, e], p2/* sender_account */, num_data, p3/* targets_data */, 18/* contract_force_exit_accounts */);
    // }

    /* execute_exit_contract_work */
    // G32.NumData private num_data;
    // function f114( uint256[] calldata p1/* targets */, uint256 p2/* sender_account */ ) external {
    //     uint256[] memory e = new uint256[](0);
    //     uint256[][][] memory eee = new uint256[][][](0);
    //     G32.f114([p1/* targets */, e, e, e, e], p2/* sender_account */, num_data, eee, 11/* exit_contract */);
    // }

    /* execute_extend_enter_contract_work */
    // G32.NumData private num_data;
    // function f113( 
    //     uint256[] calldata p1/* targets */, 
    //     uint256[] calldata p2/* extension */, 
    //     uint256 p3/* sender_account */, 
    //     uint256[][][] memory p4/* targets_data */ 
    // ) external {
    //     uint256[] memory e = new uint256[](0);
    //     G32.f113([p1/* targets */, p2/* extension */, e, e, e], p3/* sender_account */, p4/* targets_data */, num_data);
    // }

    /* execute_enter_contract_work */
    // G32.NumData private num_data;
    // function f112( 
    //     uint256[] calldata p1/* targets */, 
    //     uint256[] calldata p2/* expiry */, 
    //     uint256 p3/* sender_account */, 
    //     uint256[] memory p4/* target_authors */, 
    //     uint256[][][] memory p5/* targets_data */ 
    // ) external {
    //     uint256[] memory e = new uint256[](0);
    //     G32.f112([p1/* targets */, p2/* expiry */, e, e, p4/* target_authors */], p3/* sender_account */, num_data, p5/* targets_data */);
    // }

    /* archive_proposal_data */
    // G3.NumData private num_data;
    // function f111(uint256[] calldata p1/* targets */) external {
    //     G3.f111(p1/* targets */, num_data);
    // }

    /* modify_contract */
    // G3.NumData private num_data;
    // bool q/* update_main_contract_limit_data */;
    // function f110( uint256[][5] memory v1/* data */ ) external {
    //     q/* update_main_contract_limit_data */ = false;
    //     q/* update_main_contract_limit_data */ = G3.f110(v1/* data */, num_data);
    // }

    // /* get_update_main_contract_limit_data_val */
    // function f1102() public view returns(bool){
    //     return q/* update_main_contract_limit_data */;
    // }

    /* record */
    // G3.NumData private num_data;
    // function f109(uint256[][] memory p1/* new_obj_id_num_data */, uint256 p2/* new_obj_id */, uint256 p3/* obj_type */) external {
    //     G3.f109(p1/* new_obj_id_num_data */, num_data, p2/* new_obj_id */, p3/* obj_type */);
    // }

    // /* read_data */
    // function f1092(uint256 p1/* new_obj_id */) public view returns (uint256[] memory v1/* return_data */){
    //     uint256[][] memory v2/* data */ = G3.f77/* read_id */(p1/* new_obj_id */, num_data);
    //     v1/* return_data */ = new uint256[](101);
    //     uint256 v3/* pos */ = 0;
    //     for (uint256 e = 0; e < v2/* data */.length; e++) {
    //         for (uint256 l = 0; l < v2/* data */[e].length; l++) {
    //             v1/* return_data */[v3/* pos */] = v2/* data */[e][l];
    //             v3/* pos */++;
    //         }
    //     }
    //     v1/* return_data */[v3/* pos */] = num_data.num_str_metas[p1/* new_obj_id */][ 1 /* num_data */ ][2];
    //     v3/* pos */++;
    //     v1/* return_data */[v3/* pos */] = num_data.num_str_metas[p1/* new_obj_id */][ 1 /* num_data */ ][4];
    // }

    // /* delete_data */
    // function f1093(uint256 p1/* new_obj_id */) public {
    //     uint256[][] memory v1/* data */ = G3.f77/* read_id */(p1/* new_obj_id */, num_data);
    //     mapping(uint256 => mapping(uint256 => uint256)) storage v2/* new_obj_id_nums */ = num_data.num[p1/* new_obj_id */];

    //     for (uint256 e = 0; e < v1/* data */.length; e++) {
    //         for (uint256 l = 0; l < v1/* data */[e].length; l++) {
    //             v2/* new_obj_id_nums */[e][l] = 0;
    //         }
    //     }
    //     num_data.num_str_metas[p1/* new_obj_id */][ 1 /* num_data */ ][2] = 0;
    //     num_data.num_str_metas[p1/* new_obj_id */][ 1 /* num_data */ ][4] = 0;
    // }

    // G3.NumData private num_data;
    // function f108(uint256[][][] calldata p1/* boot_data */, uint256[][] calldata p2/* boot_id_data_type_data */) external {
    //     G3.f108(p1/* boot_data */, p2/* boot_id_data_type_data */, num_data);
    // }

    // F3.NumData private num_data;
    // uint256[][5] q/* data */;
    // function f107(
    //     uint256[] memory p1/* targets */, 
    //     uint256[] memory p2/* amounts */, 
    //     uint256 p3/* sender_account */, 
    //     uint256 p4/* action */,
    //     uint256[] memory p5/* sender_accounts */
    // ) external {
    //     q/* data */ = [new uint256[](0), new uint256[](0), new uint256[](0), new uint256[](0), new uint256[](0)];
    //     q/* data */ = F3.f107(p1/* targets */, p2/* amounts */, p3/* sender_account */, p4/* action */, num_data, p5/* sender_accounts */);
    // }

    // /* read_data */
    // function f1072() public view returns (uint256[] memory v1/* return_data */){
    //     v1/* return_data */ = new uint256[](101);
    //     uint256 v2/* pos */ = 0;
    //     for (uint256 e = 0; e < q/* data */.length; e++) {
    //         for (uint256 l = 0; l < q/* data */[e].length; l++) {
    //             v1/* return_data */[v2/* pos */] = q/* data */[e][l];
    //             v2/* pos */++;
    //         }
    //     }
    // }

    /* collect_subscriptions */
    // F3.NumData private num_data;
    // uint256[][5] q/* data */;
    // function f106(
    //     uint256[] memory p1/* targets */, 
    //     uint256[][] memory p2/* payer_accounts */, 
    //     uint256 p3/* sender_account */, 
    //     uint256[] calldata p4/* sender_accounts */
    // ) external {
    //     q/* data */ = [new uint256[](0), new uint256[](0), new uint256[](0), new uint256[](0), new uint256[](0)];
    //     (q/* data */,) = F3.f106(p1/* targets */, p2/* payer_accounts */, p3/* sender_account */, num_data, p4/* sender_accounts */);
    // }

    // /* read_data */
    // function f1062() public view returns (uint256[] memory v1/* return_data */){
    //     v1/* return_data */ = new uint256[](101);
    //     uint256 v2/* pos */ = 0;
    //     for (uint256 e = 0; e < q/* data */.length; e++) {
    //         for (uint256 l = 0; l < q/* data */[e].length; l++) {
    //             v1/* return_data */[v2/* pos */] = q/* data */[e][l];
    //             v2/* pos */++;
    //         }
    //     }
    // }

    /* get_collectible_amount */
    // F3.NumData private num_data;
    // uint256 q/* time_amount */;
    // uint256 w/* last_time_paid */;
    // uint256 e/* time_paid_for */;
    // uint256 a/* unclaimed_time_paid */;
    // function f105( uint256 p1/* target */, uint256 p2/* payer_acount */ ) public {
    //     q/* time_amount */ = F3.f105(p1/* target */, p2/* payer_acount */ , num_data);
    //     // console.log("time_amount: %s", time_amount);
    //     mapping(uint256 => mapping(uint256 => uint256)) storage v1/* target_data */ = num_data.int_int_int[p1/* target */];

    //     w/* last_time_paid */ = v1/* target_data */[ 1 /* last_time_paid */ ][p2/* payer_acount */ ];
    //     e/* time_paid_for */ = v1/* target_data */[ 2 /* time_paid_for */ ][p2/* payer_acount */ ];
    //     a/* unclaimed_time_paid */ = v1/* target_data */[ 3 /* unclaimed_time_paid */ ][p2/* payer_acount */ ];
    // }

    // /* get_recorded_collectible_vals */
    // function f1052() public view returns (uint256[4] memory) {
    //     return [w/* last_time_paid */, e/* time_paid_for */, a/* unclaimed_time_paid */, q/* time_amount */];
    // }

    /* modify_subscription */
    // F3.NumData private num_data;
    // function f104( uint256[][5] memory p1/* data */, uint256 p2/* sender_account */ ) public {
    //     F3.f104(p1/* data */, p2/* sender_account */, num_data);
    // }

    // F3.NumData private num_data;
    // function f103(uint256 p1/* new_obj_id */, uint256[][] memory p2/* new_obj_id_num_data */) external {
    //     // console.log("");
    //     F3.f103(p1/* new_obj_id */, p2/* new_obj_id_num_data */, num_data);
    // }

    /* record_boot_id_types */
    // E34.NumData private num_data;
    // function f102( uint256[][] calldata p1/* boot_id_data_type_data */ ) external {
    //     E34.f102(p1/* boot_id_data_type_data */, num_data);
    // }

    /* record_obj_type_and_creator */
    // E34.NumData private num_data;
    // uint256[] q/* obj_type_skip_data */;
    // function f101( uint256[][][] calldata p1/* vals */, uint256 p2/* t */, uint256 p3/* user_acc_id */, uint256[] calldata p4/* temp_transaction_data */, uint256[] memory p5/* record_obj_type_skip_data */ ) external {
    //     q/* obj_type_skip_data */ = new uint256[](0);
    //     q/* obj_type_skip_data */ = E34.f101(p1/* vals */, p2/* t */, p3/* user_acc_id */, p4/* temp_transaction_data */, p5/* record_obj_type_skip_data */, num_data);
    // }

    // /* read_obj_type_and_creator */
    // function f1012(uint256[] memory p1/* obj_ids */) external view returns(uint256[] memory v1/* return_data */){
    //     v1/* return_data */ = new uint256[](101);
    //     uint256 v2/* pos */ = 0;
    //     for (uint256 l = 0; l < q/* obj_type_skip_data */.length; l++) {
    //         v1/* return_data */[v2/* pos */] = q/* obj_type_skip_data */[l];
    //         v2/* pos */++;
    //     }
    //     for (uint256 l = 0; l < p1/* obj_ids */.length; l++) {
    //         v1/* return_data */[v2/* pos */] = num_data.num[ p1/* obj_ids */[l] ][ 0 /* control */ ][ 0 /* data_type */ ];
    //         v2/* pos */++;
    //         v1/* return_data */[v2/* pos */] = num_data.int_int_int[ p1/* obj_ids */[l] ][ 0 /* control */ ][ 0 /* author_owner */ ];
    //         v2/* pos */++;
    //     }

    // }

    /* modify_moderators */
    // E34.NumData private num_data;
    // function f100(
    //     uint256[][5] calldata p1/* target_id_data */, 
    //     uint256 p2/* sender_acc_id */, 
    //     uint256[][] calldata p3/* preset_data */
    // ) external {
    //     set_preset_data(p3/* preset_data */);
    //     E34.f100(p1/* target_id_data */, num_data, p2/* sender_acc_id */);
    // }

    /* modify_interactibles */
    // E34.NumData private num_data;
    // uint256[2][] q/* vals */;
    // function f99( uint256[][5] memory p1/* target_id_data */, uint256 p2/* sender_acc_id */, uint256 p3/* action */, uint256[][] calldata p4/* preset_data */ ) external {
    //     q/* vals */ = new uint256[2][](0);
    //     set_preset_data(p4/* preset_data */);
    //     q/* vals */ = E34.f99(p1/* target_id_data */, num_data, p2/* sender_acc_id */, p3/* action */);
    // }

    // function f992() external view returns (uint256[] memory v1/* return_data */){
    //     v1/* return_data */ = new uint256[](101);
    //     uint256 v2/* pos */ = 0;
    //     for (uint256 e = 0; e < q/* vals */.length; e++) {
    //         for (uint256 l = 0; l < q/* vals */[e].length; l++) {
    //             v1/* return_data */[v2/* pos */] = q/* vals */[e][l];
    //             v2/* pos */++;
    //         }
    //     }

    // }

    /* execute_record_item_in_tag */
    // E34.NumData private num_data;
    // function f98(uint256[][5] calldata p1/* target_id_data */, uint256 p2/* sender_acc_id */,  uint256[][] calldata p3/* preset_data */) external {
    //     set_preset_data(p3/* preset_data */);
    //     E34.f98(p1/* target_id_data */, num_data, p2/* sender_acc_id */);
    // }

    /* run_indexing_block_count_checker */
    // E34.NumData private num_data;
    // function f97(uint256 p1/* item_type */, uint256 p2/* sender_acc_id */, uint256[][] calldata p3/* preset_data */) public {
    //     set_preset_data(p3/* preset_data */);
    //     E34.f97(num_data, p1/* item_type */, p2/* sender_acc_id */);
    // }

    /* archive_data */
    // E34.NumData private num_data;
    // function f96(uint256[] memory p1/* contract_proposal_ids */) external {
    //     E34.f96(p1/* contract_proposal_ids */, num_data);
    // }

    /* account_transaction_check */
    // E33.NumData private num_data;
    // function f95( 
    //     uint256 p1/* tx_gas */, 
    //     uint256 p2/* new_id */, 
    //     uint256[][][] calldata p3/* vals */, 
    //     uint256 p4/* current_id */ 
    // ) external {
    //     (q/* user_account_id */, w/* can_sender_vote_in_main_contract */, e/* temp_transaction_data_group */) = E33.f95(p1/* tx_gas */, num_data, p2/* new_id */, p3/* vals */, p4/* current_id */);
    // }
    // uint256 q/* user_account_id */;
    // bool w/* can_sender_vote_in_main_contract */;
    // uint256[][2] e/* temp_transaction_data_group */;

    /* read_account_transaction_check */
    // function f952(address p1/* sender_address */) external view returns(uint256[] memory v1/* return_data */) {
    //     v1/* return_data */ = new uint256[](101);
    //     v1/* return_data */[0] = q/* user_account_id */;
    //     v1/* return_data */[1] = w/* can_sender_vote_in_main_contract */ ? 2 : 3;
    //     v1/* return_data */[2] = e/* temp_transaction_data_group */[0].length;
    //     v1/* return_data */[3] = num_data.add_int[ 10 /* accounts_obj_id */ ][p1/* sender_address */];
    //     v1/* return_data */[4] = num_data.int_int_int[ q/* user_account_id */ ][ 1 /* data */ ][ 1 /* last_transaction_block */ ];
    //     v1/* return_data */[5] = num_data.int_int_int[ q/* user_account_id */ ][ 1 /* data */ ][ 2 /* last_transaction_time */ ];

    // }

    // /* reset_account_transaction */
    // function f953(address p1/* sender_address */) external {
    //     q/* user_account_id */ = 0;
    //     w/* can_sender_vote_in_main_contract */ = false;
    //     e/* temp_transaction_data_group */ = [new uint256[](0),new uint256[](0)];
    //     num_data.add_int[ 10 /* accounts_obj_id */ ][p1/* sender_address */] = 0;
    //     num_data.int_int_int[ q/* user_account_id */ ][ 1 /* data */ ][ 1 /* last_transaction_block */ ] = 0;
    //     num_data.int_int_int[ q/* user_account_id */ ][ 1 /* data */ ][ 2 /* last_transaction_time */ ] = 0;
    // }

    /* e34_update_main_contract_limit_data */
    // E34.NumData private num_data;
    // function f94(uint256[] calldata p1/* new_main_contract_config */) external {
    //     E34.f94(p1/* new_main_contract_config */, num_data);
    // }

    /* e33_update_main_contract_limit_data */
    // E33.NumData private num_data;
    // function f93(uint256[] calldata p1/* new_main_contract_config */) external {
    //     E33.f93(p1/* new_main_contract_config */, num_data);
    // }

    /* make_account_for_sender */
    // E33.NumData private num_data;
    // function f92(address p1/* sender_address */, uint256 p2/* new_user_acc_id */) public {
    //     E33.f92(p1/* sender_address */, p2/* new_user_acc_id */, num_data);
    // }
    // /* read_make_account_for_sender */
    // function f922(address p1/* sender_address */) public view returns(uint256 v1/* return_data */){
    //     v1/* return_data */ = num_data.add_int[ 10 /* accounts_obj_id */ ][p1/* sender_address */];
    // }
    // /* reset_make_account_for_sender */
    // function f923(address p1/* sender_address */) public {
    //     num_data.add_int[ 10 /* accounts_obj_id */ ][p1/* sender_address */] = 0;
    // }

    /* run_exchange_transfer_setters */
    // H32.NumData private num_data;
    // function f90(
    //     uint256[][5] calldata p1/* data */,
    //     uint256[] calldata p2/* tokens_to_receive */,
    //     uint256[][][] calldata p3/* exchange_nums */,
    //     uint256 p4/* sender_account */
    // ) public pure returns (uint256[] memory v1/* return_data */) {
    //     uint256[4][][] memory v2/* ints */ = H32.f90(p1/* data */, p2/* tokens_to_receive */, p3/* exchange_nums */, p4/* sender_account */, false);

    //     v1/* return_data */ = new uint256[](101);
    //     uint256 v3/* pos */ = 0;
    //     for (uint256 k = 0; k < v2/* ints */.length; k++) {
    //         for (uint256 e = 0; e < v2/* ints */[k].length; e++) {
    //             for (uint256 l = 0; l < v2/* ints */[k][e].length; l++) {
    //                 v1/* return_data */[v3/* pos */] = v2/* ints */[k][e][l];
    //                 v3/* pos */++;
    //             }
    //         }
    //     }
    // }

    /* get_current_balances */
    // H32.NumData private num_data;
    // function f89(
    //     uint256[][5] calldata p1/* data */,
    //     uint256 p2/* sender_account */
    // ) external view returns (uint256[] memory v3/* return_data */) {
    //     uint256[] memory v1/* current_balances */ = H32.f89(p1/* data */, p2/* sender_account */, num_data);

    //     v3/* return_data */ = new uint256[](101);
    //     uint256 v2/* pos */ = 0;
    //     for (uint256 l = 0; l < v1/* current_balances */.length; l++) {
    //         v3/* return_data */[v2/* pos */] = v1/* current_balances */[l];
    //         v2/* pos */++;
    //     }
    // }

    /* get_consensus_spend_mint_trust_fees */
    // H3.NumData private num_data;
    // function f88(uint256[][][] calldata p1/* target_nums */)
    // external view returns (uint256[] memory v1/* return_data */){
    //     uint256[][][2] memory v2/* ints */ = H3.f88(p1/* target_nums */, num_data);
    //     v1/* return_data */ = new uint256[](101);
    //     uint256 v3/* pos */ = 0;

    //     for (uint256 k = 0; k < v2/* ints */.length; k++) {
    //         for (uint256 e = 0; e < v2/* ints */[k].length; e++) {
    //             for (uint256 l = 0; l < v2/* ints */[k][e].length; l++) {
    //                 v1/* return_data */[v3/* pos */] = v2/* ints */[k][e][l];
    //                 v3/* pos */++;
    //             }
    //         }
    //     }

    // }

    /* get_link_exchange_data */
    // H3.NumData private num_data;
    // function f87(uint256[] calldata p1/* new_parent_exchange_ids */, uint256[] calldata p2/* targets */)
    // external view returns (uint256[] memory v1/* return_data */){
    //     uint256[][][][2] memory v2/* ints */ = H3.f87(p1/* new_parent_exchange_ids */, p2/* targets */, num_data);
    //     v1/* return_data */ = new uint256[](101);
    //     uint256 v3/* pos */ = 0;

    //     for (uint256 r = 0; r < v2/* ints */.length; r++) {
    //         for (uint256 k = 0; k < v2/* ints */[r].length; k++) {
    //             for (uint256 e = 0; e < v2/* ints */[r][k].length; e++) {
    //                 for (uint256 l = 0; l < v2/* ints */[r][k][e].length; l++) {
    //                     v1/* return_data */[v3/* pos */] = v2/* ints */[r][k][e][l];
    //                     v3/* pos */++;
    //                 }
    //             }
    //         }
    //     }

    // }

    /* read_ids/read_id */
    // H3.NumData private num_data;
    // function f86(uint256[] calldata p1/* id_data */, uint256[] calldata p2/* id_depth_data */) 
    // external view returns (uint256[] memory v1/* return_data */){
    //     uint256[][][] memory v2/* ints */ = H3.f86(p1/* id_data */, num_data, p2/* id_depth_data */);
    //     v1/* return_data */ = new uint256[](101);
    //     uint256 v3/* pos */ = 0;

    //     for (uint256 k = 0; k < v2/* ints */.length; k++) {
    //         for (uint256 e = 0; e < v2/* ints */[k].length; e++) {
    //             for (uint256 l = 0; l < v2/* ints */[k][e].length; l++) {
    //                 v1/* return_data */[v3/* pos */] = v2/* ints */[k][e][l];
    //                 v3/* pos */++;
    //             }
    //         }
    //     }

    // }

    /* get_current_exchange_liquidity_values */
    // H3.NumData private num_data;
    // function f84(
    //     uint256[][5] memory p1/* data */
    // ) public view returns (uint256[] memory v1/* return_data */){
    //     uint256[] memory v2/* current_data */ = H3.f84(p1/* data */, num_data);

    //     v1/* return_data */ = new uint256[](101);
    //     uint256 v3/* pos */ = 0;
    //     for (uint256 e = 0; e < v2/* current_data */.length; e++) {
    //         v1/* return_data */[v3/* pos */] = v2/* current_data */[e];
    //         v3/* pos */++;
    //     }
    // }

    /* ensure_type_exchange */
    // H3.NumData private num_data;
    // function f83( uint256[] memory v1/* _ids */ ) public view {
    //     H3.f83(v1/* _ids */, num_data);
    // }

    // /* run_consensus_request_checkers */
    // G3.NumData private num_data;
    // function f82(
    //     uint256 p1/* new_obj_id */,
    //     bool p2/* can_sender_vote_in_main_contract */
    // ) external view returns (uint256 v1/* vote_wait */, uint256 v2/* allow_external_buy_proposals */) {
    //     (v1/* vote_wait */, v2/* allow_external_buy_proposals */) =  G3.f82(num_data, p1/* new_obj_id */, p2/* can_sender_vote_in_main_contract */);
    // }

    /* contract_data_checkers */
    // function f81(
    //     uint256[][] calldata p1/* new_obj_id_nums */,
    //     uint256 p2/* rp */,
    //     uint256[3] calldata p3/* main_contract_data */
    // ) external {
    //     E33.f81(p1/* new_obj_id_nums */[2], p2/* rp */, p3/* main_contract_data */, p1/* new_obj_id_nums */[3]);
    // }

    /* ensure_minimum_amount_for_bounty */
    // function f80(
    //     uint256 p1/* gas_anchor_price */,
    //     uint256 p2/* rp */,
    //     uint256[3] calldata p3/* target_contract_authority_config */,
    //     uint256[][] memory p4/* new_obj_id_num_data */
    // ) external view returns (uint256[] memory v1/* return_data */){
    //     uint256[][5] memory v2/* data */ = E33.f80(p1/* gas_anchor_price */, p2/* rp */, p3/* target_contract_authority_config */, p4/* new_obj_id_num_data */);

    //     v1/* return_data */ = new uint256[](101);
    //     uint256 v3/* pos */ = 0;
    //     for (uint256 k = 0; k < v2/* data */.length; k++) {
    //         for (uint256 e = 0; e < v2/* data */[k].length; e++) {
    //             v1/* return_data */[v3/* pos */] = v2/* data */[k][e];
    //             v3/* pos */++;
    //         }
    //     }
    // }

    /* load_consensus_data */
    // G3.NumData private num_data;
    // function f79(
    //     uint256[] calldata p1/* targets */,
    //     uint256[] calldata p2/* sender_accounts */,
    //     uint256 p3/* single_sender_account */
    // ) external view returns (uint256[] memory v1/* return_data */){
    //     (uint256[][][] memory v2/* target_nums_data */, uint256[][4] memory v3/* bounty_data|voter_weight_exchanges|voter_weight_exchange_depths|sender_accounts */) = G3.f79(p1/* targets */, num_data, p2/* sender_accounts */, p3/* single_sender_account */);
    //     v1/* return_data */ = new uint256[](101);
    //     uint256 v4/* pos */ = 0;

    //     for (uint256 k = 0; k < v2/* target_nums_data */.length; k++) {
    //         for (uint256 e = 0; e < v2/* target_nums_data */[k].length; e++) {
    //             for (uint256 l = 0; l < v2/* target_nums_data */[k][e].length; l++) {
    //                 v1/* return_data */[v4/* pos */] = v2/* target_nums_data */[k][e][l];
    //                 v4/* pos */++;
    //             }
    //         }
    //     }

    //     for (uint256 o = 0; o < v3/* bounty_data */.length; o++) {
    //         for (uint256 p = 0; p < v3/* bounty_data */[o].length; p++) {
    //             v1/* return_data */[v4/* pos */] = v3/* bounty_data */[o][p];
    //             v4/* pos */++;
    //         }
    //     }

    // }

    /* g3_read_ids */
    // G3.NumData private num_data;
    // function f78(uint256[] calldata p1/* id_data */, bool p2/* full_read */) 
    // external view returns (uint256[] memory v1/* return_data */){
    //     uint256[][][] memory v2/* ints */ = G3.f78(p1/* id_data */, num_data, p2/* full_read */);
    //     v1/* return_data */ = new uint256[](401);
    //     uint256 v3/* pos */ = 0;

    //     for (uint256 k = 0; k < v2/* ints */.length; k++) {
    //         for (uint256 e = 0; e < v2/* ints */[k].length; e++) {
    //             for (uint256 l = 0; l < v2/* ints */[k][e].length; l++) {
    //                 v1/* return_data */[v3/* pos */] = v2/* ints */[k][e][l];
    //                 v3/* pos */++;
    //             }
    //         }
    //     }
    // }

    /* start_run_checker */
    // F3.NumData private num_data;
    // function f75(uint256 p1/* obj_id */) public view {
    //     F3.f75(p1/* obj_id */, num_data);
    // }

    /* f3_read_ids */
    // F3.NumData private num_data;
    // function f74( uint256[] calldata p1/* id_data */) external view returns (uint256[] memory v1/* return_data */){
    //     uint256[][][] memory v2/* ints */ = F3.f74(p1/* id_data */, num_data);
    //     v1/* return_data */ = new uint256[](101);
    //     uint256 v3/* pos */ = 0;

    //     for (uint256 k = 0; k < v2/* ints */.length; k++) {
    //         for (uint256 e = 0; e < v2/* ints */[k].length; e++) {
    //             for (uint256 l = 0; l < v2/* ints */[k][e].length; l++) {
    //                 v1/* return_data */[v3/* pos */] = v2/* ints */[k][e][l];
    //                 v3/* pos */++;
    //             }
    //         }
    //     }

    // }

    /* require_subscription */
    // F3.NumData private num_data;
    // function f72(uint256[] memory p1/* _ids */, uint256[][] memory p2/* presets */) public {
    //     for ( uint256 r = 0; r < p2/* presets */.length; r++ ) {
    //         if(p2/* presets */[r][0] == 1){
    //             num_data.num_str_metas[ p2/* presets */[r][1] ][ p2/* presets */[r][2] ][ p2/* presets */[r][3] ] = p2/* presets */[r][4];
    //         }
    //     }
    //     F3.f72(p1/* _ids */, num_data);

    //     for ( uint256 r = 0; r < p2/* presets */.length; r++ ) {
    //         if(p2/* presets */[r][0] == 1){
    //             num_data.num_str_metas[ p2/* presets */[r][1] ][ p2/* presets */[r][2] ][ p2/* presets */[r][3] ] = 0;
    //         }
    //     }
    // }

    /* start_ensure_types */
    // E34.NumData private num_data;
    // function f71(
    //     uint256[2] calldata p1/* types */,
    //     uint256[][5] calldata p2/* target_id_data */,
    //     uint256[][] memory p3/* presets */
    // ) external {
    //     for ( uint256 r = 0; r < p3/* presets */.length; r++ ) {
    //         if(p3/* presets */[r][0] == 1){
    //             num_data.num[ p3/* presets */[r][1] ][p3/* presets */[r][2]][ p3/* presets */[r][3] ] = p3/* presets */[r][4];
    //         }
    //     }

    //     E34.f71(p1/* types */, p2/* target_id_data */, num_data);

    //     for ( uint256 r = 0; r < p3/* presets */.length; r++ ) {
    //         if(p3/* presets */[r][0] == 1){
    //             num_data.num[ p3/* presets */[r][1] ][p3/* presets */[r][2]][ p3/* presets */[r][3] ] = 0;
    //         }
    //     }
    // }

    /* ensure_interactibles */
    // E34.NumData private num_data;
    // function f69(
    //     uint256[] calldata p1/* targets */,
    //     uint256 p2/* sender_acc_id */,
    //     uint256[][] calldata p3/* presets */
    // ) external {
    //     set_preset_data(p3/* presets */);

    //     E34.f69(p1/* targets */, num_data, p2/* sender_acc_id */);

    //     delete_preset_data(p3/* presets */);
    // }

    /* execute_modify_metadata */
    // E34.NumData private num_data;
    // function f68(
    //     uint256[][5] calldata p1/* target_id_data */,
    //     uint256 p2/* sender_acc_id */,
    //     uint256[][] memory p3/* presets */
    // ) external {
    //     for ( uint256 r = 0; r < p3/* presets */.length; r++ ) {
    //         if(p3/* presets */[r][0] == 1){
    //             num_data.num[ p3/* presets */[r][1] ][p3/* presets */[r][2]][ p3/* presets */[r][3] ] = p3/* presets */[r][4];
    //         }
    //         else if(p3/* presets */[r][0] == 2){
    //             num_data.int_int_int[ p3/* presets */[r][1] ][p3/* presets */[r][2]][ p3/* presets */[r][3]] = p3/* presets */[r][4];
    //         }
    //     }
    //     E34.f68(p1/* target_id_data */, num_data, p2/* sender_acc_id */);

    //     for ( uint256 r = 0; r < p3/* presets */.length; r++ ) {
    //         if(p3/* presets */[r][0] == 1){
    //             num_data.num[ p3/* presets */[r][1] ][p3/* presets */[r][2]][ p3/* presets */[r][3] ] = 0;
    //         }
    //         else if(p3/* presets */[r][0] == 2){
    //             num_data.int_int_int[ p3/* presets */[r][1] ][p3/* presets */[r][2]][ p3/* presets */[r][3]] = 0;
    //         }
    //     }
    // }

    /* alias_object_add_data */
    // E34.NumData private num_data;
    // function f67(
    //     uint256[][5] memory p1/* target_id_data */,
    //     bool p2/* can_sender_vote_in_main_contract */,
    //     uint256 p3/* action */,
    //     uint256[2][] memory p4/* presets */
    // ) external {
    //     for ( uint256 r = 0; r < p4/* presets */.length; r++ ) {
    //         num_data.num[ p4/* presets */[r][0] ][0 /* control */][ 0 /* data_type */ ] = p4/* presets */[r][1];
    //     }
    //     E34.f67(p1/* target_id_data */, p2/* can_sender_vote_in_main_contract */, num_data, p3/* action */,0);
    // }

    /* run_token_exchange_checkers */
    // function f66(uint256[][] memory p1/* new_obj_id_num */) external {
    //     E33.f66(p1/* new_obj_id_num */);    
    // }

    // function test(uint256 item, uint256 item2) external pure {
    //     require(item == 53);

    //     if(item2 == 35){
    //         revert();
    //     }
    // }

    // /* run_multiple_exchange_config_checkers */
    // function f64( uint256[][][] memory p1/* exchange_nums */ ) external {
    //     H32.f64(p1/* exchange_nums */);
    // }

    /* get_consensus_buy_spend_data */
    // function f63(
    //     uint256[] calldata p1/* targets */,
    //     uint256[][][] calldata p2/* target_nums */,
    //     uint256[] calldata p3/* target_payers_for_buy_data */,
    //     uint256[][][2] calldata p4/* exchange_trust_fees_data */,
    //     uint256[5] memory p5/* consensus_type_data */
    // ) external pure returns (uint256[] memory v1/* return_data */) {
    //     uint256[][5] memory v2/* data */ = G33.f63(p1/* targets */, p2/* target_nums */, p3/* target_payers_for_buy_data */, p4/* exchange_trust_fees_data */, p5/* consensus_type_data */);

    //     v1/* return_data */ = new uint256[](100);
    //     uint256 v3/* pos */ = 0;
    //     for (uint256 t = 0; t < 5; t++) {
    //         for (uint256 e = 0; e < v2/* data */[t].length; e++) {
    //             v1/* return_data */[v3/* pos */] = v2/* data */[t][e];
    //             v3/* pos */++;
    //         }
    //     }
    // }

    /* get_enter_contract_multi_transfer_data */
    // function f62(
    //     uint256[] calldata p1/* targets */,
    //     uint256[][][] memory p2/* targets_data */,
    //     uint256 p3/* sender_account */,
    //     uint256[] calldata p4/* sender_accounts */
    // ) external view returns (uint256[] memory v1/* return_data */) {
    //     uint256[][5] memory v2/* data */ = G33.f62(p1/* targets */, p2/* targets_data */, p3/* sender_account */, p4/* sender_accounts */);

    //     v1/* return_data */ = new uint256[](100);
    //     uint256 v3/* pos */ = 0;
    //     for (uint256 t = 0; t < 5; t++) {
    //         for (uint256 e = 0; e < v2/* data */[t].length; e++) {
    //             v1/* return_data */[v3/* pos */] = v2/* data */[t][e];
    //             v3/* pos */++;
    //         }
    //     }
    // }

    /* get_consensus_mint_dump_data_get_freeze_unfreeze_data */
    // function f60f61(
    //     uint256[] calldata p1/* targets */,
    //     uint256[][][] calldata p2/* target_nums */,
    //     uint256[21] memory p3,/* consensus_type_data */
    //     uint256 p4/* action */
    // ) public pure returns (uint256[] memory v1/* return_data */) {
    //     (uint256[][6] memory v2/* data */, uint256[][2] memory v5/* buy_sell_limits */) = G33.f60(p1/* targets */, p2/* target_nums */, p3/* consensus_type_data */, p4/* action */);
    //     uint256[][6] memory v3/* data2 */ = G33.f61(p2/* target_nums */, p3/* consensus_type_data */);

    //     v1/* return_data */ = new uint256[](300);
    //     uint256 v4/* pos */ = 0;
        
    //     for (uint256 t = 0; t < 6; t++) {
    //         for (uint256 e = 0; e < v2/* data */[t].length; e++) {
    //             v1/* return_data */[v4/* pos */] = v2/* data */[t][e];
    //             v4/* pos */++;
    //         }
    //     }
    //     for (uint256 t = 0; t < 6; t++) {
    //         for (uint256 e = 0; e < v3/* data2 */[t].length; e++) {
    //             v1/* return_data */[v4/* pos */] = v3/* data2 */[t][e];
    //             v4/* pos */++;
    //         }
    //     }

    //     for (uint256 t = 0; t < 2; t++) {
    //         for (uint256 e = 0; e < v5/* buy_sell_limits */[t].length; e++) {
    //             v1/* return_data */[v4/* pos */] = v5/* buy_sell_limits */[t][e];
    //             v4/* pos */++;
    //         }
    //     }
    // }

    /* get_mult_exchanges_count */
    // function f59(uint256[][][] memory p1/* targets_data */)
    // public pure returns (uint256[] memory v1/* return_data */) {
    //     uint256[][5] memory v2/* data */ = G33.f59(p1/* targets_data */);

    //     v1/* return_data */ = new uint256[](100);
    //     v1/* return_data */[0] = v2/* data */[0].length;
    //     v1/* return_data */[1] = v2/* data */[1].length;
    // }

    /* /* calculate_share_for_buy_spend_consensus */
    // function f58(
    //     uint256 p1/* amount */,
    //     uint256 p2/* proportion */
    // ) public pure returns (uint256[2] memory v1/* return_data */) {
    //     (v1/* return_data */[0/* share */], v1/* return_data */[1/* remaining_amount */]) = G33.f58(p1/* amount */,  p2/* proportion */);
    // }

    // function f56f57(uint256 p1/* size */, uint256 p2/* amount_modifier */, uint256 p3/* action */)
    // public pure returns (uint256[] memory v1/* return_data */) {
    //     uint256[][5] memory v2/* data */ = G33.f57(p1/* size */, p2/* amount_modifier */);
    //     (uint256[][5] memory v3/* data2 */, uint256[][2] memory v5/* buy_sell_limits */) = G33.f56(p1/* size */, p3/* action */);

    //     v1/* return_data */ = new uint256[](100);
    //     uint256 v4/* pos */ = 0;
    //     for (uint256 t = 0; t < 5; t++) {
    //         v1/* return_data */[v4/* pos */] = v2/* data */[t].length;
    //         v4/* pos */++;
    //     }
    //     for (uint256 t = 0; t < 5; t++) {
    //         v1/* return_data */[v4/* pos */] = v3/* data2 */[t].length;
    //         v4/* pos */++;
    //     }
    //     for (uint256 t = 0; t < 2; t++) {
    //         v1/* return_data */[v4/* pos */] = v5/* buy_sell_limits */[t].length;
    //         v4/* pos */++;
    //     }
    // }

    /* get_reconfig_data */
    // function f55(
    //     uint256[] calldata p1/* targets */,
    //     uint256[][][] calldata p2/* target_nums */,
    //     uint256[] calldata p3/* modify_target_types */
    // ) public pure returns (uint256[] memory v1/* return_data */) {
    //     uint256[][5][3] memory v2/* data */ = G33.f55(p1/* targets */, p2/* target_nums */, p3/* modify_target_types */);

    //     v1/* return_data */ = new uint256[](100);
    //     uint256 v3/* pos */ = 0;
    //     for (uint256 t = 0; t < 5; t++) {
    //         for (uint256 e = 0; e < v2/* data */[0][t].length; e++) {
    //             v1/* return_data */[v3/* pos */] = v2/* data */[0][t][e];
    //             v3/* pos */++;
    //         }
    //     }

    //     for (uint256 t = 0; t < 5; t++) {
    //         for (uint256 e = 0; e < v2/* data */[1][t].length; e++) {
    //             v1/* return_data */[v3/* pos */] = v2/* data */[1][t][e];
    //             v3/* pos */++;
    //         }
    //     }

    //     for (uint256 t = 0; t < 5; t++) {
    //         for (uint256 e = 0; e < v2/* data */[2][t].length; e++) {
    //             v1/* return_data */[v3/* pos */] = v2/* data */[2][t][e];
    //             v3/* pos */++;
    //         }
    //     }
    // }

    /* reconfig_data_setup */
    // function f54(
    //     uint256[] calldata p1/* targets */,
    //     uint256[][][] calldata p2/* target_nums */,
    //     uint256[] calldata p3/* modify_target_types */
    // ) public pure returns (uint256[] memory v1/* return_data */) {
    //     uint256[][5][3] memory v2/* data */ = G33.f54(p1/* targets */, p2/* target_nums */, p3/* modify_target_types */);

    //     v1/* return_data */ = new uint256[](100);
    //     uint256 v3/* pos */ = 0;
    //     for (uint256 t = 0; t < 3; t++) {
    //         v1/* return_data */[v3/* pos */] = v2/* data */[t][0].length;
    //         v3/* pos */++;
    //     }
    // }

    /* get_array_group_from_size */
    // function f53(uint256 p1/* size */) public pure returns (uint256[] memory v1/* return_data */) {
    //     uint256[][5] memory v2/* data */ = G33.f53(p1/* size */);

    //     v1/* return_data */ = new uint256[](100);
    //     v1/* return_data */[0] = v2/* data */[0].length;
    //     v1/* return_data */[1] = v2/* data */[1].length;
    //     v1/* return_data */[2] = v2/* data */[2].length;
    //     v1/* return_data */[3] = v2/* data */[3].length;
    //     v1/* return_data */[4] = v2/* data */[4].length;
    // }

    /* fetch_modify_targets */
    // function f52( uint256[][][] memory p1/* target_nums */ )
    // external pure returns (uint256[] memory v1/* return_data */) {
    //     uint256[] memory v2/* modify_target_ids */ = G32.f52(p1/* target_nums */);

    //     v1/* return_data */ = new uint256[](100);
    //     uint256 v3/* pos */ = 0;
    //      for (uint256 t = 0; t < v2/* modify_target_ids */.length; t++) {
    //         v1/* return_data */[v3/* pos */] = v2/* modify_target_ids */[t];
    //         v3/* pos */++;
    //     }
    // }

    /* can_update_main_contract_limit_data */
    // function f51(uint256 target_array_item) public pure returns (bool) {
    //     return G3.f51(target_array_item);
    // }

    /* ensure_minimum_amount */
    // function f50(
    //     uint256[] memory p1/* exchanges */,
    //     uint256[] memory p2/* amounts */,
    //     uint256 p3/* default_minimum_end_amount */,
    //     uint256 p4/* default_minimum_spend_amount */,
    //     uint256 p5/* gas_anchor_price */,
    //     uint256 p6/* transaction_gas_price */,
    //     uint256 p7/* rp */,
    //     bool p11/* absolute_measure */
    // ) public {
    //     E33.f50(p1/* exchanges */, p2/* amounts */, p3/* default_minimum_end_amount */, p4/* default_minimum_spend_amount */, p5/* gas_anchor_price */, p6/* transaction_gas_price */, p7/* rp */, p11/* absolute_measure */);
    // }

    /* get_archive_nested_account_data */
    // function f49(
    //     uint256[][] calldata p1/* t_vals */,
    //     uint256[] calldata p2/* targets */
    // ) external pure returns (uint256[] memory v1/* return_data */) {
    //     uint256[][][3] memory v2/* accounts_exchanges */ = E32.f49(p1/* t_vals */, p2/* targets */);

    //     v1/* return_data */ = new uint256[](100);
    //     uint256 v3/* pos */ = 0;
    //     for (uint256 r = 0; r < v2/* accounts_exchanges */[0/* voter_accounts */].length; r++) {
    //         for (uint256 t = 0; t < v2/* accounts_exchanges */[0/* voter_accounts */][r].length; t++) {
    //             v1/* return_data */[v3/* pos */] = v2/* accounts_exchanges */[0/* voter_accounts */][r][t];
    //             v3/* pos */++;
    //         }
    //     }

    //     for (uint256 r = 0; r < v2/* accounts_exchanges */[1/* balance_exchanges */].length; r++) {
    //         for (uint256 t = 0; t < v2/* accounts_exchanges */[1/* balance_exchanges */][r].length; t++) {
    //             v1/* return_data */[v3/* pos */] = v2/* accounts_exchanges */[1/* balance_exchanges */][r][t];
    //             v3/* pos */++;
    //         }
    //     }

    //     for (uint256 r = 0; r < v2/* accounts_exchanges */[2/* exchange_depths */].length; r++) {
    //         for (uint256 t = 0; t < v2/* accounts_exchanges */[2/* exchange_depths */][r].length; t++) {
    //             v1/* return_data */[v3/* pos */] = v2/* accounts_exchanges */[2/* exchange_depths */][r][t];
    //             v3/* pos */++;
    //         }
    //     }
    // }

    /* recheck_contracts */
    // G3.NumData private num_data;
    // function f47(uint256[][][] memory p1/* contract_nums */, uint256[] memory p2/* targets */) public  {
    //     G3.f47(p1/* contract_nums */, p2/* targets */, num_data);
    // }

    /* get_transfer_data_for_collect_or_pay_subscription_payments */
    // function f46(
    //     uint256[] memory p1/* targets */,
    //     uint256[][][] memory p2/* targets_data */,
    //     uint256[] memory p3/* amounts */,
    //     uint256 p4/* action */,
    //     uint256 p5/* sender */,
    //     uint256[] memory p6/* sender_accounts */
    // ) public pure returns (uint256[] memory v1/* return_data */) {
    //     uint256[][5] memory v2/* data */ = F3.f46(p1/* targets */, p2/* targets_data */, p3/* amounts */, p4/* action */, p5/* sender */, p6/* sender_accounts */);

    //     v1/* return_data */ = new uint256[](100);
    //     uint256 v3/* pos */ = 0;
    //     for (uint256 r = 0; r < v2/* data */.length; r++) {
    //         for (uint256 t = 0; t < v2/* data */[r].length; t++) {
    //             v1/* return_data */[v3/* pos */] = v2/* data */[r][t];
    //             v3/* pos */++;
    //         }
    //     }
    // }

    /* get_mult_exchanges_count */
    // function f45(uint256[][][] memory p1/* targets_data */)
    // public pure returns (uint256[] memory v1/* return_data */) {
    //     uint256[][4] memory v2/* data */ = F3.f45(p1/* targets_data */);

    //     v1/* return_data */ = new uint256[](100);
    //     v1/* return_data */[0] = v2/* data */[0].length;
    //     v1/* return_data */[1] = v2/* data */[1].length;
    //     v1/* return_data */[2] = v2/* data */[2].length;
    //     v1/* return_data */[3] = v2/* data */[3].length;
    // }

    /* run_subscription_checkers */
    // function f43(uint256[][][] memory p1/* subs_data */) public view {
    //     F3.f43(p1/* subs_data */);
    // }

    /* new_val */
    // function f42(uint256 p1/* old_val */) public pure returns (uint256 v1/* val */) {
    //     v1/* val */ = E34.f42(p1/* old_val */);
    // }

    /* can_record_author_owner */
    // function f41(uint256 p1/* object_type */) public pure returns (bool) {
    //     return E34.f41(p1/* object_type */);
    // }

    /* calculate_reduction_proportion_ratios */
    // function f40(
    //     uint256[][][] calldata p1/* exchanges */,
    //     uint256[] calldata p2/* actions */,
    //     uint256 p3/* block_number */
    // ) public pure returns (uint256[] memory v1/* return_data */) {
    //     (uint256[] memory v3/* new_ratios */, uint256[] memory v2/* temp_non_fungible_depth_token_transaction_class_array */) = F33.f40(p1/* exchanges */, p2/* actions */, p3/* block_number */);

    //     v1/* return_data */ = new uint256[](100);
    //     uint256 v5/* pos */ = 0;
    //     for (uint256 r = 0; r < v3/* new_ratios */.length; r++) {
    //         v1/* return_data */[v5/* pos */] = v3/* new_ratios */[r];
    //         v5/* pos */++;
    //     }
    //     for (uint256 r = 0; r < v2/* temp_non_fungible_depth_token_transaction_class_array */.length; r++) {
    //         v1/* return_data */[v5/* pos */] = v2/* temp_non_fungible_depth_token_transaction_class_array */[r];
    //         v5/* pos */++;
    //     }
    // }

    /* calculate_tokens_to_receive */
    // function f39(
    //     uint256[][5] calldata p1/* data */,
    //     uint256[][][] calldata p2/* exchange_nums */,
    //     uint256 p3/* msg_value */,
    //     bool p4/* authority_mint */,
    //     uint256[][2] calldata p5/* buy_sell_limits */
    // ) external pure returns (uint256[] memory v1/* return_data */) {
    //     (uint256[] memory v2/* tokens_to_receive */, uint256[2] memory v3/* external_amount_data */, uint256 v4/* _msg_value */) = E32.f39(p1/* data */, p2/* exchange_nums */, p3/* msg_value */, p4/* authority_mint */, p5/* buy_sell_limits */);

    //     v1/* return_data */ = new uint256[](100);
    //     uint256 v5/* pos */ = 0;
    //     for (uint256 r = 0; r < v2/* tokens_to_receive */.length; r++) {
    //         v1/* return_data */[v5/* pos */] = v2/* tokens_to_receive */[r];
    //         v5/* pos */++;
    //     }
    //     v1/* return_data */[v5/* pos */] = v3/* external_amount_data */[0];
    //     v1/* return_data */[v5/* pos */+1] = v3/* external_amount_data */[1];
    //     v1/* return_data */[v5/* pos */+2] = v4/* _msg_value */;
    // }

    /* calculate_final_tokens_to_receive */
    // function f38(
    //     uint256[][4] memory p1/* tokens_to_receive_data */,
    //     uint256[][5] calldata p2/* data */,
    //     uint256[][][] calldata p3/* exchange_nums */,
    //     bool p4/* authority_mint */,
    //     uint256[] memory p5/* active_mintable_amounts */
    // ) public pure returns (uint256[] memory v1/* return_data */) {
    //     uint256[] memory v2/* tokens_to_receive */ = E32.f38(p1/* tokens_to_receive_data */, p2/* data */, p3/* exchange_nums */, p4/* authority_mint */, p5/* active_mintable_amounts */);

    //     v1/* return_data */ = new uint256[](100);
    //     uint256 v3/* pos */ = 0;
    //     for (uint256 r = 0; r < v2/* tokens_to_receive */.length; r++) {
    //         v1/* return_data */[v3/* pos */] = v2/* tokens_to_receive */[r];
    //         v3/* pos */++;
    //     }
    // }

    /* calculate_tokens_setup */
    // function f37(
    //     uint256[][5] calldata p1/* ex_data */,
    //     uint256[][][] calldata p2/* exchange_nums */,
    //     uint256 p3/* msg_value */,
    //     uint256[] memory p4/* active_mintable_amounts */
    // ) public pure returns (uint256[] memory v1/* return_data */) {
    //     (uint256[][4] memory v2/* data */, uint256 v3/* new_msg_value */) = E32.f37/* calculate_tokens_setup */(p1/* ex_data */, p2/* exchange_nums */, p3/* msg_value */, p4/* active_mintable_amounts */);

    //     v1/* return_data */ = new uint256[](100);
    //     uint256 v4/* pos */ = 0;
    //     for (uint256 r = 0; r < v2/* data */.length; r++) {
    //         for (uint256 t = 0; t < v2/* data */[r].length; t++) {
    //             v1/* return_data */[v4/* pos */] = v2/* data */[r][t];
    //             v4/* pos */++;
    //         }
    //     }
    //     v1/* return_data */[v4/* pos */] = v3/* new_msg_value */;
    // }

    /* get_awward_data */
    // function f36(
    //     uint256[][3] memory p1/* temp_transaction_data_group */,
    //     uint256 p2/* user_acc_id */,
    //     uint256[][][] calldata p3/* _ints */,
    //     address[] calldata p4/* _adds */,
    //     string[][] calldata p5/* _strs */
    // ) public pure returns (uint256[] memory v1/* return_data */) {
    //     E3.TD/* TransactionData */ memory v2/* tx_data */ = E3.TD/* TransactionData */( p2/* user_acc_id */, false/* can_sender_vote_in_main_contract */, p1/* temp_transaction_data_group */[0], p3/* _ints */[0], p4/* _adds */, p5/* _strs */, 0, /* t */ 0, /* new_obj_id */ 500 /* msg.value */, [ 3/* transaction_count */, uint256(5)/* entered_contracts */ ], false );

    //     (uint256[][2] memory v3/* awward_targets_data */, uint256[][5][] memory v4/* awward_transction_data */) = E3.f36/* get_awward_data */(v2/* tx_data */);

    //     v1/* return_data */ = new uint256[](100);
    //     uint256 v5/* pos */ = 0;
    //     for (uint256 r = 0; r < v3/* awward_targets_data */.length; r++) {
    //         for (uint256 t = 0; t < v3/* awward_targets_data */[r].length; t++) {
    //             v1/* return_data */[v5/* pos */] = v3/* awward_targets_data */[r][t];
    //             v5/* pos */++;
    //         }
    //     }
    //     for (uint256 r = 0; r < v4/* awward_transction_data */.length; r++) {
    //         for (uint256 t = 0; t < v4/* awward_transction_data */[r].length; t++) {
    //             for (uint256 s = 0; s < v4/* awward_transction_data */[r][t].length; s++) {
    //                 v1/* return_data */[v5/* pos */] = v4/* awward_transction_data */[r][t][s];
    //                 v5/* pos */++;
    //             }
    //         }
    //     }

    // }

    /* /* get_tokens_to_receive */
    // function f35(
    //     uint256[][] calldata p1/* exchange_nums */,
    //     uint256 p2/* exchange */,
    //     uint256 p3/* amount */,
    //     uint256 p4/* active_mintable_amount */,
    //     uint256 p5/* msg_value */,
    //     uint256 p6/* action_type */
    // ) public pure returns ( uint256[4] memory v5/* return_data */ ) {
    //     (uint256 v1/* factor */, uint256 v2/* ir_parent */, uint256 v3/* or_parent */, uint256 v4/* factor_amount */) = E32.f35/* get_tokens_to_receive */(p1/* exchange_nums */, p2/* exchange */, p3/* amount */, p4/* active_mintable_amount */, p5/* msg_value */, p6/* action_type */);

    //     v5/* return_data */[0] = v1/* factor */;
    //     v5/* return_data */[1] = v2/* ir_parent */;
    //     v5/* return_data */[2] = v3/* or_parent */;
    //     v5/* return_data */[3] = v4/* factor_amount */;
    // }

    /* calculate_active_mintable_amounts */
    // function f34(
    //     uint256[][5] calldata p1/* data */,
    //     uint256[][][] calldata p2/* exchange_nums */
    // ) public pure returns (uint256[] memory v1/* return_data */) {
    //     uint256[] memory v2/* active_mintable_amounts */ = E32.f34/* calculate_active_mintable_amounts */(p1/* data */, p2/* exchange_nums */);

    //     v1/* return_data */ = new uint256[](100);
    //     uint256 v3/* pos */ = 0;
    //     for (uint256 r = 0; r < v2/* active_mintable_amounts */.length; r++) {
    //         v1/* return_data */[v3/* pos */] = v2/* active_mintable_amounts */[r];
    //         v3/* pos */++;
    //     }
    // }

    /* check_for_external_amounts */
    // function f33(
    //     uint256[][][] calldata p1/* exchange_nums */,
    //     uint256[][5] calldata p2/* data */,
    //     uint256[] memory p3/* tokens_to_receive */
    // ) public pure returns (uint256[] memory v1/* return_data */) {
    //     uint256[2] memory v2/* external_amount_data */ = E32.f33/* check_for_external_amounts */(p1/* exchange_nums */, p2/* data */, p3/* tokens_to_receive */);

    //     v1/* return_data */ = new uint256[](100);
    //     v1/* return_data */[0] = v2/* external_amount_data */[0];
    //     v1/* return_data */[1] = v2/* external_amount_data */[1];
    // }

    /* check_if_tokens_exceed_requested_limits */
    // function f32(
    //     uint256[] memory p1/* tokens_to_receive */,
    //     uint256[][2] calldata p2/* buy_sell_limits */
    // ) public {
    //     E32.f32/* check_if_tokens_exceed_requested_limits */(p1/* tokens_to_receive */, p2/* buy_sell_limits */);
    // }

    /* get_new_objects_data */
    // function f31(
    //     uint256[][] calldata p1/* t_vals */,
    //     uint256 p2/* user_acc_id */,
    //     uint256[] calldata p3/* temp_transaction_data */,
    //     uint256 p4/* min_obj_len */
    // ) external pure returns (uint256[] memory v1/* return_data */) {
    //     uint256[][] memory v2/* new_obj_id_nums */ = E32.f31/* get_new_objects_data */(p1/* t_vals */, p2/* user_acc_id */, p3/* temp_transaction_data */, p4/* min_obj_len */);

    //     v1/* return_data */ = new uint256[](100);
    //     uint256 v3/* pos */ = 0;
    //     for (uint256 t = 0; t < v2/* new_obj_id_nums */.length; t++) {
    //         for (uint256 r = 0; r < v2/* new_obj_id_nums */[t].length; r++) {
    //             v1/* return_data */[v3/* pos */] = v2/* new_obj_id_nums */[t][r];
    //             v3/* pos */++;
    //         }
    //     }
    // }

    /* get_nested_account_data */
    // function f30(
    //     uint256[][] calldata p1/* t_vals */,
    //     uint256[] calldata p2/* targets */
    // ) external pure returns (uint256[] memory v1/* return_data */) {
    //     uint256[][] memory v2/* accounts */ = E32.f30(p1/* t_vals */, p2/* targets */, 3);

    //     v1/* return_data */ = new uint256[](100);
    //     uint256 v3/* pos */ = 0;
    //     for (uint256 t = 0; t < v2/* accounts */.length; t++) {
    //         for (uint256 r = 0; r < v2/* accounts */[t].length; r++) {
    //             v1/* return_data */[v3/* pos */] = v2/* accounts */[t][r];
    //             v3/* pos */++;
    //         }
    //     }
    // }

    /* get_submit_consensus_data */
    // function f29(
    //     uint256[][3] memory p1/* temp_transaction_data_group */,
    //     uint256 p2/* user_acc_id */,
    //     uint256[][][] calldata p3/* _ints */,
    //     address[] calldata p4/* _adds */,
    //     string[][] calldata p5/* _strs */
    // ) public pure returns (uint256[] memory v1/* return_data */) {
    //     E3.TD memory v2/* tx_data */ = E3.TD( p2/* user_acc_id */, false/* can_sender_vote_in_main_contract */, p1/* temp_transaction_data_group */[0], p3/* _ints */[0], p4/* _adds */, p5/* _strs */, 0, /* t */ 0, /* new_obj_id */ 500 /* msg.value */, [ 3/* transaction_count */, uint256(5)/* entered_contracts */ ], false );

    //     (uint256[] memory v3/* data */, uint256[][] memory v5/* payer_accounts */, uint256[][][2] memory v6/* target_bounty_exchanges_depth-data */ ) = E3.f29/* get_submit_consensus_data */(v2/* tx_data */);

    //     v1/* return_data */ = new uint256[](100);
    //     uint256 v4/* pos */ = 0;
    //     for (uint256 r = 0; r < v3/* data */.length; r++) {
    //         v1/* return_data */[v4/* pos */] = v3/* data */[r];
    //         v4/* pos */++;
    //     }

    //     for (uint256 r = 0; r < v5/* payer_accounts */.length; r++) {
    //         for (uint256 e = 0; e < v5/* payer_accounts */[r].length; e++) {
    //             v1/* return_data */[v4/* pos */] = v5/* payer_accounts */[r][e];
    //             v4/* pos */++;
    //         }
    //     }


    //     for (uint256 r = 0; r < v6/* target_bounty_exchanges_depth-data */.length; r++) {
    //         for (uint256 e = 0; e < v6/* target_bounty_exchanges_depth-data */[r].length; e++) {
    //             for (uint256 f = 0; f < v6/* target_bounty_exchanges_depth-data */[r][e].length; f++) {
    //                 v1/* return_data */[v4/* pos */] = v6/* target_bounty_exchanges_depth-data */[r][e][f];
    //                 v4/* pos */++;
    //             }
    //         }
    //     }
    // }

    /* get_mint_tokens_data */
    // function f28(
    //     uint256[][3] memory p1/* temp_transaction_data_group */,
    //     uint256 p2/* user_acc_id */,
    //     uint256[][][] calldata p3/* _ints */,
    //     address[] calldata p4/* _adds */,
    //     string[][] calldata p5/* _strs */,
    //     uint256 p6/* action */
    // ) public view returns (uint256[] memory v1/* return_data */) {
    //     E3.TD/* TransactionData */ memory v2/* tx_data */ = E3.TD/* TransactionData */( p2/* user_acc_id */, false/* can_sender_vote_in_main_contract */, p1/* temp_transaction_data_group */[0], p3/* _ints */[0], p4/* _adds */, p5/* _strs */, 0, /* t */ 0, /* new_obj_id */ 500 /* msg.value */, [ 3/* transaction_count */, uint256(5)/* entered_contracts */ ], false, p1/* temp_transaction_data_group */[0] );

    //     (uint256[][6] memory v3/* data2 */, uint256[4] memory v4/* data */, uint256[][2] memory v5/* bounds_data */) = E3.f28/* get_mint_tokens_data */(v2/* tx_data */, p6/* action */ );

    //     v1/* return_data */ = new uint256[](100);
    //     uint256 v6/* pos */ = 0;
    //     for (uint256 t = 0; t < 6; t++) {
    //         for (uint256 r = 0; r < v3/* data2 */[t].length; r++) {
    //             v1/* return_data */[v6/* pos */] = v3/* data2 */[t][r];
    //             v6/* pos */++;
    //         }
    //     }

    //     for (uint256 r = 0; r < v4/* data */.length; r++) {
    //         v1/* return_data */[v6/* pos */] = v4/* data */[r];
    //         v6/* pos */++;
    //     }

    //     for (uint256 t = 0; t < 2; t++) {
    //         for (uint256 r = 0; r < v5/* bounds_data */[t].length; r++) {
    //             v1/* return_data */[v6/* pos */] = v5/* bounds_data */[t][r];
    //             v6/* pos */++;
    //         }
    //     }

    // }

    /* get_token_primary_secondary_target_data */
    // function f23e(
    //     uint256[][3] memory p1/* temp_transaction_data_group */,
    //     uint256 p2/* user_acc_id */,
    //     uint256[][][] calldata p3/* _ints */,
    //     address[] calldata p4/* _adds */,
    //     string[][] calldata p5/* _strs */
    // ) public view returns (uint256[] memory v1/* return_data */) {
    //     E3.TD/* TransactionData */ memory v2/* tx_data */ = E3.TD/* TransactionData */( p2/* user_acc_id */, false/* can_sender_vote_in_main_contract */, p1/* temp_transaction_data_group */[0], p3/* _ints */[0], p4/* _adds */, p5/* _strs */, 0, /* t */ 0, /* new_obj_id */ 0 /* msg.value */, [ 0/* transaction_count */, uint256(0)/* entered_contracts */ ], false ,p1/* temp_transaction_data_group */[0]);

    //     (uint256[][5] memory v3/* target_id_data */, uint256[][5] memory v5/* data */, uint256[][6] memory v6/* data2 */) = E3.f23/* get_token_primary_secondary_target_data */(v2/* tx_data */ );

    //     v1/* return_data */ = new uint256[](100);
    //     uint256 v7/* pos */ = 0;

    //     uint256[][6] memory v12/* exchange_transfer_data */ = E3.f259/* get_exchange_transfer_data */(v2/* tx_data */ );
    //     for (uint256 t = 0; t < 6; t++) {
    //         for (uint256 r = 0; r < v6/* data2 */[t].length; r++) {
    //             require( v6/* data2 */[t][r] == v12/* exchange_transfer_data */[t][r] );
    //             v1/* return_data */[v7/* pos */] = v6/* data2 */[t][r];
    //             v7/* pos */++;
    //         }
    //     }
    // }

    // /* get_token_primary_secondary_target_data */
    // function f23(
    //     uint256[][3] memory p1/* temp_transaction_data_group */,
    //     uint256 p2/* user_acc_id */,
    //     uint256[][][] calldata p3/* _ints */,
    //     address[] calldata p4/* _adds */,
    //     string[][] calldata p5/* _strs */
    // ) public view returns (uint256[] memory v1/* return_data */) {
    //     E3.TD/* TransactionData */ memory v2/* tx_data */ = E3.TD/* TransactionData */( p2/* user_acc_id */, false/* can_sender_vote_in_main_contract */, p1/* temp_transaction_data_group */[0], p3/* _ints */[0], p4/* _adds */, p5/* _strs */, 0, /* t */ 0, /* new_obj_id */ 0 /* msg.value */, [ 0/* transaction_count */, uint256(0)/* entered_contracts */ ], false, p1/* temp_transaction_data_group */[0] );

    //     (uint256[][5] memory v3/* target_id_data */, uint256[][5] memory v5/* data */, uint256[][6] memory v6/* data2 */) = E3.f23/* get_token_primary_secondary_target_data */(v2/* tx_data */ );

    //     v1/* return_data */ = new uint256[](100);
    //     uint256 v7/* pos */ = 0;

    //     uint256[][5] memory v8/* pay_or_cancel_subscription_data */ = E3.f260/* get_pay_or_cancel_subscription_data */(v2/* tx_data */ );

    //     uint256[][5] memory v9/* contract_target_id_data */ = E3.f260/* get_contract_target_id_data */(v2/* tx_data */ );
    //     for (uint256 t = 0; t < 5; t++) {
    //         for (uint256 r = 0; r < v3/* target_id_data */[t].length; r++) {
    //             require( v8/* pay_or_cancel_subscription_data */ [t][r] == v3/* target_id_data */[t][r] && v9/* contract_target_id_data */[t][r] == v3/* target_id_data */[t][r] );
    //             v1/* return_data */[v7/* pos */] = v3/* target_id_data */[t][r];
    //             v7/* pos */++;
    //         }
    //     }
    //     uint256[][5] memory v10/* multi_transfer_data */ = E3.f26/* get_multi_transfer_data */(v2/* tx_data */ );
    //     for (uint256 t = 0; t < 5; t++) {
    //         for (uint256 r = 0; r < v5/* data */[t].length; r++) {
    //             require( v5/* data */[t][r] == v10/* multi_transfer_data */[t][r] );
    //             v1/* return_data */[v7/* pos */] = v5/* data */[t][r];
    //             v7/* pos */++;
    //         }
    //     }
    //     uint256[][6] memory v11/* freeze_unfreeze_data */ = E3.f259/* get_freeze_unfreeze_data */(v2/* tx_data */ );
    //     for (uint256 t = 0; t < 6; t++) {
    //         for (uint256 r = 0; r < v6/* data2 */[t].length; r++) {
    //             require( v6/* data2 */[t][r] == v11/* freeze_unfreeze_data */[t][r] );
    //             v1/* return_data */[v7/* pos */] = v6/* data2 */[t][r];
    //             v7/* pos */++;
    //         }
    //     }
    // }

    /* run_transfers_setup */
    // function f22(
    //     uint256[][3] memory p1/* temp_transaction_data_group */,
    //     uint256[][5] memory p2/* target_id_data */,
    //     uint256 p3/* user_acc_id */,
    //     uint256[][][] calldata p4/* _ints */,
    //     address[][] calldata p5/* _adds */,
    //     string[][][] calldata p6/* _strs */
    // ) public pure returns (uint256[] memory v1/* return_data */) {
    //     E3.TD/* TransactionData */ memory v2/* tx_data */ = E3.TD/* TransactionData */( p3/* user_acc_id */, false/* can_sender_vote_in_main_contract */, p1/* temp_transaction_data_group */[0], p4/* _ints */[0], p5/* _adds */[0], p6/* _strs */[0], 0, /* t */ 0, /* new_obj_id */ 0 /* msg.value */, [ 0/* transaction_count */, uint256(0)/* entered_contracts */ ], false , p1/* temp_transaction_data_group */[0]);

    //     (uint256[][5] memory v3/* data */, uint256[][6] memory v4/* data2 */) = E3.f22/* run_transfers_setup */(v2/* tx_data */, p2/* target_id_data */);

    //     v1/* return_data */ = new uint256[](100);
    //     uint256 v5/* pos */ = 0;
    //     for (uint256 t = 0; t < 5; t++) {
    //         for (uint256 r = 0; r < v3/* data */[t].length; r++) {
    //             v1/* return_data */[v5/* pos */] = v3/* data */[t][r];
    //             v5/* pos */++;
    //         }
    //     }
    //     for (uint256 t = 0; t < 6; t++) {
    //         for (uint256 r = 0; r < v4/* data2 */[t].length; r++) {
    //             v1/* return_data */[v5/* pos */] = v4/* data2 */[t][r];
    //             v5/* pos */++;
    //         }
    //     }
    // }

    /* get_primary_secondary_target_data */
    // function f21(
    //     uint256[][3] memory p1/* temp_transaction_data_group */,
    //     uint256 p2/* user_acc_id */,
    //     uint256[][][] calldata p3/* _ints */,
    //     address[][] calldata p4/* _adds */,
    //     string[][][] calldata p5/* _strs */
    // ) public pure returns (uint256[] memory v1/* data */) {
    //     E3.TD/* TransactionData */ memory v2/* tx_data */ = E3.TD/* TransactionData */( p2/* user_acc_id */, false/* can_sender_vote_in_main_contract */, p1/* temp_transaction_data_group */[0], p3/* _ints */[0], p4/* _adds */[0], p5/* _strs */[0], 0, /* t */ 0, /* new_obj_id */ 0 /* msg.value */, [ 0/* transaction_count */, uint256(0)/* entered_contracts */ ], false , p1/* temp_transaction_data_group */[0]);

    //     uint256[][5] memory v3/* target_id_data */ = E3.f21/* get_primary_secondary_target_data */(v2/* tx_data */);

    //     v1/* data */ = new uint256[](100);
    //     uint256 v4/* pos */ = 0;
    //     for (uint256 t = 0; t < 5; t++) {
    //         for (uint256 r = 0; r < v3/* target_id_data */[t].length; r++) {
    //             v1/* data */[v4/* pos */] = v3/* target_id_data */[t][r];
    //             v4/* pos */++;
    //         }
    //     }
    // }

    /* set_up_temp_transaction_data_group */
    // function f20( uint256[][][] calldata p1/* vals */, uint256 p2/* current_id */ )
    // public pure returns (uint256[] memory v) {
    //     uint256[][2] memory v1/* temp_transaction_data_group */ = E33.f20/* set_up_temp_transaction_data_group */(p1, p2);

    //     v = new uint256[](100);
    //     uint256 v2 = 0;
    //     for (uint256 t = 0; t < v1/* temp_transaction_data_group */[0].length; t++) {
    //         v[v2] = v1/* temp_transaction_data_group */[0][t];
    //         v2++; 
    //     }

    //     for (uint256 t = 0; t < v1/* temp_transaction_data_group */[1].length; t++) {
    //         v[v2] = v1/* temp_transaction_data_group */[1][t];
    //         v2++; 
    //     }
    // }

    /* get_multi_stack_or_real_ids */
    // function f18(
    //     uint256[] memory p1/* ids */,
    //     uint256[] memory p2/* id_types */,
    //     uint256[] memory p3/* temp_transaction_data */,
    //     uint256 p4/* sender_acc_id */
    // ) public view returns (uint256[] memory) {
    //     uint256[] memory v1/* e3_targets */ = E3.f18/* get_multi_stack_or_real_ids */(p1, p2, p3, p4);
    //     uint256[] memory v2/* e32_targets */ = E32.f19/* get_multi_stack_or_real_ids */(p1, p2, p3, p4);

    //     for (uint256 t = 0; t <  v1/* e3_targets */.length; t++) {
    //         require( v1/* e3_targets */[t] == v2/* e32_targets */[t]);
    //     }
    //     return  v1/* e3_targets */;
    // }

    /* get_route */
    // function f17(uint256[] memory p1/* tx_data */) external pure returns (uint256){
    //     return E33.f17/* get_route */(p1/* tx_data */);
    // }

    /* is_e52_work */
    // function f16(uint256 p1/* action */) public pure returns(bool){
    //     return E33.f16(p1/* action */);
    // }

    /* check_if_main_contract_votable_required */
    // function f15(uint256 p1/* object_type */, bool p2/* can_sender_vote_in_main_contract */) external pure {
    //     E32.f15(p1/* object_type */, p2/* can_sender_vote_in_main_contract */);
    // }

    //
    //
    //
    //
    //
    //
    //-----------------------~~~~~~CALCULATE-FUNCTIONS~~~~~~-------------------
    /* calculate_new_increased_active_block_limit_reduction_proportion */
    // function f14(uint256[] memory _ints) public pure returns (uint256) {
    //     return E33.f14(_ints[0/* numerator */], _ints[1/* power */], _ints[2/* block_reset_limit */], _ints[3/* block_limit_reduction_proportion */]);
    // }

    /* calculate_spread_factor_amount */
    // function f13(
    //     uint256 p1/* internal_block_halfing_proportion */,
    //     uint256 p2/* total_minted_for_current_block */,
    //     uint256 p3/* block_limit */,
    //     uint256 p4/* factor_amount */
    // ) public pure returns (uint256) {
    //     return E32.f13(p1, p2, p3, p4);
    // }

    /* get_active_block_limit */
    // function f12(
    //     uint256 p1/* block_limit */,
    //     uint256 p2/* mint_limit */,
    //     uint256 p3/* total_supply */,
    //     uint256 p4/* maturity_limit */
    // ) public pure returns (uint256 v/* active_block_limit */) {
    //     v/* active_block_limit */ = E32.f12(p1, p2, p3, p4);
    // }

    /* calculate_factor */
    // function f10(uint256 p1/* reduction_proportion */,
    //     uint256 p2/* total_minted_for_current_block */,
    //     uint256 p3/* max_block_buyable_amount */
    // ) public pure returns (uint256){
    //     uint256 v = E32.f10(p1, p2, p3);
    //     uint256 v2 = E33.f11(p1, p2, p3);

    //     require(v == v2);
    //     return v;
    // }

    // function f9( uint256 p1/* gas_reduction_proportion */, uint256 p2/* tx_gas_limit */, uint256 p3/* tx_gas_anchor_price */, uint256 p4/* tx_gas_price */, uint256 p5/* tx_gas_lower_limit */ ) public pure returns (uint256 v1/* gas_amount */) {
    //     v1/* gas_amount */ = E33.f9(p1, p2, p3, p4, p5);
    // }

    /* calculate_min_end_or_spend */
    // function f8(uint256[7] memory _ints) public pure returns (uint256) {
    //     uint256 v = G3.f8(_ints);

    //     return v;
    // }

    /* calculate_share_of_total */
    // function f4(uint256 p1, uint256 p2) public pure returns (uint256) {
    //     uint256 v = E32.f4(p1, p2);
    //     uint256 v2 = E33.f5(p1, p2);
    //     uint256 v3 = G3.f6(p1, p2);
    //     uint256 v4 = H3.f7(p1, p2);

    //     require(v == v2 && v2 == v3 && v3 == v4);
    //     return v;
    // }

    /* compound */
    // function f2(uint256 p1, uint256 p2) public pure returns (uint256) {
    //     /*  p1: numb   p2: steps   */
    //     uint256 v1 = E32.f2(p1, p2);
    //     uint256 v2 = E33.f3(p1, p2);

    //     require(v1 == v2);
    //     return v2;
    // }

    /* price */
    // function f1( uint256 p1, uint256 p2, uint256 p3, uint256 p4 ) public pure returns (uint256) {
    //     /* p1: input_amount p2: input_reserve_ratio p3: output_reserve_ratio p4: capped_or_uncapped */
    //     require(E32.f1(p1, p2, p3, p4) == E34.f1(p1, p2, p3, p4));
    //     return E32.f1(p1, p2, p3, p4);
    // }

    function run() public pure returns (uint256) {
        E3.run();
        E32.run();
        E34.run();
        E33.run();
        F3.run();
        F32.run();
        F33.run();
        G3.run();
        G32.run();
        G33.run();
        H3.run();
        H32.run();
        return 44;
    }
}
