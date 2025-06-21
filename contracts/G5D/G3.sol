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

/* ContractsHelperFunctions */
library G3 {

    struct NumData {
        mapping(uint256 => mapping(uint256 => mapping(uint256 => uint256))) num;
        mapping(uint256 => mapping(uint256 => mapping(uint256 => uint256))) num_str_metas;
        mapping(uint256 => mapping(uint256 => mapping(uint256 => uint256))) int_int_int;
    }

    /* boot */
    function f108(
        uint256[][][] calldata p1/* boot_data */,
        uint256[][] calldata p2/* boot_id_data_type_data */,
        NumData storage p3/* self */
    ) external {
        /* sets the main contract data during the booting process */

        for (uint256 t = 0; t < p2/* boot_id_data_type_data */.length; t++) {
            /* for each boot target specified */

            mapping(uint256 => mapping(uint256 => uint256)) storage v1/* obj */ = p3/* self */.num[ p2/* boot_id_data_type_data */[t][0/* id */] ];
            /* initialize a storage mapping variable that points to where the main contract data will be stored */

            if(p2/* boot_id_data_type_data */[t][1/* type */] == 30/* 30(contract_obj_id) */){
                /* if the data type specified is a contract object */

                for (uint256 v = 0; v < p1/* boot_data */[t].length; v++) {
                    /* for each array in the main contract data */

                    for (uint256 r = 0; r < p1/* boot_data */[t][v].length; r++) {
                        /* for each data item in the array in focus */

                        v1/* obj */[v][r] = p1/* boot_data */[t][v][r];
                        /* set the data at the specified position */
                    }
                }
                p3/* self */.num[ p2/* boot_id_data_type_data */[t][0/* id */] ][ 0 /* control */ ][ 0 /* data_type */ ] = 30/* 30(contract_obj_id) */;
                /* record the main contract object as a type contract */
            }
        }
    }//-----TEST_OK-----

    /* record */
    function f109(
        uint256[][] calldata p1/* new_obj_id_num_data */,
        NumData storage p2/* self */,
        uint256 p3/* new_obj_id */,
        uint256 p4/* obj_type */
    ) external {
        /* records a new contract or consensus objects data into storage */

        mapping(uint256 => mapping(uint256 => uint256)) storage v1/* new_obj_id_nums */ = p2/* self */.num[p3/* new_obj_id */];
        /* intialize a storage mapping that points to the new objects location */

        // bool v2/* already_hashed */;

        for (uint256 e = 0; e < p1/* new_obj_id_num_data */.length; e++) {
            /* for each array in the new objects number data specified */

            if((e == 2 || e == 3 || e == 10) && p4/* obj_type */ == 32/* 32(consensus_request) */){
                /* if its a consensus request object, we skip the second, third and eigth array since the bounty data isnt recorded */
            }else{
                // if(p1/* new_obj_id_num_data */[1/* config */][4/* <4>externally_set_data */] != 0 && p4/* obj_type */ == 32/* 32(consensus_request) */ && e >= 4 && e <= 9){
                //     /* if its a consensus object, its externally set data value is set to 1, and the array in focus is one of the consensus' data arrays */

                //     if(!v2/* already_hashed */){
                //         /* if the data has already been hashed and set in the externally_set_data array value */

                //         v1/* new_obj_id_nums */[1/* config */][4/* <4>externally_set_data */] = f288/* hash_data | confirm_unedited_data */(p1/* new_obj_id_num_data */, 0/* hash */, 0);
                //         /* set the extenally_set_data value as the hash value from the has_data function */

                //         v2/* already_hashed */ = true;
                //         /* set the already hashed value to true to avoid repeating action */
                //     }
                // }else{
                for (uint256 v = 0; v < p1/* new_obj_id_num_data */[e].length; v++) {
                    /* for each item in the array in focus */

                    if (p1/* new_obj_id_num_data */[e][v] != 0) {
                        /* if the value is non-zero */
                        
                        v1/* new_obj_id_nums */[e][v] = p1/* new_obj_id_num_data */[e][v];
                        /* record its data in the specified position */
                    }
                }
                // }
            }
        }
        v1/* new_obj_id_nums */[0/* control */][0/* data_type */] = p4/* obj_type */;
        /* record the object type, if its a contract or consensus request */
        
        if(p4/* obj_type */ == 30/* 30(contract_obj_id) */){
            /* if its a contract object */
            
            p2/* self */.num_str_metas[p3/* new_obj_id */][ 1 /* num_data */ ][2] = p1/* new_obj_id_num_data */[2].length;
            /* record the number of exchanges specified for entering the contract */
        }
        else if(p4/* obj_type */ == 32/* 32(consensus_request) */){
            /* if its a consensus object */
            
            p2/* self */.num_str_metas[p3/* new_obj_id */][ 1 /* num_data */ ][4] = p1/* new_obj_id_num_data */[4].length;
            /* record the number of exchanges or targets for the consensus object */
        }
        
    }//-----RETEST_OK-----





    /* check_contract_data */
    function f48( 
        uint256[][] memory p1/* new_obj_id_nums */, 
        uint256 p2/* absolute_proposal_expiry_duration_limit */ 
    ) public view {
        /* checks the new contract configuration */

        require(p1/* new_obj_id_nums */[0][0] == 30/* 30(contract_obj_id) */);
        /* ensures the new object type is a contract object */

        if(p2/* absolute_proposal_expiry_duration_limit */ == 0){
            // p2/* absolute_proposal_expiry_duration_limit */ = 600; /* 10min */
        }

        require( 
            p1/* new_obj_id_nums */[1][ 1 /* default_vote_bounty_split_proportion */ ] <= 10**18 && 
            p1/* new_obj_id_nums */[1][ 8 /* <8>auto_wait_for_all_proposals_for_all_voters(0 if no, 1 if yes) */ ] <= 1 &&
            p1/* new_obj_id_nums */[1][ 28 /* <28>can_modify_contract_as_moderator */ ] <= 1 &&
            p1/* new_obj_id_nums */[1][ 29 /* <29>can_extend_enter_contract_at_any_time */ ] <= 1 &&
            p1/* new_obj_id_nums */[1][ 31 /* <31>allow_external_buy_proposals */ ] <= 1 &&
            p1/* new_obj_id_nums */[1][ 35/* <35>mandatory_voter_weight(0 if no, 1 if yes) */ ] <= 1 &&
            p1/* new_obj_id_nums */[1][ 37/* <37>bounty_limit_type(0 if relative, 1 if absolute) */ ] <= 1 &&
            p1/* new_obj_id_nums */[1][ 38/* <38>contract_force_exit_enabled */ ] <= 1
        );
        /* ensures the bounty split proportion is less than 100% and the auto wait, can modify as moderator, can extend enter contract at any time, allow external buy proposals, mandatory_voter_weight and bounty_limit_type values are 0 or 1 */

        bool v1/* default_proposal_expiry_duration_limit_set */;
        /* initialize a variable to determine if the default proposal expiry duration limt has been set */

        if(p1/* new_obj_id_nums */[1][ 5 /* default_proposal_expiry_duration_limit */ ] != 0){
            /* if a default minimum proposal expiry duration limit has been set */

            require(p1/* new_obj_id_nums */[1][ 5 /* default_proposal_expiry_duration_limit */ ] >= p2/* absolute_proposal_expiry_duration_limit */);
            /* ensure the expiry duration limit for entering a contract is more than the default minimum time duration */

            v1/* default_proposal_expiry_duration_limit_set */ = true;
            /* set the default_proposal_expiry_duration_limit_set value to true since a default limit has been specified in the contracts configuration */
        }


        if(p1/* new_obj_id_nums */[1][15/* <15>contract_expiry_time */] != 0){
            /* if the contract has a set expiry */

            require(p1/* new_obj_id_nums */[1][15/* <15>contract_expiry_time */] >= block.timestamp);
            /* ensure the expiry time is more than now */
        }

        if(p1/* new_obj_id_nums */[1][7/* <7>default_consensus_majority_limit */] != 0){
            /* if a default consensus majority limit is defined for majority consensus contracts */

            require(p1/* new_obj_id_nums */[1][7/* <7>default_consensus_majority_limit */] <= 10**18);
            /* ensure its a valid proportion */
        }

        for ( uint256 t = 0; t < p1/* new_obj_id_nums */[ 5 /* specific_consensus_majority_limit_data */ ].length; t++ ) {
            /* for each consensus majority entry specified */

            require(
                p1/* new_obj_id_nums */[ 5 /* specific_consensus_majority_limit_data */ ][t] <= 10**18 &&
                p1/* new_obj_id_nums */[ 6 /* specific_auto_wait_for_all_proposals_for_all_voters_data */ ][t] <= 1
            );
            /* ensure the consensus majority value is a valid proportion and the auto-wait value is a valid setting */

            if(!v1/* default_proposal_expiry_duration_limit_set */){
                /* if the default proposal expiry duration limit has not been set */

                require(p1/* new_obj_id_nums */[ 9 /* specific_proposal_expiry_duration_limit */ ][t] >= p2/* absolute_proposal_expiry_duration_limit */);
                /* ensure the specific proposal expiry duration limit has been set instead */
            }
        }

    }//-----RETEST_OK-----

    /* run_consensus_request_checkers */
    function f82(
        NumData storage p1/* self */,
        uint256 p2/* new_obj_id */,
        bool p3/* can_sender_vote_in_main_contract */
    ) external view returns (uint256 v4/* vote_wait */, uint256 v5/* allow_external_buy_proposals */) {
        /* runs the consensus request checkers for a new conseusus request object */
        
        mapping(uint256 => mapping(uint256 => uint256)) storage v1/* new_obj_id_nums */ = p1/* self */.num[p2/* new_obj_id */];
        /* intializes a storage mapping that points to the new objects data */

        mapping(uint256 => mapping(uint256 => uint256)) storage v2/* contract_obj */ = p1/* self */.num[ v1/* new_obj_id_nums */[1][ 5 /* target_contract_authority */ ] ];
        /* initializes a storage mapping that points to the new proposals target contract authority */

        uint256 v7/* consensus_type */ = v1/* new_obj_id_nums */[1][ 0 /* consensus_type */ ];

        require(
            v1/* new_obj_id_nums */[0][0] == 32/* 32(consensus_request) */ && 
            v2/* contract_obj */[0][0] == 30/* 30(contract_obj_id) */ &&
            v7/* consensus_type */ <= 20
        );
        /* ensure target contract authority and consensus request object are the correct type and valid consensus type */ 



        uint256 v11/* proposal_expiry_duration_limit */ = v2/* contract_obj */[9/* specific_proposal_expiry_duration_limit */][v7/* consensus_type */];
        /* record the proposal expiry duration limit set in the targeted contract authority based on the consensus type */

        if(v2/* contract_obj */[1][ 5 /* <5>default_proposal_expiry_duration_limit */ ] != 0){
            /* if the default proposal expiry duration limit has been set in the targeted contract authority config */

            v11/* proposal_expiry_duration_limit */ = v2/* contract_obj */[1][ 5 /* <5>default_proposal_expiry_duration_limit */ ];
            /* reset the proposal expiry duration limit as the default limit set in the targeted contract authority config */
        }
        
        require( 
            v1/* new_obj_id_nums */[1][ 1 /* proposal_expiry_time */ ] - block.timestamp >= v11/* proposal_expiry_duration_limit */ && 
            p1/* self */.num_str_metas[ p2/* new_obj_id */ ][1 /* num_data */][4/* reconfig_data_or_exchanges_count */] != 0 && 
            v1/* new_obj_id_nums */[1][ 3 /* <3>consensus_submit_expiry_time */ ] > (v1/* new_obj_id_nums */[1][ 1 /* proposal_expiry_time */ ])
        );
        /* ensures the expiry time exceeds minimum proposal expiry time set in contract authority */


        if(v2/* contract_obj */[1][ 36 /* <36>maximum_proposal_expiry_submit_expiry_time_difference */ ] != 0){
            /* if a maximum proposal expiry submit expiry time difference has been set in the targeted contract authority */

            require((v1/* new_obj_id_nums */[1][ 3 /* <3>consensus_submit_expiry_time */ ] - v1/* new_obj_id_nums */[1][ 1 /* proposal_expiry_time */ ]) < v2/* contract_obj */[1][ 36 /* <36>maximum_proposal_expiry_submit_expiry_time_difference */ ]);
            /* ensure the difference in time between the proposal's submit expiry time and the proposal's expiry time is less than the maximum time difference set in the contract */
        }

        if ( v7/* consensus_type */ == 1 /* reconfig */ ) {
            /* if consensus type is reconfig */

            require( v1/* new_obj_id_nums */[1][ 9 /* modify_target(0 if unused) */ ] != 0 );
            /* ensure modify target has been set */
        }
        
        
        if ( v1/* new_obj_id_nums */[1][ 5 /* target_contract_authority */ ] == 2 /* if its the main_contract */ ) {
            /* if target contract authority is 2(main contract) */
            
            require(p3/* can_sender_vote_in_main_contract */);
            /* ensures sender can vote in main contract  */
        }
        
        uint256 v6/* consensus_type_auto_wait_value_set */ = v2/* contract_obj */[6/* specific_auto_wait_for_all_proposals_for_all_voters_data */][v7/* consensus_type */];

        if(v2/* contract_obj */[1][ 8 /* auto_wait_for_all_proposals_for_all_voters */ ] != 0){
            /* if the default auto_wait setting is turned on in the config */

            v6/* consensus_type_auto_wait_value_set */ = v2/* contract_obj */[1][ 8 /* auto_wait_for_all_proposals_for_all_voters */ ];
            /* set the auto wait setting from the config */
        }

        v4/* vote_wait */ = v6/* consensus_type_auto_wait_value_set */;
        /* initialize the vote wait return variable if the contract being targeted has its auto wait value set to 1 */

        v5/* allow_external_buy_proposals */ = v2/* contract_obj */[1][ 31 /* <31>allow_external_buy_proposals */ ];
        /* set the return allow external buy proposals value to the value set in the contract */



        uint256 v8/* consensus_majority_limit_value */ = v2/* contract_obj */[5/* specific_consensus_majority_limit_data */][v7/* consensus_type */];
        /* initialize a variable to contain the consensus majority limit value set for the specific consensus type */

        if(v2/* contract_obj */[1][ 7 /* <7>default_consensus_majority_limit */ ] != 0){
            /* if the default consensus majority limit value is set in the contract config */

            v8/* consensus_majority_limit_value */ = v2/* contract_obj */[1][ 7 /* <7>default_consensus_majority_limit */ ];
            /* set the default consensus majority limit value set in the contracts config */
        }

        if(v1/* new_obj_id_nums */[1][ 6 /* <6>consensus_majority_target_proportion */ ] != 0){
            /* if a consensus majority target has been defined */

            if(v8/* consensus_majority_limit_value */ != 0){
                /* if the contract authority target has a default consensus majority limit defined */

                require(v1/* new_obj_id_nums */[1][ 6 /* <6>consensus_majority_target_proportion */ ] >= v8/* consensus_majority_limit_value */);
                /* ensure the set consensus target for the new consensus object is greater than or equal to the default consensus majority limit set in the target's contract authority */

            }else{
                /* if the target contract authority doesnt have a default consensus majority limit, then unanimous consensus applies exclusively, so revert */
                revert("");
            }
        }



        uint256 v9/* voter_weight_exchange */ = v2/* contract_obj */[7/* voter_weight_exchange_data */][v7/* consensus_type */];
        /* initialize a variable to contain the voter weight exchange id specified by the contract authority */

        uint256 v10/* voter_weight_exchange_depth */ = v2/* contract_obj */[8/* voter_weight_exchange_depth_data */][v7/* consensus_type */];
        /* initialize a variable to contain the token exchange depth specified by the contract authority */

        if(v2/* contract_obj */[1][33/* <33>default_voter_weight_exchange */] != 0){
            /* use the default voter weight exchange specified instead if set in the contracts config */

            v9/* default_voter_weight_exchange */ = v2/* contract_obj */[1][33/* <33>default_voter_weight_exchange */];
            /* reset the exchange id in the voter_weight_exchange value */

            v10/* default_voter_weight_exchange_depth */ = v2/* contract_obj */[1][34/* <34>default_voter_weight_exchange_depth */];
            /* reset the token depth in the voter_weight_exchange_depth value */
        }

        if(v2/* contract_obj */[1][35/* <35>mandatory_voter_weight(0 if no, 1 if yes) */] == 1){
            /* its mandatory that the proposal contains the voter weight exchange specified in the contract */

            require(v1/* new_obj_id_nums */[1][7/* <7>target_voter_weight_exchange */] == v9/* voter_weight_exchange */ && v1/* new_obj_id_nums */[1][8/* <8>target_voter_weight_exchange_depth */] == v10/* voter_weight_exchange_depth */);
            /* ensure the correct exchange id and depth is specified */

            v4/* vote_wait */ = 0;
            /* reset the vote_wait return value since auto wait feature is disabled by default for proposals using voter weight exchange */
        }
        else{
            /* setting the voter weight exchange value in proposals is optional for the contract */

            if(v1/* new_obj_id_nums */[1][7/* <7>target_voter_weight_exchange */] != 0){
                /* if a voter weight exchange id has been specified for the proposal created */

                require(v1/* new_obj_id_nums */[1][7/* <7>target_voter_weight_exchange */] == v9/* voter_weight_exchange */ && v1/* new_obj_id_nums */[1][8/* <8>target_voter_weight_exchange_depth */] == v10/* voter_weight_exchange_depth */);
                /* ensure the correct exchange id and depth is set. If the contract is not using voter weight exchanges, the values set should be zero */

                v4/* vote_wait */ = 0;
                /* reset the vote_wait return value since auto wait feature is disabled by default for proposals using voter weight exchange */
            }
        }
        
    }//-----RETEST_OK-----





    /* modify_targets */
    function f243(
        uint256[][5] calldata p1/* data */, 
        NumData storage p2/* self */,
        uint256 p3/* action */
    ) external returns(bool v1/* update_main_contract_limit_data */){
        /* action: <14>modify_proposal, <15>modify_contract, <152>modify_contract_from_consensus */

        if(p3/* action */ == 15/* <15>modify_contract */){
            /* if the action is a modify contract action */

            for ( uint256 t = 0; t < p1/* data */[ 0 /* targets */ ].length; t++ ) {
                /* for each targeted contract object */
                
                require(p2/* self */.num[ p1/* data */[ 0 /* targets */ ][t] ][1][28/* <28>can_modify_contract_as_moderator */] == 1/* true */);
                /* ensure the modify contract as moderator value is set to 1, meaning the contract can be modified directly */
            }

            f110/* modify_contract */(p1/* data */, p2/* self */);
            /* call the modify contract function */
        }
        else if(p3/* action */ == 152/* <152>modify_contract_from_consensus */){
            /* if contracts are being modifided from consensus */

            v1/* update_main_contract_limit_data */ = f110/* modify_contract */(p1/* data */, p2/* self */);
            /* call the modify contract function */
        }
        else{
            /* if the action is a modify proposal action */

            f238/* modify_proposal */(p1/* data */, p2/* self */);
            /* call the modify proposal function */
        }
    }//-----RETEST_OK-----

    /* modify_contract */
    function f110(
        uint256[][5] calldata p1/* data */, 
        NumData storage p2/* self */
    ) private returns(bool v1/* update_main_contract_limit_data */) {
        /* data[0] = targets, data[1] = target_array, data[2] = target_array_item, data[3] = new_item */
        /* modifies a given set of contract targets */

        for ( uint256 t = 0; t < p1/* data */[ 0 /* targets */ ].length; t++ ) {
            /* for each targeted contract object */

            mapping(uint256 => mapping(uint256 => uint256)) storage v2/* modify_target_data */ = p2/* self */.num[ p1/* data */[ 0 /* targets */ ][t] ];
            /* initialize a storage mapping that points to the contract's data */

            require(v2/* modify_target_data */[0][0] == 30/* 30(contract_obj_id) */);
            /* ensure target specified is a type contract */

            require(p1/* data */[ 1 /* target_array_pos */ ][t] >= 1);
            //prevent modifying data type array

            if(p1/* data */[ 0 /* targets */ ][t] == 2/* main_contract_obj */){
                /* if the target is the main contract object */
                
                require(p1/* data */[ 1 /* target_array_pos */ ][t] == 1);
                /* require target to be the config array */
            }

            if ( p1/* data */[ 1 /* target_array_pos */ ][t] == 3 || p1/* data */[ 1 /* target_array_pos */ ][t] == 4) {
                /* if the amounts array is being targeted */
                
                require( p1/* data */[ 2 /* target_array_items */ ][t] != 0 );
                /* prevent modifying end/spend entry amount */
            }
            
            if(p1/* data */[ 1 /* target_array_pos */ ][t] == 2){
                //can only add exchange obj
                
                mapping(uint256 => uint256) storage v3/* source_token_count */ = p2/* self */.num_str_metas[ p1/* data */[ 0 /* targets */ ][t] ][ 1 /* num_data */ ];
                /* get the existing number of source tokens used for entering the contract */

                require(p1/* data */[ 2 /* target_array_items */][t] <= v3/* source_token_count */[2/* source_tokens_count */] && p1/* data */[ 2 /* target_array_items */][t] != 0);
                /* ensure the targeted array item is less than or equal to the source token counts, meaning an exchange is being modified or added, except for the first */

                if(p1/* data */[ 2 /* target_array_items */][t] == v3/* source_token_count */[2/* source_tokens_count */]){
                    /* if a new exchange is being added */

                    v3/* source_token_count */[2/* source_tokens_count */] += 1;
                    /* increment the source token value by one since one token has been added */
                }
            }

            v2/* modify_target_data */[ p1/* data */[ 1 /* target_array_pos */ ][t] ][ p1/* data */[ 2 /* target_array_items */ ][t] ] = p1/* data */[ 3 /* new_items */ ][t];
            /* set the new value at the specified mapping position with its new value */

            if ( p1/* data */[ 0 /* targets */ ][t] == 2/* main_contract_obj */) {
                /* if the targeted contract is the main contract */
                
                if ( f51/* can_update_main_contract_limit_data */(p1/* data */[ 2 /* target_array_items */ ][t]) ) {
                    /* if the item being modified is one of specified items thats required by E5 and E52 */
                    
                    v1/* update_main_contract_limit_data */ = true;
                    /* set the update main contract data boolean to true */
                }
            }
        }
        f47/* recheck_contracts */(f78/* read_ids */( p1/* data */[ 0 /* targets */ ], p2/* self */, true), p1/* data */[ 0 /* targets */ ], p2/* self */);
        /* calls the recheck contracts function which ensures specific values are correct or valid */
    }//-----RETEST_OK-----

    /* recheck_contracts */
    function f47( 
        uint256[][][] memory p1/* contract_nums */, 
        uint256[] memory p2/* targets */, 
        NumData storage p3/* self */ 
    ) private view {
        /* checks that the modified contracts are correct or valid */

        uint256 v1/* absolute_proposal_expiry_duration_limit */ = p3/* self */.num[ 2 /* main_contract_obj_id */ ][1][30/* <30>absolute_proposal_expiry_duration_limit */];
        
        for (uint256 t = 0; t < p2/* targets */.length; t++) {
            /* for each targeted contract */
            
            f48/* check_contract_data */(p1/* contract_nums */[t], v1/* absolute_proposal_expiry_duration_limit */);
            /* calls the check contract function which checks and confirms the contracts configuration */
            
            if ( p2/* targets */[t] == 2 /* main_contract_obj */ ) {
                /* if the targeted contract being modified is the main contract */
                
                require( 
                    p1/* contract_nums */[t][1][ 8 /* <8>auto_wait_for_all_proposals_for_all_voters(0 if no, 1 if yes) */ ] == 0 && 
                    p1/* contract_nums */[t][1][15/* <15>contract_expiry_time */] == 0 && 
                    p1/* contract_nums */[t][1][ 6 /* <6>max_enter_contract_duration */ ] == 0 && 
                    p1/* contract_nums */[t][1][7/* <7>default_consensus_majority_limit */] == 0 &&
                    p1/* contract_nums */[t][1][28/* <28>can_modify_contract_as_moderator */] == 0 &&
                    p1/* contract_nums */[t][1][31/* <31>allow_external_buy_proposals */] == 0 &&
                    p1/* contract_nums */[t][1][32/* <32>invite_only_e5 */] <= 1 &&
                    p1/* contract_nums */[t][1][38/* <38>contract_force_exit_enabled */] == 0
                );
                /* ensure the autowait value, the contract expiry, the default consensus majority, max enter contract duration ,contract_force_exit_enabled and the can modify contract as moderator values are set to 0 */
            }
        }
    }//-----RETEST_OK-----

    /* can_update_main_contract_limit_data */
    function f51(uint256 p1/* target_array_item */) private pure returns (bool) {
        /* returns true if the position being modified is a specific item */
        /* 
            <11>tx_gas_limit <12>contract_block_invocation_limit , <13>contract_time_invocation_limit , <14>minimum_entered_private_contracts , <16>tag_indexing_limit, <19>minimum_transaction_count ,
            <24>tx_gas_reduction_proportion , <25>tx_gas_anchor_price , <26>tx_gas_lower_limit, <32>invite_only_e5
        */
        return(
            (p1/* target_array_item */ >= 11 && p1/* target_array_item */ <= 14) || 
            p1/* target_array_item */ == 16 || p1/* target_array_item */ == 19 ||
            (p1/* target_array_item */ >= 24 && p1/* target_array_item */ <= 26) ||
            p1/* target_array_item */ == 32
        );
    }//-----RETEST_OK-----

    /* modify_proposal */
    function f238(
        uint256[][5] calldata p1/* data */, 
        NumData storage p2/* self */
    ) private {
        /* modifies a given set of proposal targets */

        for ( uint256 t = 0; t < p1/* data */[ 0 /* targets */ ].length; t++ ) {
            /* for each targeted proposal object */
            
            mapping(uint256 => mapping(uint256 => uint256)) storage v2/* modify_target_data */ = p2/* self */.num[ p1/* data */[ 0 /* targets */ ][t] ];
            /* initialize a storage mapping that points to the proposal's data */

            require(v2/* modify_target_data */[0][0] == 32/* 32(consensus_request) */);
            /* ensure target specified is a type proposal */

            require(p1/* data */[ 1 /* target_array_pos */ ][t] >= 4 && p1/* data */[ 1 /* target_array_pos */ ][t] <= 9);
            //can only modify proposal data arrays

            uint256 v3/* proposal_contract_authority */ = v2/* modify_target_data */[1/* proposal_config */][5/* <5>target_contract_authority */];
            /* record the contract authority targeted by the proposal */

            uint256 v4/* <27>proposal_modify_expiry_duration_limit */ = p2/* self */.num[v3/* proposal_contract_authority */][1/* contract_config */][27/* <27>proposal_modify_expiry_duration_limit */];
            /* record the proposal modify expiry time */

            uint256 v5/* <1>proposal_expiry_time */ = v2/* modify_target_data */[1/* proposal_config */][1/* <1>proposal_expiry_time */];
            /* record the proposals expiry time */

            require(v4/* <27>proposal_modify_expiry_duration_limit */ != 0 && block.timestamp < (v5/* <1>proposal_expiry_time */ - v4/* <27>proposal_modify_expiry_duration_limit */));
            /* ensure the contract authority has a modify expiry duration limit set and the current time is not within the modify expiry period */

            if(p1/* data */[ 1 /* target_array_pos */ ][t] == 4){
                /* if a target is being modified or added */
                
                mapping(uint256 => uint256) storage v6/* source_token_count */ = p2/* self */.num_str_metas[ p1/* data */[ 0 /* targets */ ][t] ][ 1/* num_data */ ];
                /* get the existing number of targets of the proposal */

                require(p1/* data */[ 2 /* target_array_items */][t] <= v6/* source_token_count */[4/* reconfig_data_or_exchanges_count */]);
                /* ensure the targeted array item is less than or equal to the total number of targets */

                if(p1/* data */[ 2 /* target_array_items */][t] == v6/* source_token_count */[4/* reconfig_data_or_exchanges_count */]){
                    /* if a new target is being added*/

                    v6/* source_token_count */[4/* reconfig_data_or_exchanges_count */] += 1;
                    /* increment the source token value by one since one target is being added */
                }
            }

            v2/* modify_target_data */[ p1/* data */[ 1 /* target_array_pos */ ][t] ][ p1/* data */[ 2 /* target_array_items */ ][t] ] = p1/* data */[ 3 /* new_items */ ][t];
            /* set the new value at the specified mapping position with its new value */
        }
    }//-----TEST_OK-----





    /* archive_proposal_data */
    function f111(
        uint256[] calldata p1/* targets */,
        NumData storage p2/* self */
    ) external returns (uint256[][][] memory v1/* target_data */){
        /* archives or deletes the data stored in a contract or proposal object that has expired */

        v1/* target_data */ = f78/* read_ids */(p1/* targets */, p2/* self */, true);
        /* initializes the return variable as the targets data in storage */

        for (uint256 t = 0; t < p1/* targets */.length; t++) {
            /* for each target in the specified targets array */

            require(p1/* targets */[t] > 1000);
            /* ensure the target is a valid id */

            require(v1/* target_data */[t][0][0] == 32/* 32(consensus_request) */ || v1/* target_data */[t][0][0] == 30/* 30(contract_obj_id) */);
            /* ensure the target is a contract or consensus object */
            
            for (uint256 p = 0; p < v1/* target_data */[t].length; p++) {
                /* for each array inside the targets data */

                for (uint256 i = 0; i < v1/* target_data */[t][p].length; i++) {
                    /* for each item in the array in focus */

                    p2/* self */.num[ p1/* targets */[t] ][p][i] = 0;
                    /* set the value to zero */
                }
            }
            p2/* self */.num_str_metas[p1/* targets */[t]][ 1 /* num_data */ ][2/* source_tokens_count */] = 0;
            /* set the source token count value to zero */
            
            p2/* self */.num_str_metas[p1/* targets */[t]][ 1 /* num_data */ ][4/* reconfig_data_or_exchanges_count */] = 0;
            /* set the reconfig data or exchanges count to zero */
        }
    }//-----TEST_OK-----

    // /* hash_data | confirm_unedited_data */
    // function f288(
    //     uint256[][] memory p1/* target_num_data */,
    //     uint256 p2/* action */,
    //     uint256 p3/* require_hash_value */
    // ) private returns (uint256){
    //     /* hashes data for short storage and confirms supplied proposal data is unchanged */
    //     /* action[0] = hash, action[1] = confirm */

    //     for (uint256 v = 0; v < p1/* target_num_data */.length; v++) {
    //         /* for each array in the supplied proposal data array group */

    //         if(v < 4 || v > 9){
    //             /* if the array in focus is less than four and greater than nine, or the array is not part of the data portion of the proposal */

    //             p1/* target_num_data */[v] = new uint256[](0);
    //             /* set the array as empty since its unneeded */
    //         }
    //     }
        
    //     uint256 v2/* hashed_data */ = uint256(keccak256(abi.encode(p1/* target_num_data */)));
    //     /* hash the final arraygroup and convert the resulting bytes32 value to an unsigned integer */

    //     if(p2/* action */ == 0/* hash */){
    //         /* if the action is to hash the given data */

    //         return v2/* hashed_data */;
    //         /* return the hash value as an integer */
    //     }
    //     else{
    //         /* if the action is to check if the data is unchanged */

    //         require(v2/* hashed_data */ == p3/* require_hash_value */);
    //         /* ensure that the supplied hash value is correct */
    //     }
    // }


    // /* read_ids_with_hash_if_any */
    // function f289(
    //     uint256[] calldata p1/* targets */,
    //     NumData storage p2/* self */,
    //     uint256[][][] calldata p3/* supplied_target_data */
    // ) external returns (uint256[][][] memory v1/* id_data */){
    //     v1/* id_data */ = new uint256[][][](p1/* targets */.length);

    //     for (uint256 v = 0; v < p1/* targets */.length; v++) {
    //         uint256[][] memory v2/* target_data */ = f77/* read_id */(p1/* targets */[v], p2/* self */, false);

    //         if(v2/* target_data */[1/* config */][4/* <4>externally_set_data */] != 0){
                
    //             for (uint256 t = 4; t < 10; t++) {

    //                 v2/* target_data */[t] = p3/* supplied_target_data */[v][t];
    //             }
    //             f288/* hash_data | confirm_unedited_data */(v2/* target_data */, 1/* confirm */, v2/* target_data */[1/* config */][4/* <4>externally_set_data */]);
    //         }

    //         v1/* id_data */[v] = v2/* target_data */;
    //     }
    // }


    /* read_ids */
    function f78(
        uint256[] memory p1/* _ids */, 
        NumData storage p2/* self */,
        bool p3/* full_read */
    ) public view returns (uint256[][][] memory v1/* ints */) {
        /* retuns a three dimentional object containing the data for each target specified */

        v1/* ints */ = new uint256[][][](p1/* _ids */.length);
        /* initialize the return value as a new three dimentional array whose length is the number of targets specified */
        
        for (uint256 r = 0; r < p1/* _ids */.length; r++) {
            /* for each target specified */
            
            v1/* ints */[r] = f77/* read_id */(p1/* _ids */[r], p2/* self */, p3/* full_read */);
            /* set the target's data from the read id function in its specific position */
        }
    }//-----RETEST_OK-----

    /* get_read_data_lengths */
    function f76(
        uint256 p1/* id */, 
        NumData storage p2/* self */,
        bool p3/* full_read */
    ) private view returns (uint256[10] memory v1/* l_data */) {
        /* returns the data length of each array in the object being read */
        
        uint256 v3/* source_tokens_count */ = p2/* self */.num_str_metas[p1/* id */][ 1 /* num_data */ ][2/* source_tokens_count */];
        /* get the source token count used by contract objects to record the number of exchanges used to pay to enter */
        
        uint256 v2/* reconfig_data_or_exchanges_count */ = p2/* self */.num_str_metas[p1/* id */][ 1 /* num_data */ ][4/* reconfig_data_or_exchanges_count */];
        /* gets the reconfig data or exchange count value used by proposal objects */

        v1/* l_data */ = [ 1, 16, v3/* source_tokens_count */, v3/* source_tokens_count */, v2/* reconfig_data_or_exchanges_count */, v2/* reconfig_data_or_exchanges_count */, v2/* reconfig_data_or_exchanges_count */, v2/* reconfig_data_or_exchanges_count */, v2/* reconfig_data_or_exchanges_count */, v2/* reconfig_data_or_exchanges_count */];
        /* initializes return array value with the specified values corresponding to each of the object's (thats being read) array's length */

        if(p2/* self */.num[p1/* id */][0][0] == 30/* contract_obj */){
            /* if the target is a contract object */

            uint256 v4/* optional_data_count */ = p3/* full_read */ ? 21 : 0;

            v1/* l_data */ = [ 1, 41, v3/* source_tokens_count */, v3/* source_tokens_count */, v3/* source_tokens_count */, v4/* optional_data_count */, v4/* optional_data_count */, v4/* optional_data_count */, v4/* optional_data_count */, v4/* optional_data_count */];
            /* reinitializes return array value as a contract array */
        }

    }//-----RETEST_OK-----

    /* read_id */
    function f77(
        uint256 p1/* id */, 
        NumData storage p2/* self */,
        bool p3/* full_read */
    ) public view returns (uint256[][] memory v1/* id_data */) {
        /* reads the id for a specific contract or consensus object */

        uint256[10] memory v2/* read_data */ = f76/* get_read_data_lengths */(p1/* id */, p2/* self */, p3/* full_read */);
        /* gets the length of each array used in reading the data from storage */

        v1/* id_data */ = new uint256[][]( 10 /* data_len */ );
        /* intialize a new two dimentional size is 11 */
        
        mapping(uint256 => mapping(uint256 => uint256)) storage v3/* id_nums */ = p2/* self */.num[p1/* id */];
        /* initialize a storage mapping that points to the object being referenced */

        for ( uint256 s = 0; s < 10; /* data_len */ s++ ) {
            /* for each array thats being read */

            uint256 v4/* items_len */ = v2/* read_data */[s];
            /* set a variable to the corresponding lenght item in the read data array */

            v1/* id_data */[s] = new uint256[](v4);
            /* initialize a new array whose length is the number of items in the array in focus */

            mapping(uint256 => uint256) storage v5/* id_array_nums */ = v3/* id_nums */[s];
            /* initialize a storage mapping that points to the specific array being refered to */

            for (uint256 t = 0; t < v4/* items_len */; t++) {
                /* for each item in the array in focus */

                v1/* id_data */[s][t] = v5/* id_array_nums */[t];
                /* read and record the data in the array */
            }
        }
    }//-----RETEST_OK-----

    
    
    
    
    
    /* load_consensus_data */
    function f79( 
        uint256[] calldata p1/* targets */, 
        NumData storage p2/* self */,
        uint256[] calldata p3/* sender_accounts */,
        uint256 p4/* single_sender_account */
    ) external view returns ( 
        uint256[][][] memory v1/* target_nums_data */, 
        uint256[][4] memory v2/* bounty_data|voter_weight_exchanges|voter_weight_exchange_depths|sender_accounts */ 
    ) {
        /* returns the data stored in specified targets and bounty split proportion data set by the contract */
        
        v1/* target_nums_data */ = f78/* read_ids */(p1/* targets */, p2/* self */, false);
        /* reads and sets the targets data in the return 'target_nums_data' variable */

        v2/* bounty_data */ = [ new uint256[](p1.length), new uint256[](p1.length), new uint256[](p1.length), new uint256[](p1.length) ];
        /* initialize the 'bounty_data|voter_weight_exchanges|voter_weight_exchange_depths|sender_accounts' array with a length of the number of targeted items specified */

        for (uint256 t = 0; t < p1/* targets */.length; t++) {
            /* for each target from the targets specified */

            uint256 v3/* target_contract_authority */ = p2/* self */.num[ p1/* targets */[t] ][1][ 5 /* <5>target_contract_authority  */ ];
            /* get the contract authority of the target proposal */

            v2[0/* bounty_data */][t] = p2/* self */.num[ v3/* target_contract_authority */ ][1][ 1 /* <1>default_vote_bounty_split_proportion (denominator -> 10**18) */ ];
            /* set the bounty split propotion value specified by the proposals contract authority */

            v2[1/* voter_weight_exchanges */][t] = p2/* self */.num[ p1/* targets */[t] ][1][ 7 /* <7>target_voter_weight_exchange */ ];
            /* set the voter weight exhcange specified in the proposal */

            v2[2/* voter_weight_exchange_depths */][t] = p2/* self */.num[ p1/* targets */[t] ][1][ 8 /* <8>target_voter_weight_exchange_depth */ ];
            /* set the voter weight exchange depth value specified in the proposal */

            v2[3/* sender_accounts */][t] = p4/* single_sender_account */ == 0 ? p3/* sender_accounts */[t] : p4/* single_sender_account */;
        }
    }//-----RETEST_OK-----


    

    function run() external pure returns (uint256){
        return 42;
    }

}
