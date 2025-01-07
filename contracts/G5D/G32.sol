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

/* ContractsHelperFunctions2 */
library G32 {

    struct NumData {
        mapping(uint256 => mapping(uint256 => mapping(uint256 => uint256))) num;
        mapping(uint256 => mapping(uint256 => mapping(uint256 => uint256))) num_str_metas;
        mapping(uint256 => mapping(uint256 => mapping(uint256 => uint256))) int_int_int;
    }

    /* execute_enter_contract_work */
    function f112(
        uint256[][5] calldata p1/* targets|expiry|sender_accounts|target_force_exit_accounts|target_authors */,
        uint256 p3/* sender_account */,
        NumData storage p4/* self */,
        uint256[][][] calldata p6/* targets_data */
    ) external {
        /* receives a list of targeted contracts to enter and sets the required data to show that the sender has entered the contract */
        
        for (uint256 t = 0; t < p1/* targets|expiry|sender_accounts|target_force_exit_accounts|target_authors */[0/* targets */].length; t++) {
            /* for each target specified */

            uint256 v2/* sender */ = p3/* sender_account */;
            /* initialize a variable that holds the sender account id */

            if(v2/* sender */ == 0){
                /* if sender_account value is zero, sender is in sender_accounts array */

                v2/* sender */ = p1/* targets|expiry|sender_accounts|target_force_exit_accounts|target_authors */[2/* sender_accounts */][t];
                /* reset the sender value from the sender_accounts array */
            }
            
            mapping(uint256 => mapping(uint256 => uint256)) storage v1/* target_int_int_int */ = p4/* self */.int_int_int[ p1/* targets|expiry|sender_accounts|target_force_exit_accounts|target_authors */[0/* targets */][t]]; 
            /* initialize a storage mapping variable that points to the target */

            require(p1/* targets|expiry|sender_accounts|target_force_exit_accounts|target_authors */[0/* targets */][t] > 1000 && p6/* targets_data */[t][0][0] == 30/* 30(contract_obj_id) */);
            /* ensures the target's id specified is correct, and is type contract */

            require(p1/* targets|expiry|sender_accounts|target_force_exit_accounts|target_authors */[1/* expiry */][t] > block.timestamp);
            /* ensures the sender is entering the contract for a valid period of time */

            // require(v1/* target_int_int_int */[ 2 /* participant_accounts */ ][v2/* sender */] == 0);
            // /* ensures the sender has not entered the contract before */

            require(v1/* target_int_int_int */[ 2 /* participant_accounts */ ][v2/* sender */] < block.timestamp);
            /* ensures the senders time in the contract has expired or non-existent */

            require(p1/* targets|expiry|sender_accounts|target_force_exit_accounts|target_authors */[0/* targets */][t] != v2/* sender */);
            /* ensures a contract cannot enter itself */

            if (p1/* targets|expiry|sender_accounts|target_force_exit_accounts|target_authors */[4/* target_authors */][t] != v2/* sender */ && p6/* targets_data */[t][1][ 6 /* <6>max_enter_contract_duration */ ] != 0) {
                /* if the author of the contract is not the sender and the maximum duration for entering has been defined*/
                
                require(p1/* targets|expiry|sender_accounts|target_force_exit_accounts|target_authors */[1/* expiry */][t] - block.timestamp <= p6/* targets_data */[t][1][ 6 /* <6>max_enter_contract_duration */ ] );
                /* ensure that the sender is entering the contract for a duration not more than the maximum specified by the contract */
            }

            if(p6/* targets_data */[t][1][15/* <15>contract_expiry_time */] != 0 && p1/* targets|expiry|sender_accounts|target_force_exit_accounts|target_authors */[4/* target_authors */][t] != v2/* sender */){
                /* if the contract expiry time has been specified and the author of the contract is not the sender */

                require(p6/* targets_data */[t][1][15/* <15>contract_expiry_time */] > block.timestamp);
                /* ensure the sender is enter is entering before the contract's expiry time */
            }

            v1/* target_int_int_int */[ 2 /* participant_accounts */ ][v2/* sender */] = p1/* targets|expiry|sender_accounts|target_force_exit_accounts|target_authors */[1/* expiry */][t]; 
            // sender can now participate in consensus 
            
            v1/* target_int_int_int */[ 1 /* data */ ][ 1 /* voter_count */ ] += 1; 
            // increment the voter count
        }
    }//-----CHANGED-----

    /* execute_extend_enter_contract_work */
    function f113(
        uint256[][5] calldata p1/* targets|extension|sender_accounts|target_force_exit_accounts */,
        uint256 p3/* sender_account */,
        uint256[][][] calldata p4/* targets_data */,
        NumData storage p5/* self */
    ) external {
        /* used for extending the amount of time in a contract to continue participating in consensus activities */

        for (uint256 t = 0; t < p1/* targets|extension|sender_accounts */[0/* targets */].length; t++) {
            /* for each target contract specified */

            uint256 v2/* sender */ = p3/* sender_account */;
            /* initialize a variable that holds the sender account id */

            if(v2/* sender */ == 0){
                /* if sender_account value is zero, sender is in sender_accounts array */

                v2/* sender */ = p1/* targets|extension|sender_accounts */[2/* sender_accounts */][t];
                /* reset the sender value from the sender_accounts array */
            }

            mapping(uint256 => mapping(uint256 => uint256)) storage v1/* target_int_int_int */ = p5/* self */.int_int_int[p1/* targets|extension|sender_accounts */[0/* targets */][t]];
            /* initialize a storage mapping that points to the target contract */

            require(p1/* targets|extension|sender_accounts */[0/* targets */][t] > 1000 && p4/* targets_data */[t][0][0] == 30/* 30(contract_obj_id) */);
            /* ensures the contract has a valid id and is of type contract */

            if(p4/* targets_data */[t][1][ 29 /* <29>can_extend_enter_contract_at_any_time */ ] == 0){
                /* if the contract restricts participants from extending stay at any time */

                require(v1/* target_int_int_int */[ 2 /* participant_accounts */ ][v2/* sender */] - block.timestamp <= p4/* targets_data */[t][1][ 2 /* <2>max_extend_enter_contract_limit */ ]);
                /* ensures the sender is extending their stay in a contract when its about to expire or within a specified limit */
            }
            
            require(p1/* targets|extension|sender_accounts */[1/* extension */][t] - block.timestamp <= p4/* targets_data */[t][1][ 2 /* <2>max_extend_enter_contract_limit */ ]);
            /* ensures the new expiry time being set is less than or equal to the maximum amount of time that can be entered in the contract */

            v1/* target_int_int_int */[ 2 /* participant_accounts */ ][v2/* sender */] = p1/* targets|extension|sender_accounts */[1/* extension */][t];
            //sender can continue to participate in consensus
        }
    }//-----RETEST_OK-----

    /* execute_exit_contract_work */
    function f114(
        uint256[][5] memory p1/* targets|expiry|sender_accounts|target_force_exit_accounts */,
        uint256 p2/* sender_account */,
        NumData storage p3/* self */,
        uint256[][][] calldata p4/* targets_data */,
        uint256 p5/* action */
    ) external {
        /* used for exiting a contract when sender no longer wishes to participate in consensus activities */

        for (uint256 t = 0; t < p1/* targets|expiry|sender_accounts|target_force_exit_accounts */[0/* targets */].length; t++) {
            /* for each targeted contract */

            uint256 v2/* sender */ = p2/* sender_account */;
            /* initialize a variable that holds the sender account id */

            if(v2/* sender */ == 0){
                /* if sender_account value is zero, sender is in sender_accounts array */

                v2/* sender */ = p1/* targets|expiry|sender_accounts|target_force_exit_accounts */[2/* sender_accounts */][t];
                /* reset the sender value from the sender_accounts array */
            }

            require(p1/* targets|expiry|sender_accounts|target_force_exit_accounts */[0/* targets */][t] > 1000);
            /* ensure the contract id is valid */

            if(p5/* action */ == 18/* <18>contract_force_exit_accounts */){
                /* if the action is a force exit account action */

                require(p4/* targets_data */[t][1/* contract_config */][38/* <38>contract_force_exit_enabled */] == 1);
                /* ensure contract force exit setting is enabled in the contract */

                v2/* sender */ = p1/* targets|expiry|sender_accounts|target_force_exit_accounts */[3/* target_force_exit_accounts */][t];
                /* reset the sender variable to be the force exit account specified */
            }

            mapping(uint256 => mapping(uint256 => uint256)) storage v1/* target_int_int_int */ = p3/* self */.int_int_int[p1/* targets|expiry|sender_accounts|target_force_exit_accounts */[0/* targets */][t]];
            /* initialize a storage mapping that points to the contract targets data */

            require(v1/* target_int_int_int */[ 2 /* participant_accounts */ ][v2/* sender */] != 0);
            /* require that the sender is a participant of the contract */
            
            v1/* target_int_int_int */[ 2 /* participant_accounts */ ][v2/* sender */] = 0; 
            /* resets the sender as no longer participating in the contract */

            v1/* target_int_int_int */[ 1 /* data */ ][ 1 /* voter_count */ ] -= 1;
            /* decrement the votercount */
        }
    }//-----RETEST_OK-----



    /* record_voter_work */
    function f119(
        uint256 p1/* target_contract_id */, 
        uint256 p2/* sender_acc_id */, 
        bool p3/* record_target_payer_for_buy */, 
        uint256 p4/* proposal_id */,
        uint256 p5/* contracts_auto_wait */,
        NumData storage p6/* self */,
        uint256 p7/* allow_external_buy_proposals */
    ) external {
        /* records the voter data for a new contract's proposal object */
        
        mapping(uint256 => uint256) storage v1/* new_obj_id_data */ = p6/* self */.int_int_int[ p4/* proposal_id */ ][ 1 /* data */ ];
        /* initialize a storage mapping that points to the proposal's data */
        
        if ( p1/* target_contract_id */ != 2 /* if its not the main_contract */ ) {
            /* if the conrtact being targeted by the new proposal is not the main contract */

            uint256 v2/* val */ = p6/* self */.int_int_int[ p1/* target_contract_id */ ][ 2 /* participant_accounts */ ][p2/* sender_acc_id */];
            /* initialize a variable that contains how long the sender will be able to participate in the contract or when their time in the contract is set to expire */

            if(p3/* record_target_payer_for_buy */ && p7/* allow_external_buy_proposals */ == 1/* true */){
                /* if the proposal is a buy proposal and the targeted contract allows for proposals sent from non-participants */

            }else{

                require(v2/* val */ != 0 && block.timestamp < v2/* val */);
                /* ensure sender is participant in contract */
            }

            if(p5/* contracts_auto_wait */ != 0){
                /* if the contracts auto wait is set to on or is non-zero or is 1 */

                uint256 v3/* contract_voter_count */ = p6/* self */.int_int_int[ p1/* target_contract_id */ ][ 1 /* data */ ][ 1 /* voter_count */ ];
                /* initialize a variable containing the number of entered voters who can participate in the contract */

                v1/* new_obj_id_data */[ 2 /* vote_wait */ ] = v3/* contract_voter_count */;
                /* set the number of voters who have voted wait to be the number of voters who can participate in the contract  */

                v1/* new_obj_id_data */[ 7 /* <7>auto_waits_set */ ] = v3/* contract_voter_count */;
                /* record the auto vote waits to be the number of contract participants as well */
            }
        }
    }//-----RETEST_OK-----




    /* execute_vote_proposal_checkers */
    function f116(
        uint256[][5] calldata p1/* targets|votes|sender_accounts|voter_weight_exchanges|weight_balances */,
        uint256 p2/* sender_account */,
        bool p4/* can_sender_vote_in_main_contract */,
        uint256[][][] calldata p5/* target_nums_data */,
        NumData storage p6/* self */,
        uint256[][] calldata p7/* target_bounty_exchanges */
    ) external returns (bool[] memory v1/* include_transfers */, bool v2/* transfer_work */){
        /* runs the checkers for voting in a given set of proposals specified */

        for (uint256 t = 0; t < p1/* targets|votes|sender_accounts|voter_weight_exchanges|weight_balances */[0/* targets */].length; t++) {
            /* for each targeted proposal object */

            uint256 v3/* sender */ = p2/* sender_account */;
            /* initialize a variable that holds the sender account id */

            if(v3/* sender */ == 0){
                /* if sender_account value is zero, sender is in sender_accounts array */

                v3/* sender */ = p1/* targets|votes|sender_accounts|voter_weight_exchanges|weight_balances */[2/* sender_accounts */][t];
                /* reset the sender value from the sender_accounts array */
            }
            
            require(p1/* targets|votes|sender_accounts|voter_weight_exchanges|weight_balances */[0/* targets */][t] > 1000 && p5/* target_nums_data */[t][0][0] == 32/* 32(consensus_request) */);
            /* ensure the targeted consensus object is a valid object and is a consensus request object */

            require( block.timestamp <= p5/* target_nums_data */[t][1][ 1 /* <1>proposal_expiry_time */ ] && p1/* targets|votes|sender_accounts|voter_weight_exchanges|weight_balances */[1/* votes */][t] <= 3 && p1/* targets|votes|sender_accounts|voter_weight_exchanges|weight_balances */[1/* votes */][t] >= 1 );
            /* require that the consensus request has not expired and vote number passed is 1, 2 or 3 */
            
            if ( p5/* target_nums_data */[t][1][ 2 /* <2>proposal_expiry_block */ ] != 0 ) {
                /* if the proposal expiry block has been specified or set */

                require( block.number <= p5/* target_nums_data */[t][1][ 2 /* <2>proposal_expiry_block */ ] );
                /* ensure the current block doesnt exceed the specified proposal expiry block */
            }
            if ( p5/* target_nums_data */[t][1][ 5 /* target_contract_authority */ ] == 2 /* main_contract */ ) {
                /* if the targeted contract authority for the proposal is the main contract */

                require(p4/* can_sender_vote_in_main_contract */);
                /* ensure sender can vote in the main contract */
            } else {
                /* if the targeted contract is an ordinary contract */

                require( p6/* self */.int_int_int[ p5/* target_nums_data */[t][1][ 5 /* <5>target_contract_authority  */ ] ][ 2 /* participant_accounts */ ][v3/* sender */] >= block.timestamp );
                /* require that the sender has entered and can participate in consensus requests sent to the targeted contract authority */
            }
        }
        (v1/* include_transfers */,v2/* transfer_work */) = f115/* update_vote_data */(p1/* targets|votes|sender_accounts|voter_weight_exchanges|weight_balances */, p2/* sender_account */, p6/* self */, p7/* target_bounty_exchanges */);
        /* set the return values as the return data from the update vote data function */
    }//-----RETEST_OK-----

    /* update_vote_data */
    function f115(
        uint256[][5] calldata p1/* targets|votes|sender_accounts|voter_weight_exchanges|weight_balances */,
        uint256 p2/* sender_account */,
        NumData storage p4/* self */,
        uint256[][] calldata p5/* target_bounty_exchanges */
    ) private returns (bool[] memory v1/* include_transfers */, bool v2/* transfer_work */) {
        /* updates the vote data for specified consensus targets */

        v1/* include_transfers */ = new bool[](p1/* targets|votes|sender_accounts|voter_weight_exchanges|weight_balances */[0/* targets */].length);
        /* initialize the include transfers return variable with a length being the number of targets specified */

        for (uint256 t = 0; t < p1/* targets|votes|sender_accounts|voter_weight_exchanges|weight_balances */[0/* targets */].length; t++) {
            /* for each consensus target specified */

            uint256 v5/* sender */ = p2/* sender_account */;
            /* initialize a variable that holds the sender account id */

            if(v5/* sender */ == 0){
                /* if sender_account value is zero, sender is in sender_accounts array */

                v5/* sender */ = p1/* targets|votes|sender_accounts|voter_weight_exchanges|weight_balances */[2/* sender_accounts */][t];
                /* reset the sender value from the sender_accounts array */
            }

            mapping(uint256 => mapping(uint256 => uint256)) storage v3/* target_vote_data */ = p4/* self */.int_int_int[ p1/* targets|votes|sender_accounts|weight_balances */[0/* targets */][t] ];
            /* initialize a storage mapping that points to the consensus' accounts vote data */

            uint256 v6/* vote_weight */ = 1;
            /* record the default vote weight to be used as 1 */

            if(p1/* targets|votes|sender_accounts|voter_weight_exchanges|weight_balances */[3/* voter_weight_exchanges */][t] != 0){
                /* if a weight exchange id has been specified, the voter balance is to be used */

                if(p1/* targets|votes|sender_accounts|voter_weight_exchanges|weight_balances */[4/* weight_balances */][t] != 0){
                    /* if the voter has a balance */

                    v6/* vote_weight */ = p1/* targets|votes|sender_accounts|voter_weight_exchanges|weight_balances */[4/* weight_balances */][t];
                    /* set the voter weight value as the balance of the sender */

                    if(v3/* target_vote_data */[4/* account_vote_weights */][v5/* sender */] != 0){
                        /* if the account vote weight has already been recorded */

                        v6/* vote_weight */ = v3/* target_vote_data */[4/* account_vote_weights */][v5/* sender */];
                        /* reset the vote weight to be the account vote weight that was recorded in storage before */
                    }
                }

                v3/* target_vote_data */[4/* account_vote_weights */][v5/* sender */] = v6/* vote_weight */;
                /* record the vote weight for the sender */
            }

            if (v3/* target_vote_data */[ 3 /* account_votes */ ][v5/* sender */] != 0) {
                //if its not the accounts first time voting

                if (v3/* target_vote_data */[ 3 /* account_votes */ ][v5/* sender */] == 1) {
                    /* if the sender previously voted 1(yes) */

                    v3/* target_vote_data */[ 1 /* <1>data */ ][ 3 /* vote_yes */ ] -= v6/* vote_weight */;
                    /* decrement the number of yes votes by one */
                } 
                else if (v3/* target_vote_data */[ 3 /* account_votes */ ][v5/* sender */] == 2) {
                    /* if the sender previously voted wait */

                    v3/* target_vote_data */[ 1 /* <1>data */ ][ 2 /* vote_wait */ ] -= v6/* vote_weight */;
                    /* decrement the number of wait votes by one */
                } 
                else {
                    /* if the sender previously voted no */

                    v3/* target_vote_data */[ 1 /* <1>data */ ][ 4 /* vote_no */ ] -= v6/* vote_weight */;
                    /* decrement the number of no votes by one */
                }
            } else {
                //if its the accounts first time voting

                if ( p5/* target_bounty_exchanges */[t].length != 0 ) {
                    /* if the sender has specified bounty exchanges for the vote */

                    v1/* include_transfers */[t] = true;
                    /* sets the include transfer value to true since the sender should receive bounty for their vote */

                    v2/* transfer_work */ = true;
                    /* sets the transfer work to true since the sender is receiving bounty for their vote */
                }
            }

            if (p1/* targets|votes|sender_accounts|voter_weight_exchanges|weight_balances */[1/* votes */][t] == 1) {
                /* if the sender is voting yes */
                
                v3/* target_vote_data */[ 1 /* <1>data */ ][ 3 /* vote_yes */ ] += v6/* vote_weight */;
                /* increment the yes votes by one */
            } 
            else if (p1/* targets|votes|sender_accounts|voter_weight_exchanges|weight_balances */[1/* votes */][t] == 2) {
                /* if the sender is voting wait */

                v3/* target_vote_data */[ 1 /* <1>data */ ][ 2 /* vote_wait */ ] += v6/* vote_weight */;
                /* increment the wait votes by one */
            } 
            else {
                /* the sender is voting no */
                v3/* target_vote_data */[ 1 /* <1>data */ ][ 4 /* vote_no */ ] += v6/* vote_weight */;
                /* increment the no votes by one */
            }

            if ( v3/* target_vote_data */[ 3 /* account_votes */ ][v5/* sender */] == 0 && v3/* target_vote_data */[ 1 /* <1>data */ ][ 7 /* <7>auto_waits_set */ ] != 0 ) {
                //if its the senders first time voting and auto wait votes were set

                v3/* target_vote_data */[ 1 /* <1>data */ ][ 7 /* <7>auto_waits_set */ ] -= v6/* vote_weight */;
                /* reduce the autowait votes by one */

                v3/* target_vote_data */[ 1 /* <1>data */ ][ 2 /* vote_wait */ ] -= v6/* vote_weight */;
                /* reduce the wait votes by one as well */
            }

            v3/* target_vote_data */[ 3 /* account_votes */ ][v5/* sender */] = p1/* targets|votes|sender_accounts|voter_weight_exchanges|weight_balances */[1/* votes */][t];
            /* record the senders vote */
        }
    }//-----RETEST_OK-----


    


    /* run_all_consensus_checkers */
    function f117(
        uint256[] calldata p1/* targets */,
        uint256[][][] calldata p2/* target_nums_data */,
        NumData storage p3/* self */
    ) external returns (
        uint256[21] memory v2/* consensus_type_data */,
        bool[3] memory v6/* contains_subscription_contract_mod_work */  
    ) {
        /* runs all the checkers to ensure the consensus objects being submitted are unanimous and valid */

        for (uint256 t = 0; t < p1/* targets */.length; t++) {
            /* for each consensus target specified */

            require(p1/* targets */[t] > 1000 && p2/* target_nums_data */[t][0][0] == 32/* 32(consensus_request) */);
            /* ensure the target specified is a valid consensus target and is of type consensus request */

            mapping(uint256 => uint256) storage v3/* target_int_int_int */ = p3/* self */.int_int_int[p1/* targets */[t]][ 1 /* data */ ];
            /* initialise a storage variable that points to the targets data */

            uint256[][] memory v4/* target_nums */ = p2/* target_nums_data */[t];
            /* initialize a target nums variable that holds the consensus objects' data being referred to */

            require( v3/* target_int_int_int */[ 6 /* consumed */ ] == 0 ); 
            //make sure consensus is not cosnumed
            
            v3/* target_int_int_int */[ 6 /* consumed */ ] = 1; 
            //set consensus as consumed
            
            if(v4/* target_nums */[1][6/* <6>consensus_majority_target_proportion */] != 0 && v4/* target_nums */[1][5/* <5>target_contract_authority */] != 2/* main_contract_object */){
                /* a consensus majority target has been set in the proposal. meaning the consensus object is targeting majority instead of unanimous consensus. by default, this doesnt apply for proposals targeting main contract */

                uint256 v5/* vot_yes_proportion */ = f272/* calculate_yes_vote_proportion */(v3/* target_int_int_int */[ 2 /* vote_wait */ ], v3/* target_int_int_int */[ 3 /* vote_yes */ ], v3/* target_int_int_int */[ 4 /* vote_no */ ]);
                /* initialize a variable that contains the proportion of yes votes as a percentage of the total number of votes cast */

                require(v5/* vot_yes_proportion */ >= v4/* target_nums */[1][6/* <6>consensus_majority_target_proportion */]);
                /* ensure the intialized proportion is greater than the set limit in the proposal */
            }else{
                /* a consensus majority target has not been set in the proposal. meaning the consensus object is targeting unanimous consensus */
                
                require( 
                    v3/* target_int_int_int */[ 3 /* vote_yes */ ] > 0 && 
                    v3/* target_int_int_int */[ 4 /* vote_no */ ] == 0 && 
                    v3/* target_int_int_int */[ 2 /* vote_wait */ ] == 0 
                );
                /* make sure its a consensus request, the owner is submitting and consensus is unanimous */
            }
            

            require( 
                block.timestamp >= v4/* target_nums */[1][ 1 /* proposal_expiry_time */ ] && 
                block.timestamp <= v4/* target_nums */[1][ 3 /* consensus_submit_expiry_time */ ] 
            );
            /* required time should pass before consensus is submitted */
            
            if ( v4/* target_nums */[1][ 2 /* proposal_expiry_block */ ] != 0 ) {
                /* if a proposal expiry block has been set */
                
                require( block.number > v4/* target_nums */[1][ 2 /* proposal_expiry_block */ ] );
                /* ensure the block number is greater than the proposal expiry block specified */
            }

            v2/* consensus_type_data */[ v4/* target_nums */[1][ 0 /* consensus_type */ ] ] += v4/* target_nums */[ 4 /* (mint/buy/spend_exchanges_pos) */ ].length;
            /* increment the number associated with the consensus type in the consensus type data varable by the number of exchanges or targets being interacted with */
        }

        v6/* contains_subscription_contract_mod_work */ = f264/* get_contains_subscription_contract_mod_work */(v2/* consensus_type_data */);
    }//-----RETEST_OK-----

    /* calculate_yes_vote_proportion */
    function f272(
        uint256 p1/* total_wait */, 
        uint256 p2/* total_yes */, 
        uint256 p3/* total_no */
    ) private pure returns(uint256){
        /* calculates the percentage of yes from the total */

        if(p2/* total_yes */ > 10**36){
            /* if the yes amount specified is large */
            return p2/* total_yes */ / ((p1/* total_wait */ + p2/* total_yes */ + p3/* total_no */)/10**18);
        }
        else{
            return (p2/* total_yes */ * 10**18) / (p1/* total_wait */ + p2/* total_yes */ + p3/* total_no */);
        }
    }//-----TEST_OK-----

    /* get_contains_subscription_contract_mod_work */
    function f264(uint256[21] memory v1/* consensus_type_data */) 
    private pure returns(bool[3] memory v3/* contains_subscription_contract_work */){
        /* checks if the submitted consensus objects contains subscription, contract or moderator work */

        for ( uint256 r = 8; r < v1/* consensus_type_data */.length; r++ ) {
            /* for each action group starting from type 8 */

            if(r >= 8 && r <= 10 && v1/* consensus_type_data */[r] != 0){
                /* if one of the actions involves the a subscription */

                v3/* get_contains_subscription_contract_mod_work */[0/* subscriptions */] = true;
                /* set the contains subscription value to true */
            }
            else if(r >= 11 && r <= 15 && v1/* consensus_type_data */[r] != 0){
                /* if one of the actions involves a contract */

                v3/* get_contains_subscription_contract_mod_work */[1/* contracts */] = true;
                /* set the contains contract value to true */
            }
            else if(r >= 16 && r <= 20 && v1/* consensus_type_data */[r] != 0){
                /* if one of the actions involves a moderator action */

                v3/* get_contains_subscription_contract_mod_work */[2/* moderator */] = true;
                /* set the contains moderator action value to true */
            }
        }

    }//-----TEST_OK-----




    /* archive_data */
    function f118(
        uint256[] calldata p1/* targets */,
        uint256[][][] calldata p2/* target_data */,
        NumData storage p3/* self */,
        uint256[][][3] calldata p4/* accounts_exchanges_depths */
    ) external returns (bool v1/* includes_transfers */) {
        /* deletes data stored in multiple contract or consensus objects. The action is called archiving. */

        for (uint256 t = 0; t < p1/* targets */.length; t++) {
            /* for each consensus or contract target specified */

            require(p1/* targets */[t] > 1000);
            /* ensure the target supplied as valid */

            if(p2/* target_data */[t][0][0] == 32/* 32(consensus_request) */){
                /* if the target is a consensus request object */

                require(block.timestamp > p2/* target_data */[t][1][ 3 /* consensus_submit_expiry_time */ ] + 3180);
                /* required time should pass before consensus is submitted */

                mapping(uint256 => uint256) storage v2/* target_vote_data */ = p3/* self */.int_int_int[ p1/* targets */[t] ][ 3 /* account_votes */ ];
                /* initialise a storage variable that points to the account vote data */

                mapping(uint256 => uint256) storage v3/* target_data_int_int_int */ = p3/* self */.int_int_int[ p1/* targets */[t] ][ 1 /* <1>data */ ];
                /* initialize a storage variable that points to the general consensus data */

                for (uint256 v = 0; v < p4/* accounts_exchanges_depths */[0/* voter_accounts */][t].length; v++) {
                    /* for each voter who has voted in the consensus object */

                    v2/* target_vote_data */[p4/* accounts_exchanges_depths */[0/* voter_accounts */][t][v]] = 0;
                    /* reset their vote back to zero */

                    p3/* self */.int_int_int[ p1/* targets */[t] ][4/* account_vote_weights */][p4/* accounts_exchanges_depths */[0/* voter_accounts */][t][v]] = 0;
                    /* reset their recorded vote weight back to zero */
                }
                uint8[4] memory v4/* data */ = [ 3, /* vote_yes */ 2, /* vote_wait */ 4, /* vote_no */ 7 /* <7>auto_waits_set */ ];
                /* initialise a data array containing the vote ids used */

                for (uint256 d = 0; d < v4/* data */.length; d++) {
                    /* for each item in the data array variable specified above */

                    v3/* target_data_int_int_int */[d] = 0;
                    /* set the data item to zero as well */
                }
            }
            else if(p2/* target_data */[t][0][0] == 30/* 30(contract_obj_id) */){
                /* if the target is a contract object */
                require(
                    p2/* target_data */[t][1][15/* <15>contract_expiry_time */] != 0 && 
                    p2/* target_data */[t][1][15/* <15>contract_expiry_time */] < block.timestamp
                );
                /* ensure the contract has a set expiry time and the time is less than the current timestamp */
                
                mapping(uint256 => mapping(uint256 => uint256)) storage v5/* target_int_int_int */ = p3/* self */.int_int_int[ p1/* targets */[t] ];
                /* initialize a storage mapping variable that points to the contract target's data */
                
                for (uint256 v = 0; v < p4/* accounts_exchanges_depths */[0/* voter_accounts */][t].length; v++) {
                    /* for each voter who is part of the contract or has entered the contract, specified by the sender */

                    v5/* target_int_int_int */[ 2 /* participant_accounts */ ][ p4/* accounts_exchanges_depths */[0/* voter_accounts */][t][v] ] = 0;
                    /* set the account that has enterd the contract back to zero */ 
                }
                v5/* target_int_int_int */[ 1 /* data */ ][ 1 /* voter_count */ ] = 0; 
                /* set the voter count back to zero */
            }
            else{
                /* revert since the target is not a contract or a consensus request object */
                revert("");
            }
            
            if ( p4/* accounts_exchanges */[1/* balance_exchanges */][t].length != 0 ) {
                /* if sender has specified exchanges for the target to be transfered to their account */
                
                v1/* includes_transfers */ = true;
                /* set the includes transfers value to be true since the target's account will transfer tokens to the sender's account */
            }
            
        }
    }//-----RETEST_OK-----







    /* get_total_consensus_data(0) | contract_voter_count_data(2) | account_entry_expiry_time(3) | entry_time_to_expiry(4) | total_consensus_data_as_percentages(5) */
    function f266(
        uint256[] memory p1/* consensus_targets */, 
        uint256[][] calldata p2/* voter_accounts */, 
        uint256 p3/* action */,
        NumData storage p4/* self */
    ) external view returns(uint256[][] memory v1/* data */){
        /* 
            action 0: total_consensus_data, 
            action 2: contract_voter_count_data_count,
            action 3: account_entry_expiry_time
            action 4: entry_time_to_expiry 
            action 5: total_consensus_data_as_percentages
        */

        if(p3/* action */ == 0 || p3/* action */ == 2){
            /* if the action is to fetch the total consensus data or the number of voters in multiple consensus targets  */
            v1/* data */ = f236/* get_total_consensus_data */(p1/* consensus_targets */, p4/* self */, p3/* action */);
        }

        else if(p3/* action */ == 3 || p3/* action */ == 4){
            /* if the action is to get the entry expiry times set by accounts entering specified contracts */
            v1/* data */ = f269/* get_account_entry_expiry_time */(p1/* consensus_targets */, p2/* voter_accounts */, p4/* self */, p3/* action */);
        }
    }//-----TEST_OK-----

    /* get_total_consensus_data */
    function f236(
        uint256[] memory p1/* consensus_targets */, 
        NumData storage p2/* self */,
        uint256 p3/* action */
    ) private view returns(uint256[][] memory v1/* total_vote_data */){
        /* returns the yes, no and wait data for each consensus object specified. order being [wait, yes, no]. to get the total number of votes cast, just sum the three. */
        
        v1/* total_vote_data */ = new uint256[][](p1.length);
        /* initialize the return variable as a new array with the number of targets as its length */

        for (uint256 t = 0; t < p1/* consensus_targets */.length; t++) {
            /* for each id target passed */

            mapping(uint256 => uint256) storage v2/* target_data_int_int_int */ = p2/* self */.int_int_int[ p1/* consensus_targets */[t] ][ 1 /* <1>data */ ];
            /* initialize a storage mapping that points to the consensus' total votes data */

            uint256 v4/* size */ = p3/* action */ == 2 ? 1 : 3;

            uint256[] memory v3/* vote_data */ = new uint256[](v4/* size */ );

            if(p3/* action */ == 0){
                /* if the action is to record the total vote data */

                v3/* vote_data */[0] = v2/* target_data_int_int_int */[ 2 /* vote_wait */ ];
                v3/* vote_data */[1] = v2/* target_data_int_int_int */[ 3 /* vote_yes */ ];
                v3/* vote_data */[2] = v2/* target_data_int_int_int */[ 4 /* vote_no */ ];
            }
            else if(p3/* action */ == 2){
                /* if the action is to record the number of voters */

                v3/* vote_data */[0] = v2/* target_data_int_int_int */[1 /* voter_count */];
                /* record the number of voters in the voter count data array created */
            } 

            v1/* total_vote_data */[t] = v3/* vote_data */;
            /* set the vote data in the return value */
        }
    }//-----RETEST_OK-----
    
    
    /* get_account_entry_expiry_time | entry_time_to_expiry */
    function f269(
        uint256[] memory p1/* contract_targets */, 
        uint256[][] calldata p2/* voter_accounts */, 
        NumData storage p3/* self */,
        uint256 p4/* action */
    ) private view returns(uint256[][] memory v1/* vote_data */){
        /* returns the expiry time or time left before expiry for a given set of accounts in a given set of targeted contracts */

        v1/* total_vote_data */ = new uint256[][](p1.length);
        /* initialize the return variable as a new array with the number of targets as its length */

        for (uint256 t = 0; t < p1/* contract_targets */.length; t++) {
            /* for each id target passed */

            uint256 v2/* number_of_accounts */ = p2/* voter_accounts */[t].length;
            /* record the number of accounts specified for the specific target proposal */

            uint256[] memory v3/* account_expiry_data */ = new uint256[](v2);
            /* initialize a new array to contain the account expiry times */

            for (uint256 a = 0; a < p2/* voter_accounts */[t].length; a++) {
                /* for each account passed */

                uint256 v4/* set_expiry_time */ = p3/* self */.int_int_int[ p1/* contract_targets */[t] ][ 2 /* participant_accounts */ ][ p2/* voter_accounts */[t][a] ];

                if(p4/* action */ == 3/* account_entry_expiry_time */){
                    /* if the action specified is to se the exact expiry time */

                    v3/* account_expiry_data */[a] = v4/* set_expiry_time */;
                    /* set the expiry time recorded when entering the contract */
                }
                else{
                    /* the action is to calculate the time left before expiry */

                    if(v4/* set_expiry_time */ < block.timestamp){
                        /* if the accounts entry expiry time has already passed */

                        v3/* account_expiry_data */[a] = 0;
                    }
                    else{
                        /* if the expiry time is in the future */

                        v3/* account_expiry_data */[a] = v4/* set_expiry_time */ - block.timestamp;
                        /* set the difference between the entry expiry time and current time */
                    }
                }
            }

            v1/* total_vote_data */[t] = v3/* account_expiry_data */;
            /* set the entry expiry data in the return value */
        }
    }//-----TEST_OK-----





    function run() external pure returns (uint256){
        return 42;
    }

}
