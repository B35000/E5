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

/* E5HelperFunctions3 */
library E33 {

    struct NumData {
        mapping(uint256 => uint256) pending_withdrawals;
        mapping(uint256 => mapping(address => uint256)) add_int;
        mapping(uint256 => mapping(uint256 => address)) int_add;
        mapping(uint256 => mapping(uint256 => mapping(uint256 => uint256))) num;
        mapping(uint256 => mapping(uint256 => mapping(uint256 => uint256))) int_int_int;
        mapping(uint256 => mapping(uint256 => mapping(uint256 => uint256))) num_str_metas;
    }

    /* calculate_max_consumable_gas */
    function f9(
        uint256 p1/* gas_reduction_proportion */,
        uint256 p2/* tx_gas_limit */,
        uint256 p3/* tx_gas_anchor_price */,
        uint256 p4/* tx_gas_price */,
        uint256 p5/* tx_gas_lower_limit */
    ) private pure returns (uint256 v1/* gas_amount */) { 
        /* it: calculates the maximum amount of gas that can be consumed given a transaction's gaslimit */

        v1/* gas_amount */ = p2/* tx_gas_limit */;
        /* sets the default return value as the transaction gas limit passed as an argument */

        if (p1/* gas_reduction_proportion */ != 0 && p1/* gas_reduction_proportion */ <= 10**18 && p4/* tx_gas_price */ != 0 && p3/* tx_gas_anchor_price */ != 0 && p2/* tx_gas_limit */ != 0) {
            /* if the gas_reduction_proportion is a defined percentage, the transaction gas price, the gas anchor price and gas_limit are defined */
            /* 
                eg. if tx_gas_price = 80 and tx_gas_anchor_price = 20
                    then steps = 80 ÷ 20 = 6
             */
            uint256 v2/* steps */ = (p4/* tx_gas_price */ / p3/* tx_gas_anchor_price */);
            /* initialize a variable thats the transactions gas price divided by the anchor price */

            if (v2/* steps */ != 0) {
                /* 
                    eg. if tx_gas_limit = 1000 and steps = 3 and p1 gas_reduction_proportion = 50% 
                        x = 50% -> 0.5^3 = 0.125 -> 12.5%
                        then the gas amoount = 12.5% of 1000 = 125
                 */
                v1/* gas_amount */ = f5/* calculate_share_of_total */(p2/* tx_gas_limit */, f3/* compound */(p1/* gas_reduction_proportion */, v2/* steps */));
            }
            if (p4/* tx_gas_price */ % p3/* tx_gas_anchor_price */ != 0) {
                /* calculate remainder */
                uint256 v3/* rem */ = p4/* tx_gas_price */ % p3/* tx_gas_anchor_price */;
                uint256 v4/* rem_as_proportion */ = (v3/* rem */ * 10**18) / p3/* tx_gas_anchor_price */;
                /* 
                    as in (1Gwei / 20Gwei) of 100% = 5%
                */
                uint256 v5/* next_step_gas_reduction_amount */ = v1/* gas_amount */ - f5/* calculate_share_of_total */(v1/* gas_amount */, p1/* gas_reduction_proportion */);
                /* 
                    eg. 3,000,000 is reduced to 2,700,000 if the gas_reduction_proportion = 90%
                    therefore, the next_step_gas_reduction_amount is 3,000,000 - 2,700,000 = 300,000
                */
                v1/* gas_amount */ -= f5/* calculate_share_of_total */(v5/* next_step_gas_reduction_amount */, v4/* rem_as_proportion */);
                /* 
                    then if the gas_amount == 3,000,000 => 3,000,000 - (5% of 300,000)
                    which gives 2,985,000
                */
            }
            if (v1/* gas_amount */ < p5/* tx_gas_lower_limit */) {
                /* if the gas amount calculated is lower than the lower gas limit, set the lower amount */
                v1/* gas_amount */ = p5/* tx_gas_lower_limit */;
            }
        }
    }//-----TEST_OK-----

    /* calculate_share_of_total */
    function f5(uint256 p1, uint256 p2) private pure returns (uint256) {
        /* p1: amount   p2: proportion */
        /* 
            it: calculates a proportion of a given amount
                eg. 50% of 4000 = 2000
                    10% of 250 = 25
        */
        if (p1 /* p1: amount */ == 0 || p2 /* p2: proportion */ == 0) return 0;
        
        return p1 /* p1: amount */ > 10**36
                ? (p1 /* p1: amount */ / 10**18) * p2 /* p2: proportion */ /* (denominator -> 10**18) */
                : (p1 /* p1: amount */ * p2 /* p2: proportion */) / 10**18; /* (denominator -> 10**18) */
        /* prevents an overflow incase the amount is large */
    } //-----TEST_OK-----

    /* compound */
    function f3(uint256 p1/* p1: numb  */, uint256 p2/* p2: steps */) 
    public pure returns (uint256 v1/* val */) {
        /*  p1: numb 
            p2: steps 
            v1: val
        */
        /* 
            it: compounds a given propotion by itself
                eg. 90% -> 1 step
                    90% -> 2 steps => 90% of 90% = 81%
                    90% -> 3 steps => 90% of (90% of 90%) = 72.9%
        */
        v1 /* v1: val */ = p1/* p1: numb  */;
        /* set the return value as the proportion argument */

        require(p1/* p1: numb  */ <= 10**18);
        /* ensure the supplied proportion is a proportion */

        if (p2/* p2: steps */ > 1) {
            /* if the number of steps is more than one */

            for (uint256 t = 0; t < p2/* p2: steps */ - 1; t++) {
                /* for each number of steps required */

                v1/* v1: val */ = (v1/* v1: val */ * p1/* p1: numb  */) / 10**18; /* (denominator -> 10**18) */
            }
        }
        if(v1/* v1: val */ == 0 && p1/* p1: numb  */ != 0){
            /* if the compounded steps caused the proprtion to be compounded down to zero, set it as 1 */
            v1/* v1: val */ = 1;
        }
    }//-----TEST_OK-----





    /* account_transaction_check */
    function f95(
        uint256 p1/* tx_gas */, 
        NumData storage p2/* self */, 
        uint256 p3/* new_id */,
        uint256[][][] calldata p4/* vals */,
        uint256 p5/* current_id */
    ) external returns ( 
        uint256 v1/* user_account_id */, 
        bool v2/* can_sender_vote_in_main_contract */, 
        uint256[][2] memory v3/* temp_transaction_data|route_data */
    ) {
        mapping(uint256 => uint256) storage v4/* main_contract_num */ = p2/* self */.num[ 2 /* main_contract_obj_id */ ][1];
        /* initialize a storage mapping that points to the main contract's configuration */

        uint256 v8/* tx_gas_limit */ = v4/* main_contract_num */[ 11 /* <11>tx_gas_limit */ ];

        if(v8/* tx_gas_limit */ == 0){
            v8/* tx_gas_limit */ = block.gaslimit;
        }

        if(v4/* main_contract_num */[ 26 /* <26>tx_gas_lower_limit */ ] != 0){
            /* if the transaction gas lower limit is set, the gas limit can be calculated */

            uint256 v5/* gas_lim */ = f9/* calculate_max_consumable_gas */( v4/* main_contract_num */[ 24 /* <24>gas_reduction_proportion */ ], v8/* tx_gas_limit */, v4/* main_contract_num */[ 25 /* <25>tx_gas_anchor_price */ ], tx.gasprice, v4/* main_contract_num */[ 26 /* <26>tx_gas_lower_limit */ ] );
            /* calculate the gas limit value and store it in a variable */

            require(p1/* tx_gas */ <= v5/* gas_lim */);
            /* ensure the sender is not overpaying for their transaction. */
        }

        mapping(address => uint256) storage v6/* accounts_add_int */ = p2/* self */.add_int[ 10 /* accounts_obj_id */ ];
        /* initialize a storage mapping that points to the senders account number on E5 */

        if (v6/* accounts_add_int */[msg.sender] == 0) {
            /* if the sender is a new sender or has not interacted with e before */

            p2/* self */.add_int[ 10 /* accounts_obj_id */ ][msg.sender] = p3/* new_id */; 
            //sender does not have an account, create one for them to record last transaction block and time

            p2/* self */.int_add[ 10 /* accounts_obj_id */ ][p3/* new_id */] = msg.sender;
            //record their address in the corresponding account id set
        }
        v1/* user_account_id */ = v6/* accounts_add_int */[msg.sender];
        /* set the return value as the senders account */

        mapping(uint256 => uint256) storage v7/* account_int_int */ = p2/* self */.int_int_int[ v1/* user_account_id */ ][ 1 /* data */ ];
        /* initalize a storage mapping that points to the accounts transactions data */

        require( 
            v7/* account_int_int */[ 1 /* last_transaction_block */ ] + v4/* main_contract_num */[ 12 /* <12>contract_block_invocation_limit*/ ] <= block.number && 
            v7/* account_int_int */[ 2 /* last_transaction_time */ ] + v4/* main_contract_num */[ 13 /* <13>contract_time_invocation_limit */ ] <= block.timestamp 
        );
        //sender has not interacted within the restricted time and block limit

        //record last post block and timestamp
        v7/* account_int_int */[ 1 /* last_transaction_block */ ] = block.number;
        v7/* account_int_int */[ 2 /* last_transaction_time */ ] = block.timestamp;

        if ( v7/* account_int_int */[ 4 /* entered_contracts */ ] >= v4/* main_contract_num */[ 14 /* minimum_entered_contracts */ ] && v7/* account_int_int */[ 3 /* transaction_count */ ] >= v4/* main_contract_num */[ 19 /* minimum_transaction_count */ ] ) {
            /* if the sender has made the required number of transactions and entered the required number of contracts by the main contract, they can interact with the main contract */
            v2/* can_sender_vote_in_main_contract */ = true;
        }

        (v3/* temp_transaction_data|route_data */) = f20/* set_up_temp_transaction_data_group */(p4/* vals */, p5/* current_id */);
        /* set up the transaction data group from the int data passed from the arguments */

        if(v4/* main_contract_num */[ 39 /* primary_tx_account */ ] != 0 && v4/* main_contract_num */[ 40 /* primary_account_tx_period */ ] != 0 && v1/* user_account_id */ != v4/* main_contract_num */[ 39 /* primary_tx_account */ ]){
            /* if the primary transaction account and primary account transaction period have been set, and the sender is not the primary transaction account */

            require(block.timestamp - p2/* self */.int_int_int[ v4/* main_contract_num */[ 39 /* primary_tx_account */ ] ][ 1 /* data */ ][ 2 /* last_transaction_time */ ] < v4/* main_contract_num */[ 40 /* primary_account_tx_period */ ]); 
            /* check to ensure the primary transaction account has run a transaction within the set primary account transaction period */
        }
    }//-----RETEST_OK-----

    /* set_up_temp_transaction_data_group */
    function f20( uint256[][][] calldata p1/* vals */, uint256 p2/* current_id */ ) 
    private pure returns (uint256[][2] memory v1/* temp_transaction_data|route_data */) {
        /* sets up the transaction data used in the transaction data struct object */
        v1/* temp_transaction_data|route_data */ = [new uint256[](p1.length), new uint256[](p1.length)];

        /* initialize a two dimentional array containing three arrays whose length is the number of transactions in the stack */

        uint256 v2/* future_id */ = p2/* current_id */;
        /* initialize a future id variable that starts at the current id in E5 */

        for (uint256 t = 0; t < p1/* vals */.length; t++) {
            /* for each transaction in the transaction data struct */

            if ( p1/* vals */[t][0][0] == 10000 /* entity contructor */ ) {
                /* if were creating a new entity */

                v2/* future_id */++; 
                /* increment the future id value */

                v1/* temp_transaction_data|route_data */[0][t] = v2/* future_id */;
                /* set the new id in the temp transaction data group. this will be the id for the new value created in our transaction stack */
            }
            else{
                /* if its a moderator or token transaction action */

                v1/* temp_transaction_data|route_data */[1][t] = f17/* get_route */(p1/* vals */[t][0]);
                /* fetch and record the route to be used in the routes array */
            }
        }

    }//-----RETEST_OK-----




    /* update_main_contract_limit_data */
    function f93(
        uint256[] calldata p1/* new_main_contract_config */,
        NumData storage p2/* self */
    ) external {
        /* updates the main contract configuration data used in the E5 contract */
        /* 
            <11>tx_gas_limit <12>contract_block_invocation_limit , <13>contract_time_invocation_limit , <14>minimum_entered_private_contracts,  <16>tag_indexing_limit  , <19>minimum_transaction_count
            <24>tx_gas_reduction_proportion , <25>tx_gas_anchor_price , <26>tx_gas_lower_limit , <32>invite_only_e5
            <39>primary_tx_account, <40>primary_account_tx_period
        */
        uint256[12] memory v1/* pos_used */ = [ uint256(11), 12, 13, 14, 16, 19, 24, 25, 26, 32, 39, 40 ];
        /* initialize an array containing the values that are used in the E5 contract */

        for (uint256 t = 0; t < v1/* pos_used */.length; t++) { 
            /* for each of the values in the array initialized above */

            p2/* self */.num[ 2 /* main_contract_obj_id */ ][1][ v1/* pos_used */[t] ] = p1/* new_main_contract_config */[ v1/* pos_used */[t] ]; 
            /* set and update the configuration value */
        }
    }//-----RETEST_OK-----



    /* get_pending_withdraw_balance | get_accounts */
    function f167(
        uint256[] calldata p1/* _ids */, 
        address[] calldata p2/* addresses */, 
        uint256 p3/* action */, 
        NumData storage p4/* self */
    ) external view returns(uint256[] memory){
        /* function used to get an accounts pending withdraw balance, its account number from its addres or just scanning the int_int_int datastore */

        if(p3/* action */ == 1){
            /* scanning the pending_withdraw_balance */
            return f142(p1/* accounts */, p4/* self */);
        }
        else if(p3/* action */ == 2){
            /* scanning the  get_accounts */
            return f166(p2/* addresses */, p4/* self */);
        }
        else{
            return new uint256[](0);
        }
    }//-----TEST_OK-----

    /* pending_withdraw_balance */
    function f142(uint256[] calldata p1/* accounts */, NumData storage p2/* self */) 
    private view returns(uint256[] memory v1/* data */) {
        /* returns the pending withdraw balance for a given set of accounts */

        v1/* data */ = new uint256[](p1.length);
        /* initialize the return variable as a new array whose length is the number of targets */

        for ( uint256 r = 0; r < p1/* accounts */.length; r++ ) {
            /* for each account specified */

            v1/* data */[r] = p2/* self */.pending_withdrawals[ p1/* accounts */[r] ];
            /* scan and set its data in the return array */
        }
    }//-----TEST_OK-----

    /* get_accounts */
    function f166(address[] calldata p1/* addresses */, NumData storage p2/* self */) 
    private view returns(uint256[] memory v1/* data */) {
        /* returns the account ids associated with a given set of addresses */

        v1/* data */ = new uint256[](p1.length);
        /* initialize the return object as a new array whose length is the number of addresses specified */

        for (uint256 t = 0; t < p1/* addresses */.length; t++) {
            /* for each address specified */

            v1/* data */[t] = p2/* self */.add_int[ 10 /* accounts_obj_id */ ][p1/* addresses */[t]];
            /* scan and set the account associated with the address in the return array */
        }
    }//-----TEST_OK-----




    /* get_last_transaction_block & last_transaction_time & entered_contracts_count & transaction_count_data */
    function f287(uint256[] calldata p1/* accounts */, NumData storage p2/* self */) 
    external view returns (uint256[4][] memory v1/* data */) {
        /* scans and returns the last_transaction_block, last_transaction_time, entered_contracts_count and transaction_count_data for a specified set of users */
        /* 
            data[t][0] = last_transaction_block
            data[t][1] = last_transaction_time
            data[t][2] = entered_contracts_count
            data[t][3] = transaction_count_data
        */

        v1/* data */ = new uint256[4][](p1.length);
        /* initialize the return variable as a new array whose length is the number of ids specified */

        for (uint256 t = 0; t < p1/* accounts */.length; t++) {
            /* for each id specified */

            mapping(uint256 => uint256) storage v2/* account_int_int */ = p2/* self */.int_int_int[ p1/* accounts */[t] ][ 1 /* data */ ];
            /* initalize a storage mapping that points to the accounts transactions data */

            v1/* data */[t] = [
                v2/* account_int_int */[ 1 /* last_transaction_block */ ],
                v2/* account_int_int */[ 2 /* last_transaction_time */ ],
                v2/* account_int_int */[ 4 /* entered_contracts */ ],
                v2/* account_int_int */[ 3 /* transaction_count */ ]
            ];
        }
    }//-----TEST_OK-----

    /* calculate_max_consumable_gas */
    function f280(uint256[] calldata p1/* gas_prices */, NumData storage p2/* self */)
    external view returns (uint256[] memory v1/* consumable_gas_limits */){
        /* calculates the maximum consumable gas from the limits set in the main contract object */

        mapping(uint256 => uint256) storage v4/* main_contract_num */ = p2/* self */.num[ 2 /* main_contract_obj_id */ ][1];
        /* initialize a storage mapping that points to the main contract's configuration */

        uint256[4] memory v2/* main_contract_data */ = [ 
            v4/* main_contract_num */[ 24 /* <24>gas_reduction_proportion */ ], 
            v4/* main_contract_num */[ 11 /* <11>tx_gas_limit */ ], 
            v4/* main_contract_num */[ 25 /* <25>tx_gas_anchor_price */ ], 
            v4/* main_contract_num */[ 26 /* <26>tx_gas_lower_limit */ ] 
        ];

        if(v2/* main_contract_data */[1/* tx_gas_limit */] == 0){
            v2/* main_contract_data */[1/* tx_gas_limit */] = block.gaslimit;
        }

        if(v2/* main_contract_data */[3/* tx_gas_lower_limit */] == 0){
            v2/* main_contract_data */[3/* tx_gas_lower_limit */] = block.gaslimit;
        }

        v1/* consumable_gas_limits */ = new uint256[](p1.length);
        /* initalize the return variable as a new array with the specified length */

        for (uint256 t = 0; t < p1/* gas_prices */.length; t++) {
            /* for each price specified */

            v1/* consumable_gas_limits */[t] = f9/* calculate_max_consumable_gas */( 
                v2/* main_contract_data */[ 0 /* <24>gas_reduction_proportion */ ], 
                v2/* main_contract_data */[ 1 /* <11>tx_gas_limit */ ], 
                v2/* main_contract_data */[ 2 /* <25>tx_gas_anchor_price */ ], 
                p1/* gas_prices */[t], 
                v2/* main_contract_data */[ 3 /* <26>tx_gas_lower_limit */ ] 
            );
            /* calculate the gas limit value and store it in the return variable */
        }
    }//-----TEST_OK-----




    /* get_route */
    function f17(uint256[] calldata p1/* tx_data */) private pure returns (uint256 val){
        /* gets route id for routing transactions to their respective contracts */

        uint256 v1/* general_action */ = p1/* tx_data */[0];
        /* initializes the general action for each transaction, 20000 or 30000 */

        uint256 v2/* action */ = p1/* tx_data */[1 /* action */];
        /* initializes the specific action for each transaction */

        if(v1/* general_action */ == 20000 /* mod_work */){
            /* if a mod action is being performed */

            if(f16/* is_e52_work */(v2/* action */)){
                /* if the action is for the E52 contract */
                val = 552;
            }
            else if(v2/* action */ == 11 /* <11>modify_subscription */){
                /* if the action is for the F5 contract */
                val = 65;
            }
            else if(v2/* action */ == 3 /* <3>modify_token_exchange */){
                /* if the action is for the H5 contract */
                val = 85;
            }
            else if(v2/* action */ == 14/* <14>modify_proposal */){
                /* if the action is for the G5 contract */
                val = 75;
            }
            else if(v2/* action */ == 15/* <15>modify_contract */){
                /* if the action is for the G5 contract */
                val = 75;
            }
            else{
                /* revert all other actions specified */
                revert("");
            }
        }
        else if(v1/* general_action */ == 30000 /* token_transaction_work */){
            /* if the action is a token transaction action */

            if(v2/* action */ == 2 ||  v2/* action */ == 12 ||  v2/* action */ == 13 ){
                /* if the action involves the F5 contract */
                /* <2>pay_subscription  <12>cancel_subscription  <13>collect_subscriptions */
                val = 65;
            }
            else if(v2/* action */ == 5 /* 5>submit_consensus_request */){
                /* if the action involves the G5 contract */
                val = 75;
            }
            else if(v2/* action */ == 3  || v2/* action */ == 14  || v2/* action */ == 4  || v2/* action */ == 11  || v2/* action */ == 15 || v2/* action */ == 18){
                /* if the action involves the G52 contract */
                /* <3>enter_contract  <14>execute_extend_enter_contract_work  <4>vote_proposal  <11>exit_contract <15>archive_proposals  <18>contract_force_exit_accounts */
                val = 752;
            }
            else if(v2/* action */ == 9  || v2/* action */ == 8 || v2/* <17>exchange_transfer */ == 17){
                /* if the action involves the H5 contract */
                /* <9>auth_mint <8>buy_tokens/sell_tokens <17>exchange_transfer */
                val = 85;
            }
            else if(v2/* action */ == 1 || v2/* action */ == 6 || v2/* action */ == 7 || v2/* action */ == 16){
                /* if the action involves the H52 contract */
                /* <1>send_from_my_account <6>freeze_tokens/unfreeze_tokens <7>send_awwards <16>stack_depth_action */
                val = 852;
            }
            else{
                /* revert all other transaction actions specified */
                revert("");
            }

        }
        else{
            /* revert all other general actions */
            revert("");
        }
    }//-----RETEST_OK-----

    /* is_e52_work */
    function f16(uint256 p1/* action */) private pure returns(bool){
        /* returns true if the action is meant for the E52 contract */
        return (p1/* action */ == 1 || p1/* action */ == 2 || p1/* action */ == 4 || p1/* action */ == 5 || p1/* action */ == 10 || p1/* action */ == 12 || p1/* action */ == 13 || p1/* action */ == 16 || p1/* action */ == 17);
        /* <1>modify_metadata <2>add_interactible account <4>modify_moderator_accounts <5>enable/disable_interactible_checkers  <10>alias_objects  <12>record_entity_in_tag  <13>add_data  <16>revoke_author_privelages <17>block_accounts */ 
    }//-----RETEST_OK-----





    //
    //
    //
    //
    //
    //
    // ------------------------TOKEN-FUNCTIONS-------------------------------
    // /* calculate_reduction_proportion_ratios */
    // function f40(
    //     uint256[][][] calldata p1/* exchanges */,
    //     uint256[] calldata p2/* actions */,
    //     uint256 p3/* block_number */
    // ) external pure returns (uint256[] memory v1/* new_ratios */) {
    //     /* calculates the new proportion value used in calculating the mint limit */

    //     v1/* new_ratios */ = new uint256[](p1.length);
    //     /* initialize a new array to hold the new values */

    //     for (uint256 t = 0; t < p1/* exchanges */.length; t++) {
    //         /* for each exchange in the targeted exchanges specified by the sender */

    //         uint256[][] memory v2/* exchange */ = p1/* exchanges */[t];
    //         /* get the exchanges data and store it in memory */

    //         v1/* new_ratios */[t] = v2/* exchange */[2][ 6 /* <6>active_block_limit_reduction_proportion*/ ];
    //         /* set the default new ratio as the current one  */

    //         if ( v2/* exchange */[0][3/* exchange_type */] == 5 && /* type_uncapped_supply */ v2/* exchange */[1][1/* block_limit */] != 0 ) {
    //             /* if the exchange type is a uncapped token and its block limit is specified */

    //             if ( p2/* actions */[t] == 0 && /* buy? */ p3/* block_number */ - v2/* exchange */[2][ 5 /* <5>active_mint_block */ ] >= 1 ) {
    //                 /* if the action is a buy action and were in a new block */

    //                 if ( v2/* exchange */[2][ 4 /* <4>total_minted_for_current_block */ ] > v2/* exchange */[1][ 1 /* <1>max_block_buyable_amount */ ] ) {
    //                     /* if limit has been exceeded, reduce [2]<6>active_block_limit_reduction_proportion value by  [1]<6>block_limit_reduction_proportion */

    //                     uint256 v3/* block_limit_sensitivity */ = v2/* exchange */[1][ 12 /* <12>block_limit_sensitivity */ ];
    //                     /* initialize a variable that contains the block limit sensitivity */

    //                     if (v3/* block_limit_sensitivity */ == 0) {
    //                         v3/* block_limit_sensitivity */ = 1;
    //                     }
    //                     /* if the sensitivity value is undefined, set it to one */

    //                     uint256 v4/* factor */ = f11/* calculate_factor */( v2/* exchange */[1][ 5 /* <5>internal_block_halfing_proportion */ ], v2/* exchange */[2][ 4 /* <4>total_minted_for_current_block */ ], v2/* exchange */[1][ 1 /* <1>max_block_buyable_amount */ ] );
    //                     /* calculate the factor value used to calculate the new proportion and mint limit */

    //                     if(v4/* factor */ != 0){
    //                         /* if the factor derived is non-zero */

    //                         uint256 v5/* new_proportion */ = f5/* calculate_share_of_total */( v2/* exchange */[2][ 6 /* <6>active_block_limit_reduction_proportion */ ], f3/* compound */( v2/* exchange */[1][ 6 /* <6>block_limit_reduction_proportion */ ], v4/* factor */ * v3/* block_limit_sensitivity */ ) );
    //                         /* calculate the new proportion as a compounded share of the active block limit reduction value(<6>active_block_limit_reduction_proportion) */

    //                         v1/* new_ratios */[t] = v5/* new_proportion */  == 0 ? 1 : v5/* new_proportion */ ;
    //                         /* if the calculated value is zero, set it to one instead */
    //                     }

    //                     if ( p3/* block_number */ - v2/* exchange */[2][ 5 /* <5>active_mint_block */ ] > 1 ) {
    //                         /* limit was exceeded in a block before the previous block */

    //                         uint256 v6/* numerator */ = v1/* new_ratios */[t] * (10**18); /* (denominator -> 10**18) */
    //                         /* initialize a numerator variable thats the product of the new active reduction proportion value(<6>active_block_limit_reduction_proportion) and 10**18 */

    //                         uint256 v7/* power */ = (p3/* block_number */ - v2/* exchange */[2][ 5 /* <5>active_mint_block */ ]) - 1;
    //                         /* initialize a power variable thats the difference between the current block number and the last block number that the exchange was involved in a mint action less one */

    //                         v1/* new_ratios */[t] = f14/* calculate_new_increased_active_block_limit_reduction_proportion */( v6/* numerator */, v7/* power */, v2/* exchange */[1][ 8 /* <8>block_reset_limit */ ], v2/* exchange */[1][ 6 /* <6>block_limit_reduction_proportion */ ] );
    //                         /* recalculate the new increased active block limit since the value has to be pushed up for the blocks that no minting took place */
    //                     }
    //                 } else {
    //                     /* limit has not been exceeded, so increase [2]<6>active_block_limit_reduction_proportion
    //                         value by [1]<6>block_limit_reduction_proportion, if value is less than 100%, 
    //                     */
    //                     if ( v2/* exchange */[2][ 6 /* <6>active_block_limit_reduction_proportion */ ] < 10**18 /* (100%) */ ) {
    //                         /* if the value is less than 100% */

    //                         uint256 v8/* numerator */ = v2/* exchange */[2][ 6/* <6>active_block_limit_reduction_proportion */] * (10**18); /* (denominator -> 10**18) */
    //                         /* initialize a numerator value as the product of the active block limit value and 10**18 */

    //                         uint256 v9/* power */ = p3/* block_number */ - v2/* exchange */[2][ 5 /* <5>active_mint_block */ ];
    //                         /* initialize a power variable thats the difference between the current block number and the last block number that the exchange was involved in a mint action  */

    //                         v1/* new_ratios */[t] = f14/* calculate_new_increased_active_block_limit_reduction_proportion */( v8/* numerator */, v9/* power */, v2/* exchange */[1][ 8 /* <8>block_reset_limit */ ], v2/* exchange */[1][ 6 /* <6>block_limit_reduction_proportion */ ] );
    //                         /* recalculate the new increased active block limit since the value has to be pushed up for the blocks that no minting took place */
    //                     }
    //                 }
    //             }
    //         }
    //     }
    // }//-----CHANGED-----

    // /* calculate_new_increased_active_block_limit_reduction_proportion */
    // function f14(
    //     uint256 p1/* numerator */,
    //     uint256 p2/* power */,
    //     uint256 p3/* block_reset_limit */,
    //     uint256 p4/* block_limit_reduction_proportion */
    // ) private pure returns (uint256) {
    //     /* 
    //         it: calculates the new active block limit proportion if the block limit was not exceeded in preceding blocks
    //         numerator = active_block_limit_reduction_proportion * (10**18)
    //         eg. if active_block_limit_reduction_proportion = 81% and power = 2 and block_limit_reduction_proportion = 90%
    //             new_limit = 81*100 = 8100
    //             then 90% => 0.9^2 = 0.81 => 81%
    //             then 8100 ÷ 81 = 100%
    //     */
    //     if (p2/* power */ > p3/* block_reset_limit */ && p3/* block_reset_limit */ != 0) {
    //         /* if a reset limit exists and the power is greater than it */

    //         p2/* power */ = p3/* block_reset_limit */;
    //         /* set the power to be the reset limit */
    //     }
    //     else if(p2/* power */ >= 35){
    //         /* if the power is greater than thirtyfive */

    //         p2/* power */ = 35;
    //         /* set it to 35 */
    //     }
    //     uint256 v1/* denominator */ = f3/* compound */(p4/* block_limit_reduction_proportion */, p2/* power */);
    //     /* intialize a denominator variable thats the compounded value of the block limit reduction proportion using the power */

    //     uint256 v2/* new_val */ = p1/* numerator */ / v1/* denominator */;
    //     /* then set the return value as the numerator divided by the denominator */

    //     if ( v2/* new_val */ > 10**18 /* (denominator -> 10**18) */ ) {
    //         /* if the value is more than 100% */
    //         v2/* new_val */ = 10**18; /* (denominator -> 10**18) */
    //         /*  set it to 100% */
    //     }
    //     return v2/* new_val */;
    // }//-----TEST_OK-----

    // /* calculate_factor */
    // function f11(
    //     uint256 p1/* reduction_proportion */,
    //     uint256 p2/* total_minted_for_current_block */,
    //     uint256 p3/* max_block_buyable_amount */
    // ) private pure returns (uint256) {
    //     /* if total_minted_for_current_block exceeds max_block_mintable_amount, the amount of spend that can be minted is reduced
    //         (100%/50%)*(200,000,000/100,000,000) = 2*2 = 4
    //         then the factor_amount = 10,000,000(active_mintable_amount) / 4 = 2,500,000
    //     */
    //     if(p1/* reduction_proportion */ == 0 || p2/* total_minted_for_current_block */ == 0 || p3/* max_block_buyable_amount */==0){
    //         /* if one of the values passed is zero, return zero */
    //         return 0;
    //     }
    //     return ((10**18) / p1/* reduction_proportion */) * ((p2/* total_minted_for_current_block */ == 0 ? 1 /* 1 to avoid exception */ : p2/* total_minted_for_current_block */ ) / p3/* max_block_buyable_amount */);
    // } //-----TEST_OK-----




    /* run_token_exchange_checkers */
    function f66(uint256[][] memory p1/* new_obj_id_num */) external view {
        /* contains checkers used to ensure that a created token exchange doesnt break while in use */
        
        require(p1/* new_obj_id_num */[0][ 3 /* type */ ] == 5 || /* 5-type_uncapped_supply */ 
        p1/* new_obj_id_num */[0][ 3 /* type */ ] == 3 /* type_capped_supply */);
        /* ensure correct type is passed */ 

        require(p1/* new_obj_id_num */[0][ 4 /* <4>non-fungible */ ] <= 1);
        /* ensure correct fungible setting is passed */

        require( 
            p1/* new_obj_id_num */[0][ 2 /* fully_custom */ ] <= 1 && 
            p1/* new_obj_id_num */[0][ 1 /* unlocked_liquidity */ ] <= 1 &&
            p1/* new_obj_id_num */[0][ 0 /* unlocked_supply */ ] <= 1 &&
            p1/* new_obj_id_num */[ 3 /* source_tokens */ ].length != 0
        );   
        /* ensure correct custom and unlocked liquidity/supply value */
        /* ensure correct lengths */
                
        
        f65/* run_token_exchange_config_checkers */(p1/* new_obj_id_num */[1], p1/* new_obj_id_num */[0][ 3 /* type */ ]);
        
        require( 
            p1/* new_obj_id_num */[2][ 6 /* active_block_limit_reduction_proportion(denominator -> 10**18) */ ] <= 10**18 && 
            p1/* new_obj_id_num */[2][ 0 /* token_exchange_ratio_x */ ] <= 10**72 && 
            p1/* new_obj_id_num */[2][ 1 /* token_exchange_ratio_y */ ] <= 10**72 && 
            p1/* new_obj_id_num */[2][ 2 /* token_exchange_liquidity/total_supply */ ] <= 10**72 
        );
        /* ensure the active block limit is a proportion, the exchange ratios and total supply dont exceed 1 end */
        
        require(
            p1/* new_obj_id_num */[2][ 0 /* token_exchange_ratio_x */ ] != 0 && 
            p1/* new_obj_id_num */[2][ 1 /* token_exchange_ratio_y */ ] != 0 && 
            p1/* new_obj_id_num */[2][ 3 /* parent_tokens_balance */ ] == 0 && 
            p1/* new_obj_id_num */[2][ 4 /* current_block_mint_total */ ] == 0 && 
            p1/* new_obj_id_num */[2][ 5 /* active_mint_block */ ] <= block.number 
        );
        /* ensure the exchange ratios used are non-zero and the parent token balance and current block mint total are zero and the active mint block is less than or equal to the current block */

        if(p1/* new_obj_id_num */[0][ 4 /* <4>non-fungible */ ] == 1){
            require(
                p1/* new_obj_id_num */[0][ 3 /* type */ ] == 5 /* 5-type_uncapped_supply */ && 
                p1/* new_obj_id_num */[0][ 2 /* <2>fully_custom */ ] == 0 &&
                p1/* new_obj_id_num */[2][ 0 /* token_exchange_ratio_x */ ] == 1 && 

                p1/* new_obj_id_num */[2][ 8 /* <8>non_fungible_depth_exchange_ratio_y */ ] > p1/* new_obj_id_num */[2][ 9 /* <9>non_fungible_depth_token_purchase_end_time */ ] &&

                p1/* new_obj_id_num */[2][ 9 /* <9>non_fungible_depth_token_purchase_end_time */ ] >= p1/* new_obj_id_num */[2][ 10 /* <10>non_fungible_depth_token_purchase_start_time */ ] &&

                p1/* new_obj_id_num */[2][ 10 /* <10>non_fungible_depth_token_purchase_start_time */ ] > p1/* new_obj_id_num */[2][ 11 /* <11>non_fungible_depth_token_applied_token_supply */ ] &&
                p1/* new_obj_id_num */[2][ 12/* <12>non_fungible_depth_token_time_multiplier */ ] != 0 &&
                p1/* new_obj_id_num */[2][ 12/* <12>non_fungible_depth_token_time_multiplier */ ] <= 10**6
            );
            /* ensure valid non-fungible token data. Each value should be successivley decrementing and the time multiplier should be less than 1 million time units */

            if(p1/* new_obj_id_num */[2][14/* <14>non_fungible_depth_token_applied_class */] > 0){
                /* if exchange uses a predefined class system */
                
                require(p1/* new_obj_id_num */[2][14/* <14>non_fungible_depth_token_applied_class */] > p1/* new_obj_id_num */[2][16/* <16>non_fungible_depth_token_applied_increment */] * 10);
            }
        }
        /* ensure token type is uncapped and token exchange ratio x is set to 1 if asset is non-fungible. As well as valid non-fungible configuration settings. */
        
        if ( p1/* new_obj_id_num */[0][ 3 /* type */ ] == 3 /* type_capped_supply */ ) {
            /* if the token is type capped */
            
            require( p1/* new_obj_id_num */[ 3 /* default_source_tokens_for_buy */ ].length != 0 );
            require( p1/* new_obj_id_num */[ 2 /* exchange_ratios */ ][ 2 /* <2>token_exchange_liquidity */ ] == p1/* new_obj_id_num */[ 2 /* exchange_ratios */ ][ 0 /* token_exchange_ratio_x */ ] );
            /* require that source tokens for buying should exist and the the tokens liquidity should match the exchange ratio x */

            require( 
                p1/* new_obj_id_num */[2][ 2 /* token_exchange_liquidity/total_supply */ ] >= 100_000 && 
                p1/* new_obj_id_num */[2][ 6 /* active_block_limit_reduction_proportion */ ] == 0
            );
            /* require the tokens supply to exceed 100k and the active block limit proportion to be zero */
        } else {
            /* the token is type uncapped */

            require( 
                p1/* new_obj_id_num */[2][ 2 /* token_exchange_liquidity/total_supply */ ] == 0 && 
                p1/* new_obj_id_num */[2][ 6 /* active_block_limit_reduction_proportion */ ] == 10**18 
            );
            /* require the total supply to be zero and the active block limit proportion to be 100% */
        }

        for ( uint256 e = 0; e < p1/* new_obj_id_num */[ 3 /* default_source_tokens_for_buy */ ].length; e++ ) {
            /* for each token used for buying the token */

            if ( p1/* new_obj_id_num */[0][3] == 3 /* type_capped_supply */ ) {
                /* if the token is capped */

                require( p1/* new_obj_id_num */[ 3 /* default_source_tokens_for_buy */ ][e] != 0 && p1/* new_obj_id_num */[ 4 /* default_source_tokens_amounts_for_buy */ ][e] != 0 );
                /* if its a capped token, there should exist source tokens for buying and source amounts for buying as well */
            } 
            else {
                /* the token is uncapped */

                if(p1/* new_obj_id_num */[ 3 /* default_source_tokens_for_buy */ ][e] == 0){
                    /* if no token id has been specified */

                    require( p1/* new_obj_id_num */[ 4 /* default_source_tokens_amounts_for_buy */ ][e] == 0 );
                    /* no amount should be specified as well */
                }
                else{
                    /* if a token id has been specified */

                    require( p1/* new_obj_id_num */[ 4 /* default_source_tokens_amounts_for_buy */ ][e] != 0 );
                    /* an amount should be specified as well */
                }
                
            }
        }
    }//-----RETEST_OK-----

    /* run_token_exchange_config_checkers */
    function f65(uint256[] memory p1/* exchange_config */, uint256 p2/* exchange_type */) private pure {
        /* runs checkers on the configuration for a new or modified exchange */
        require( 
            p1/* exchange_config */[ 0 /* default_exchange_amount_buy_limit */ ] <= 10**63 && 
            p1/* exchange_config */[ 11 /* default_exchange_amount_sell_limit */ ] <= 10**63 && 
            p1/* exchange_config */[ 14 /* default_authority_mint_limit(denominator -> 10**18) */ ] <= 10**18 && 

            p1/* exchange_config */[ 15 /* block_halfing_type(0 if fixed, 1 if spread) */ ] <= 1 && 
            p1/* exchange_config */[ 12 /* block_limit_sensitivity */ ] <= 5 && 
            p1/* exchange_config */[ 6 /* block_limit_reduction_proportion (denominator -> 10**18) */ ] <= 10**18 && 

            p1/* exchange_config */[ 7 /* trust_fee_proportion (denominator -> 10**18) */ ] <= 10**18 && 
            p1/* exchange_config */[ 7 /* trust_fee_proportion (denominator -> 10**18) */ ] != 0 && 
            p1/* exchange_config */[ 5 /* internal_block_halfing_proportion (denominator -> 10**18) */ ] <= 10**18  
        );
        /* require the buy limit and sell limit to be less than or equal to 10**63, the auth mint limit to be less than 100%, the halving type to be less than 2, sensitivity value to be less than six, the block limit reduction proportion to be less than or 100%, the trust fee to be non zero and less than or 100%, and the internal block halving proportion less than or 100% */

        if(p2/* exchange_type */ == 5){
            /* if the exchange is an uncapped exchange */
            
            if(p1/* exchange_config */[1/* <1>block_limit */] != 0){
                require(p1/* exchange_config */[1/* <1>block_limit */] > p1/* exchange_config */[0/* <0>default_exchange_amount_buy_limit */]);
                /* if the block limit is non zero, require it to be greater than the buy limit */
            }
            if(p1/* exchange_config */[16/* <16>maturity_limit */] != 0){
                require(p1/* exchange_config */[16/* <16>maturity_limit */] > p1/* exchange_config */[1/* <1>block_limit */]);
                /* if the maturity limit is non zero, require the maturity limit to be greater than the block limit */
            }    
        }
        
    }//-----TEST_OK-----

    /* run_multiple_exchange_config_checkers */
    function f64(uint256[][][] memory p1/* exchange_nums */ ) external pure {
        /* runs exchange config checkers for multiple supplied exchange objects */
        for (uint256 e = 0; e < p1/* exchange_nums */.length; e++) {
            f65/* run_token_exchange_config_checkers */(p1/* exchange_nums */[e][1], p1/* exchange_nums */[e][0][ 3 /* type */ ]);
        }
    }//-----TEST_OK-----




    //
    //
    //
    //
    //
    //
    // ------------------------CONTRACT-FUNCTIONS-------------------------------
    /* contract_data_checkers */
    function f81(
        uint256[] calldata p1/* new_obj_id_exchanges_data */,
        uint256 p2/* rp */,
        uint256[3] calldata p3/* main_contract_data */,
        uint256[] calldata p4/* new_obj_id_exchange_amount_data */
    ) external view {
        /* checks that a new contract thats been created is valid */
        /* 
            main_contract_data[0] =  <3>default_end_minimum_contract_amount
            main_contract_data[1] = <9>default_spend_minimum_contract_amount
            main_contract_data[2] = <23>gas_anchor_price
        */

        require( p1/* new_obj_id_exchanges_data */.length != 0 );
        /* ensures the supplied exchanges for entering the contract have been specified */

        f50/* ensure_minimum_amount */( 
            p1/* new_obj_id_exchanges_data */, 
            p4/* new_obj_id_exchange_amount_data */, 
            p3/* main_contract_data */[ 0 /* default_end_minimum_contract_amount */ ], 
            p3/* main_contract_data */[ 1 /* default_spend_minimum_contract_amount */ ], 
            p3/* main_contract_data */[ 2 /* <23>gas_anchor_price */ ], 
            tx.gasprice, 
            p2/* rp */, 
            false 
        );
        /* ensures the first exchange specified for entering the contract meets the minimum amount required by the main contract */
    }//-----RETEST_OK-----

    /* ensure_minimum_amount_for_bounty */
    function f80(
        uint256 p1/* gas_anchor_price */,
        uint256 p2/* rp */,
        uint256[3] calldata p3/* target_contract_authority_config */,
        uint256[][] calldata p4/* new_obj_id_num_data */
    ) external view returns (uint256[][5] memory){
        /* ensures the minimum amount passed for bounty meets the required minimum amount set in the main contract object */
        /* 
            target_contract_authority_config[0] = <4>default_minimum_end_vote_bounty_amount
            target_contract_authority_config[1] = <10>default_minimum_spend_vote_bounty_amount
            target_contract_authority_config[2] = <37>bounty_limit_type(0 if relative, 1 if absolute)
        */

        bool v1/* bounty_limit_type */ = p3/* target_contract_authority_config */[2/* <37>bounty_limit_type */] == 0 ? false : true;

        f50/* ensure_minimum_amount */( 
            p4/* new_obj_id_num_data */[ 2 /* bounty_exchanges_pos */ ], 
            p4/* new_obj_id_num_data */[ 3 /* bounty_exchanges_amounts */ ], 
            p3/* target_contract_authority_config */[ 0 /* <4>default_minimum_end_vote_bounty_amount */ ], 
            p3/* target_contract_authority_config */[ 1 /* <10>default_minimum_spend_vote_bounty_amount */ ], 
            p1/* gas_anchor_price */, 
            tx.gasprice, 
            p2/* rp */,
            v1/* bounty_limit_type */ 
        );
        /* calls the ensure minimum amount that checks that the supplied bounty amounts meets the required amounts */

        return [ 
            p4/* new_obj_id_num_data */[ 2 /* bounty_exchanges_pos */ ], 
            p4/* new_obj_id_num_data */[ 3 /* bounty_exchanges_amounts */ ], 
            new uint256[](0),  
            new uint256[](0), 
            p4/* new_obj_id_num_data */[ 10 /* bounty_exchange_depths */ ] 
        ];
        /* returns a two dimentional array of five arrays used in sending the bounty tokens from the proposals author account to the proposal account */
    }//-----RETEST_OK-----

    /* ensure_minimum_amount */
    function f50(
        uint256[] calldata p1/* exchanges */,
        uint256[] calldata p2/* amounts */,
        uint256 p3/* default_minimum_end_amount */,
        uint256 p4/* default_minimum_spend_amount */,
        uint256 p5/* gas_anchor_price */,
        uint256 p6/* transaction_gas_price */,
        uint256 p7/* rp */,
        bool p11/* absolute_measure */
    ) private pure {
        /* ensures the amount set for the first exchange meets the minimum amounts set by the contract authority of the proposal */
        
        uint256 p8/* _type */ = 1;
        /* default to type 1 which is the spend exchange */
        
        uint256 p9/* ex_0 */ = p1/* exchanges */[0];
        /* initializes a variable that holds the first exchange used in the bounty */
        
        require( p9/* ex_0 */ == 3 || /* end_exchange_obj_id */ p9/* ex_0 */ == 5 /* spend_exchange_obj_id */ );
        /* ensures the exchange is the end or spend exchange */

        if ( p9/* ex_0 */ == 3 /* end_exchange_obj_id */ ) {
            /* if the first exchange is the end exchange */
            
            p8/* _type */ = 2;
            /* set the value to type 2 which is the end exchange */
        }

        if(p11/* absolute_measure */){
            /* if the minimum amounts are to be measured absolutely */

            if(p8/* _type */ == 1/* spend */){
                /* if the first exchange is the spend exchange */

                require(p2/* amounts */[0] >= p3/* default_minimum_end_amount */);
                /* ensure the amount set is at least the minimum amount set in the contract */
            }
            else{
                /* if the first exchange is the end exchange */

                require(p2/* amounts */[0] >= p4/* default_minimum_spend_amount */);
                /* ensure the amount set is at least the minimum amount set in the contract */
            }
        }
        else{
            uint256 p10/* min_amount */ = f8/* calculate_min_end_or_spend */([ 
                p8/* _type */, 
                p3/* default_minimum_end_amount */, 
                p6/* transaction_gas_price */, 
                p5/* gas_anchor_price */, 
                p4/* default_minimum_spend_amount */, 
                p7/* rp */, 
                p9/* first_exchange_used */ 
            ]);
            /* calculates and sets the minimum amount of end or spend tokens from the type specified above */

            require(p2/* amounts */[0] >= p10/* min_amount */);
            /* ensures the first amount is more than the minimum amount calculated above */
        }
    }//-----RETEST_OK-----

    /* calculate_min_end_or_spend */
    function f8(uint256[7] memory _ints) 
    public pure returns (uint256) {
        /* 
            it: calculates the minimum amount of end or spend using gas fee if end, and block_reduction_proportion_ratios if spend
                eg. if spend and amount=1000e & active_reduction_proportion is at 90%, amount would become:
                    90% of 1000e = 900e
                    if end and amount=1000e, current_price = 120Gwei and anchored_price = 100Gwei amount would be :
                    (1000e*120)/100 = 1200

        */
        if ( _ints[ 0 /* type */ ] == 1 /* from block_reduction_proportion_ratios */ ) {
            /* if the minimum amount is being derived from the spend exchange */
            
            if ( _ints[ 4 /* default_spend_minimum_contract_amount */ ] == 0 ) { 
                /* if the minimum amount is zero, return zero */
                return 0; 
            }
            return f5/* calculate_share_of_total */( _ints[ 4 /* default_spend_minimum_contract_amount */ ], _ints[ 5 /* active_block_limit_reduction_proportion  */ ] );
            /* calculates and returns the minimum amount of spend from the active block limit reduction proportion */
        } 
        else if ( _ints[ 0 /* type */ ] == 2 /* from gas prices */ ) {
            /* if the minimum amount is being derived from the end exchange */

            if ( _ints[ 1 /* default_end_minimum_contract_amount */ ] == 0 ) {
                /* if the minimum contract amount is zero, return zero */
                return 0;
            }
            uint256 a = (_ints[ 2 /* tx.gasprice */ ] * _ints[ 1 /* default_end_minimum_contract_amount */ ]) / _ints[ 3 /* gas anchored_price */ ];
            /* calculates a variable 'a' set to the product of the gas price and the minimum contract amount divided by the gas anchor price */

            if (a == 0) {
                /* if a is zero, return 1 */
                return 1;
            }
            return a;
        }

        return _ints[6/* first_exchange_used */] == 3 /* end_exchange_obj_id */ ? _ints[ 1 /* default_end_minimum_contract_amount */ ] : _ints[ 4 /* default_spend_minimum_contract_amount */ ];
        /* return the default amount as the minimum end or spend contract amount */
    } //-----TEST_OK-----





    function run() external pure returns (uint256){
        return 42;
    }


}