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

/* E5HelperFunctions2 */
library E32 {
    /* check_if_main_contract_votable_required */
    function f15(uint256 p1/* object_type */, bool p2/* can_sender_vote_in_main_contract */ ) external pure {
        /* checks if sender can vote in main contract if new object being created requires it */
        if (p1/* object_type */ == 17 || p1/* object_type */ == 18 || p1/* object_type */ == 24 || p1/* object_type */ == 36) {
            /* 17(job object)  18(post object)  24(shadow_object)  36(type-channel-target) */
            require(p2/* can_sender_vote_in_main_contract */);
        }
    }//-----TEST_OK-----

    /* calculate_share_of_total */
    function f4(uint256 p1, uint256 p2) public pure returns (uint256) {
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
    function f2(uint256 p1/* p1: numb  */, uint256 p2/* p2: steps */) 
    public pure returns (uint256 v1/* v1: val */) {
        /*  p1: numb 
            p2: steps 
            v1: val
        */
        /* 
            it: compounds a given propotion by itself
                eg. 90% -> 1 step
                    90% -> 2 steps => 90% of 90% = 81%
                    90% -> 3 steps => 90% of 90% of 90% = 
        */
        v1 /* v1: val */ = p1/* p1: numb  */;
        require(p1/* p1: numb  */ <= 10**18);
        if (p2/* p2: steps */ > 1) {
            for (uint256 t = 0; t < p2/* p2: steps */ - 1; t++) {
                v1/* v1: val */ = (v1/* v1: val */ * p1/* p1: numb  */) / 10**18; /* (denominator -> 10**18) */
            }
        }
        if(v1/* v1: val */ == 0 && p1/* p1: numb  */ != 0){
            v1/* v1: val */ = 1;
        }
    }//-----TEST_OK-----

    /* get_new_objects_data */
    function f31(
        uint256[][] calldata p1/* t_vals */,
        uint256 p2/* user_acc_id */,
        uint256[] calldata p3/* temp_transaction_data */,
        uint256 p4/* min_obj_len */
    ) external view returns (uint256[][] memory v1/* new_obj_id_nums */) {
        /* returns a new object's int data from the transaction supply data. */

        v1/* new_obj_id_nums */ = new uint256[][](p4/2/* min_obj_len */);
        /* initialize the return value as a new two dimentional array whose lenght is half the size of the supplied data since the transaction's stack specific data(the 23s 35s and 53s) is not used after this */

        for ( uint256 d = 1; d <= p4/* min_obj_len */ ; d += 2 ) {
            /* for each array in the new objects data and its corresponding stack specific data */

            uint256[] memory v2/* data_array */ = p1/* t_vals */[d];
            /* initialize a new array variable that contains the array of the object's data in focus */

            uint256[] memory v3/* stack_or_real_array */ = p1/* t_vals */[d + 1];
            /* initialize a new array variable that contains the stack specific data */

            v1/* new_obj_id_nums */[d/2] = f19/* get_multi_stack_or_real_ids */(v2/* data_array */, v3/* stack_or_real_array */, p3/* temp_transaction_data */, p2/* user_acc_id */);
            /* pass the two arrays into the get multi stack or real ids function that calculates the final objects data for the array in focus */
        }
    }//-----TEST_OK-----

    /* get_multi_stack_or_real_ids */
    function f19(
        uint256[] memory p1/* ids */,
        uint256[] memory p2/* id_types */,
        uint256[] memory p3/* temp_transaction_data */,
        uint256 p4/* sender_acc_id */
    ) public view returns (uint256[] memory v1/* targets */) {
        /* returns a list of targets derived from passed ids and their respective types */

        v1/* targets */ = new uint256[](p1.length);/* ids */
        /* initialize the return value as a new array whose length is the number of items in the data array passed */

        for (uint256 t = 0; t < p1/* ids */.length; t++) {
            /* for each data item in the data array */

            if ( p2/* id_types */[t] == 23 /* real */ ) {
                /* if the data's corresponding type is real(23) */

                v1/* targets */[t] = p1/* ids */[t];
                /* set the data item itself */
            }
            else if ( p2/* id_types */[t] == 35 /* stack */ ) {
                /* if the data's corresponding type is stack(35) */

                v1/* targets */[t] = p3/* temp_transaction_data */[ p1/* ids */[t] ];
                /* set the stack item its pointing to in the temp_transaction_data array */
            }
            else if ( p2/* id_types */[t] == 53 /* sender_account */ ) {
                /* if the data's corresponding type is sender(53). this here because the sender can create an account for another address in the transaction stack */

                if(p4/* sender_acc_id */ != 0 ){
                    /* if the senders account id is not zero */

                    v1/* targets */[t] = p4/* sender_acc_id */;
                    /* set the sender account in the return target array at its specific position */
                }
                else{
                    /* if the sender has no account, revert */
                    revert("");
                }
            }
            else if(p2/* id_types */[t] == 65 /* block_number */){
                /* if the data's correspoinding type is block_number(65) */

                v1/* targets */[t] = block.number + p1/* ids */[t];
                /* record the value as the block number with the specified offset. specify zero to set the current block */
            }
            else if(p2/* id_types */[t] == 72 /* time */){
                /* if the data's corresponding type is the time(72) */

                v1/* targets */[t] = block.timestamp + p1/* ids */[t];
                /* record the value as the timestamp with the specified offset. specify zero to set the current timestamp */
            }
            else{
                /* if the type supplied is not 23, 35 or 53, revert */
                revert("");
            }
        }
    }//-----RETEST_OK-----

    /* get_nested_account_data */
    function f30(
        uint256[][] calldata p1/* t_vals */,
        uint256[] calldata p2/* targets */,
        uint256 p3/* start_from */
    ) external pure returns (uint256[][] memory v1/* accounts */) {
        /* organizes and sets the accounts being targeted for collecting subscriptions */

        v1/* accounts */ =  new uint256[][](p2.length);
        /* initialize the return value as a new two dimentional array whose length is the number of subscription targets */

        for (uint256 r = 0; r < p2/* targets */.length; r++) {
            /* for each targeted subscription */
            /* 0: transaction_data, 1-2: target_obj_data  */

            uint256 v2/* target_account_array_pos */ = r + p3/* start_from */;
            /* the array for the specific subscription item containing the accounts its targeting */

            v1/* accounts */[r] = p1/* t_vals */[v2/* target_account_array_pos */];
            /* set the accounts in the subscriptions position */
        }
    }//-----TEST_OK-----

    /* get_nested_exch_data_for_bounties */
    function f228(
        uint256[][] calldata p1/* t_vals */,
        uint256[] calldata p2/* targets */,
        uint256 p3/* start_from */,
        uint256[] calldata p4/* temp_transaction_data */,
        uint256 p5/* sender_acc_id */
    ) external view returns (uint256[][][2] memory v1/* target_bounty_exchanges_depth-data */) {
        /* organizes and sets the exchanges and depths being targeted for bounty collection when voting on proposals */

        v1/* target_bounty_exchanges_depth-data */ = [new uint256[][](p2.length), new uint256[][](p2.length)];
        /* initialize the return value as a new three dimentional array consisting of two arrays whose length is the number of proposal targets */

        for (uint256 r = 0; r < p2/* targets */.length; r++) {
            /* for each targeted proposal */
            /* 0: transaction_data, 1-2: target_obj_data, 3: votes_data
                  r[] <-----exchange_id
                r+1[] <-----exchange_id_types
                r+2[] <-----exchange_depths
             */

            uint256 v2/* target_exchange_array_pos */ = (r * 3) + p3/* start_from */;
            /* the array for the specific proposal item containing the bounty exchanges its targeting */

            
            uint256[] memory v3/* data_array */ = p1/* t_vals */[v2/* target_exchange_array_pos */];
            /* initialize a new array variable that contains the array of the exchanges in focus */

            uint256[] memory v4/* stack_or_real_array */ = p1/* t_vals */[v2/* target_exchange_array_pos */ + 1];
            /* initialize a new array variable that contains the stack specific data for the exchanges specified */

            v1/* target_bounty_exchanges_depth-data */[0/* bounty_exchanges */][r] = f19/* get_multi_stack_or_real_ids */(v3/* data_array */, v4/* stack_or_real_array */, p4/* temp_transaction_data */, p5/* sender_acc_id */);
            /* set the bounty exchanges specified by the sender from the get multi-stack or real ids function return data */

            v1/* target_bounty_exchanges_depth-data */[1/* bounty_exchange_depths */][r] = p1/* t_vals */[v2/* target_exchange_depths_array_pos */ + 2];
            /* set the bounty exchange depths in the target proposal's position */
        }
    }//-------TEST_OK------
    

    /* get_archive_nested_account_data */
    function f49(
        uint256[][] calldata p1/* t_vals */,
        uint256[] calldata p2/* targets */
    ) external pure returns (uint256[][][3] memory v1/* accounts_exchanges */) {
        /* returns the voter accounts and exchange balance for each targeted contract or proposal object being archived */

        v1/* accounts_exchanges */ = [new uint256[][](p2.length), new uint256[][](p2.length), new uint256[][](p2.length)];
        /* initialize the return value as a three dimentional array consisting of 3 two dimentional arrays whose length is the number of targets being archived */
        /* 
            [0]:transaction_data
            [1]:target_contract/proposal_data
            [2]:target_contract/proposal_id_types

            [3]:voter_accounts
            [4]:balance_exchanges(each archive target will have some balances in specific target exchanges specified here)
            [5]:balance_exchange_depths(specify the depths for each exchange being 'looted')
         */

        for (uint256 r = 0; r < p2/* targets */.length; r++) {
            /* for each target being archived */
            /* 0: transaction_data, 1-2: target_subs_data  */

            uint256 v2/* sub_payers_array_pos */ = (r * 3) + 3;
            /* for each target, voter accounts and exchanges in two arrays preceding each other after the first three arrays which hold the transaction data, the target contract/proposal ids being archived and their id type data */
            v1/* accounts_exchanges */[0/* voter_accounts */][r] = p1/* t_vals */[v2/* sub_payers_array_pos */];
            /* set the voter accounts for the specific archive target in the return array in its array position */

            v1/* accounts_exchanges */[1/* balance_exchanges */][r] = p1/* t_vals */[v2/* sub_payers_array_pos */+1];
            /* set the archives token balance exchanges for the specific archive target as well in its array position */

            v1/* accounts_exchanges */[2/* balance_exchange_depths */][r] = p1/* t_vals */[v2/* sub_payers_array_pos */+2];
            /* set the archives token balance exchange depths for the specific archive target as well in its array position */
        }
    }//-----RETEST_OK-----

    //
    //
    //
    //
    //
    //
    // ------------------------TOKEN-FUNCTIONS-------------------------------
    /* price */
    function f1(
        uint256 p1/* input_amount */, 
        uint256 p2/* input_reserve_ratio */, 
        uint256 p3/* output_reserve_ratio */, 
        uint256 p4/* capped_or_uncapped */
    ) private pure returns (uint256) {
        /* 
            It:
            -calculates price given an input amount and exchange ratios. 
            Capped: (input_amount * output_reserve_ratio) / (input_reserve_ratio + input_amount)
            Uncapped: (input_amount * output_reserve_ratio) / input_reserve_ratio

        */
        if (p1/* input_amount */ == 0) {
            /* if the input amount is zero, return zero */

            return 0;
            /* return zero */
        }
        /* input amount should be less than input_reserve_ratio */
        // require(p1/* input_amount */ < p2/* input_reserve_ratio */);

        uint256 v1/* denominator */ = p2/* input_reserve_ratio */;
        /* define the denominator as the input reserve ratio */

        if ( p4/* capped_or_uncapped */ == 3 /* type_capped_supply */ ) {
            /* if the token is a capped token */

            v1/* denominator */  += p1/* input_amount */;
            /* the denominator becomes the input reserve ratio plus the input amount targeted */
        }

        if (p3/* output_reserve_ratio */ > 10**36 && v1/* denominator */ > 10**36) {
            /*  eg. output_reserve_ratio: 10**72 and  denominator: ~10**72
                -removes 36 powers from both numbers, calculates then puts them back
             */
            uint256 v2/* final_denom */ = v1/* denominator */ / 10**36;
            uint256 v3/* final_output_reserve_ratio */ = p3/* output_reserve_ratio */ / 10**36;
            /* removed 36 powers from the final denominator and final output reserve ratio*/

            if (p1/* input_amount */ > 10**36) {
                /* if the input amount is large, remove 36 powers as well */
                uint256 v4/* final_amount */ = p1/* input_amount */ / 10**36;
                uint256 v5/* final_numerator */ = v4/* final_amount */ * v3/* final_output_reserve_ratio */;
                uint256 p = v5/* final_numerator */ / v2/* final_denom */;
                return p * (10**36);
                /* returned the 36 powers */
            } else {
                uint256 v5/* final_numerator */ = p1/* input_amount */ * v3/* final_output_reserve_ratio */;
                return v5/* final_numerator */ / v2/* final_denom */;
            }
        } 
        else if (p3/* output_reserve_ratio */ > 10**36) {
            /*  eg. output_reserve_ratio: 10**72 and  denominator: 2
             */
            return p1/* input_amount */ * (p3/* output_reserve_ratio */ / v1/* denominator */);
        } 
        else if (v1/* denominator */ > 10**36) {
            /* 
                eg. denominator : 10**72 and  output_reserve_ratio: 2
            */
            if (p1/* input_amount */ < 10**36) {
                return (p1/* input_amount */ * p3/* output_reserve_ratio */) / v1/* denominator */;
            } else {
                /* 
                    eg. denominator : ~10**72 and  output_reserve_ratio: 2
                */
                uint256 v4/* final_amount */ = p1/* input_amount */ / 10**36;
                uint256 v2/* final_denom */ = v1/* denominator */ / 10**36;
                /* remove 36 powers from input_amount and denominator */
                uint256 v5/* final_numerator */ = v4/* final_amount */ * p3/* output_reserve_ratio */;

                return v5/* final_numerator */ / v2/* final_denom */;
            }
        } else {
            return (p1/* input_amount */ * p3/* output_reserve_ratio */) / v1/* denominator */;
        }
    } //-----TEST_OK-----

    /* calculate_factor */
    function f10(
        uint256 p1/* reduction_proportion */,
        uint256 p2/* total_minted_for_current_block */,
        uint256 p3/* max_block_buyable_amount */
    ) private pure returns (uint256) {
        /* if total_minted_for_current_block exceeds max_block_mintable_amount, the amount of spend that can be minted is reduced
            (100%/50%)*(200,000,000/100,000,000) = 2*2 = 4
            then the factor_amount = 10,000,000(active_mintable_amount) / 4 = 2,500,000
        */
        if(p1/* reduction_proportion */ == 0 || p2/* total_minted_for_current_block */ == 0 || p3/* max_block_buyable_amount */ == 0){
            return 0;
        }
        return ((10**18) / p1/* reduction_proportion */) * ((p2/* total_minted_for_current_block */ == 0 ? 1 /* 1 to avoid exception */ : p2/* total_minted_for_current_block */ ) / p3/* max_block_buyable_amount */);
    } //-----TEST_OK-----



    /* calculate_tokens_to_receive */
    function f39(
        uint256[][6] calldata p1/* data */,
        uint256[][][] calldata p2/* exchange_nums */,
        uint256 p3/* msg_value */,
        bool p4/* authority_mint */,
        uint256[][2] memory p5/* buy_sell_limits */
    ) public pure returns ( 
        uint256[] memory v1/* tokens_to_receive */, 
        uint256[2] memory v2/* external_amount_data */, 
        uint256 v3/* _msg_value */ 
    ) {
        /* calculates the amount of tokens the sender is to receive for a given set of swap actions */

        uint256[] memory v4/* active_mintable_amounts */ = f34/* calculate_active_mintable_amounts */(p1/* data */, p2/* exchange_nums */);
        /* calls the function that calculates the amount of tokens that can be minted from the given set of exchange targets */

        ( uint256[][4] memory v5/* tokens_to_receive_data */, uint256 v6/* new_msg_value */ ) = f37/* calculate_tokens_setup */( p1/* data */, p2/* exchange_nums */, p3/* msg_value */, v4/* active_mintable_amounts */ );
        /* calls the function that sets up the swap data for each buy or sell action */

        v1/* tokens_to_receive */ = f38/* calculate_final_tokens_to_receive */(v5/* tokens_to_receive_data */, p1/* data */, p2/* exchange_nums */, p4/* authority_mint */, v4/* active_mintable_amounts */);
        /* calculates the number of tokens the sender is set to receive using the tokens to receive data derived above */

        if ( p5/* buy_sell_limits */[ 0 /* lower_bound */ ].length != 0 ) {
            /* if buy and sell limits have been defined */

            f32/* check_if_tokens_exceed_requested_limits */( v1/* tokens_to_receive */, p5/* buy_sell_limits */ );
            /* ensures the tokens the sender is set to receive fall in the required bounds specified */
        }

        v2/* external_amount_data */ = f33/* check_for_external_amounts */( p2/* exchange_nums */, p1/* data */, v1/* tokens_to_receive */ );
        /* checks for any external amounts(basically wei) that is to be credited in the senders withdraw balance */

        v3/* _msg_value */ = v6/* new_msg_value */;
        /* set the updated message value if the sender has bought end. the value should be updated to avoid double use of the same ether */
    }//-----TEST_OK-----

    /* calculate_active_mintable_amounts */
    function f34(
        uint256[][6] calldata p1/* data */,
        uint256[][][] calldata p2/* exchange_nums */
    ) private pure returns (uint256[] memory v1/* active_mintable_amounts */) {
        /* it gets the mintable amounts using the supplied amount for buying and the exchange's active_block_limit_reduction_proportion value */

        v1/* active_mintable_amounts */ = new uint256[](p1[1].length);
        /* initialize the return value as a new array whose lenght is the number of exchange targets specified */

        for ( uint256 t = 0; t < p1/* data */[ 1 /* exchanges */ ].length; t++ ) {
            /* for each exchange targeted */

            if ( p2/* exchange_nums */[t][0][ 3 /* exchange_type */ ] == 5 /* type_uncapped_supply */ ) {
                /* if the token is an uncapped token */

                v1/* active_mintable_amounts */[t] = f4/* calculate_share_of_total */( p1/* data */[ 2 /* target_amounts */ ][t], p2/* exchange_nums */[t][2][ 6 /* <6>active_block_limit_reduction_proportion */ ] );
                /* get the amount of tokens set to be received by the sender using the active block limit proportion thats usually adjusted with the amount of demand that the exchange is receiving at a given time */

            } else {
                /* if the token is a capped token */

                v1/* active_mintable_amounts */[t] = p1/* data */[ 2 /* target_amounts */ ][t];
                /* set the mintable amount as the targeted amount set by the sender */
            }
        }
    }//-----TEST_OK-----

    /* calculate_tokens_setup */
    function f37(
        uint256[][6] calldata p1/* ex_data */,
        uint256[][][] calldata p2/* exchange_nums */,
        uint256 p3/* msg_value */,
        uint256[] memory p4/* active_mintable_amounts */
    ) private pure returns (uint256[][4] memory v1/* data */, uint256 v2/* new_msg_value */) {
        /* sets up the data used for performing exchange swap actions */

        uint256 l = p1/* ex_data */[ 1 /* exchanges */ ].length;
        /* initialize a length value as the number of exchanges being interacted with */

        v1/* data */ = [ new uint256[](l), new uint256[](l), new uint256[](l), new uint256[](l) ];
        /* initialize the return data vaiable as a two dimentional array consisting of four arrays whose length is the number of exchanges being targeted */

        v2/* new_msg_value */ = p3/* msg_value */;
        /* the return msg value should default to the value passed in the argument */

        for ( uint256 t = 0; t < p1/* ex_data */[ 1 /* exchanges */ ].length; t++ ) {
            /* for each exchange targeted */

            ( v1/* data */[ 0 /* factors */ ][t], v1/* data */[ 1 /* ir_parents */ ][t], v1/* data */[ 2 /* or_parents */ ][t], v1/* data */[ 3 /* factor_amounts */ ][t] ) = f35/* get_tokens_to_receive */( p2/* exchange_nums */[t], p1/* ex_data */[ 1 /* exchanges */ ][t], p1/* ex_data */[ 2 /* target_amounts */ ][t], p4/* active_mintable_amounts */[t], p3/* msg_value */, p1/* ex_data */[ 0 /* action_types */ ][t] );
            /* set the return data at the specific exchanges position as the return data from the get tokens to receive function */

            if ( p1/* ex_data */[ 1 /* exchanges */ ][t] == 3 /* end_exchange_obj_id */ && p1/* ex_data */[ 0 /* action_types */ ][t] == 0 /* buy? */) {
                /* if were buying end */

                v2/* new_msg_value */ = 0;
                /* set the new msg value returned to be zero, since the ether has been consumed */
            }
        }
    }//-----TEST_OK-----

    /* calculate_final_tokens_to_receive */
    function f38(
        uint256[][4] memory p1/* tokens_to_receive_data */,
        uint256[][6] calldata p2/* data */,
        uint256[][][] calldata p3/* exchange_nums */,
        bool p4/* authority_mint */,
        uint256[] memory p5/* active_mintable_amounts */
    ) private pure returns (uint256[] memory v1/* tokens_to_receive */) {
        /* receives the swap data and calculates the tokens set to be received by the targeted recipient of the swap */

        uint256 v2/* exchanges_count */ = p2/* data */[ 1 /* exchanges */ ].length;
        /* set the number of exchanges in a variable */

        v1/* tokens_to_receive */ = new uint256[](v2);
        /* initialize the return variable as a new array whose length is the number of exchanges targeted */

        for ( uint256 t = 0; t < v2/* exchanges_count */; t++ ) {
            /* for each targeted exchange */

            uint256 v3/* amount */ = p1/* tokens_to_receive_data */[ 0 /* factors */ ][t] == 0 ? 
            p5/* active_mintable_amounts */[t] /* amount available */ : p1/* tokens_to_receive_data */[ 3 /* factor_amounts */ ][t];
            /* if the factor set is zero, use the active mintable amount, else use the factor amout specified since the factor deals with demand inside a given block */
            
            if (p4/* authority_mint */) {
                /* if an auth_mint is being performed */
                v3/* amount */ = p2/* data */[ 2 /* target_amounts */ ][t];
                /* set the specified amount */ 
            }
            v1/* tokens_to_receive */[t] = f1/* price */( v3/* amount */, p1/* tokens_to_receive_data */[ 1 /* ir_parents */ ][t], p1/* tokens_to_receive_data */[ 2 /* or_parents */ ][t], p3/* exchange_nums */[t][0][ 3 /* type */ ] );
            /* set the tokens to receive value for the swap as the return value of the price function */
        }
    }//-----TEST_OK-----

    /* get_tokens_to_receive */
    function f35(
        uint256[][] calldata p1/* exchange_nums */,
        uint256 p2/* exchange */,
        uint256 p3/* amount */,
        uint256 p4/* active_mintable_amount */,
        uint256 p5/* msg_value */,
        uint256 p6/* action_type */
    ) private pure returns ( 
        uint256 v1/* factor */, 
        uint256 v2/* ir_parent */, 
        uint256 v3/* or_parent */, 
        uint256 v4/* factor_amount */ 
    ) {
        /* it: returns the data required for calculating tokens to receive value */

        uint256 v5/* active_block_limit */ = f12/* get_active_block_limit */( 
            p1/* exchange_nums */[1][ 1 /* <1>block_limit */ ], 
            p1/* exchange_nums */[1][ 0 /* <0>default_exchange_amount_buy_limit */ ], 
            p1/* exchange_nums */[2][ 2 /* <2>token_exchange_liquidity/total_supply */ ], 
            p1/* exchange_nums */[1][ 16 /* <16>maturity_limit */ ] 
        );
        /* gets the active block limit using its current set block limit and token maturity */

        v1/* factor */ = f10/* calculate_factor */( 
            p1/* exchange_nums */[1][ 5 /* <5>internal_block_halfing_proportion */ ], 
            p1/* exchange_nums */[2][ 4 /* <4>total_minted_for_current_block */ ], 
            v5/* active_block_limit */ 
        );
        /* gets the factor value using tokens internal block_halfing and total minted value */

        v4/* factor_amount */ = p4/* active_mintable_amount */;
        /* set the factor amount as the active mitable amount by default */

        if (v1/* factor */ > 0) {
            /* if the factor is non-zero, the active mintable amount is reduced by the factor amount */

            v4/* factor_amount */ = v1/* factor */ > p4/* active_mintable_amount */ ? 1 : p4/* active_mintable_amount */ / v1/* factor */;
            /* incase the factor is greater than the amount, mint amount is set to 1 token */
        }

        if ( p1/* exchange_nums */[1][ 15 /* <15>block_halfing_type(0 if fixed, 1 if spread) */ ] == 1 ) {
            /* if the halving type is spread */
            v4/* factor_amount */ = f13/* calculate_spread_factor_amount */( 
                p1/* exchange_nums */[1][ 5 /* <5>internal_block_halfing_proportion */ ], 
                p1/* exchange_nums */[2][ 4 /* <4>total_minted_for_current_block */ ], 
                v5/* active_block_limit */, 
                v4/* factor_amount */ 
            );
            /* the factor amount is determined using the spread factor amount function */
        }

        v2/* ir_parent */ = p1/* exchange_nums */[2][ 0 /*output ratio of the token*/ ];
        v3/* or_parent */ = p1/* exchange_nums */[2][ 1 /*input ratio of parent*/ ];
        /* set the input ratio and output ratio for calculating tokens to receive. Default action as sell */

        if ( p6/* action_type */ == 0 /* buy? */ ) {
            /* if its a buy action */

            v2/* ir_parent */ = p1/* exchange_nums */[2][ 1 /*input ratio of parent*/ ];
            v3/* or_parent */ = p1/* exchange_nums */[2][ 0 /*output ratio of END*/ ];
            /* reverse the input and output ratio values */

            if ( p2/* exchange */ == 3 /* end_exchange_obj_id */ ) {
                /* if were buying from the end exchange */

                require( p3/* amount */ <= p5/* msg_value */ / p1/* exchange_nums */[4][ 0 /* source_token fee */ ] );
                /* msg.value amount should be sufficient for buying targeted amount */
            }
            
        }
    }//-----TEST_OK-----

    /* calculate_spread_factor_amount */
    function f13(
        uint256 p1/* internal_block_halfing_proportion */,
        uint256 p2/* total_minted_for_current_block */,
        uint256 p3/* block_limit */,
        uint256 p4/* factor_amount */
    ) private pure returns (uint256) {
        /* it calculates the new factor amount if the block halving type for the exchange is spread */
        /* 
            block_limit -> max_block_buyable_amount

            ((total_minted_for_current_block % max_block_buyable_amount) / max_block_buyable_amount) * ((100% - internal_block_halfing_proportion) of factor_amount)

            eg. internal_block_halfing_proportion = 50% and factor_amount = 1000
                    if total_minted_for_current_block = 1000, and max_block_buyable_amount = 10,000 and 
                    then (1000 % 10000) = 1000 then (1000÷10000) = 0.1
                    then 100% - 50% = 50% then 50% of 1000 = 500
                    then 0.1 * 500 = 50
                    final amount = 1000-50 = 950
        */
        uint256 v1/* mod_amm */ = p2/* total_minted_for_current_block */ % p3/* block_limit */;
        /* 8e 5000000000000000000000000000000000000000000000 50e44*/
        if (v1/* mod_amm */ == 0) {
            return p4/* factor_amount */;
        }

        uint256 v2/* sub_amount */ = 0;
        uint256 v3/* rem */ = f4/* calculate_share_of_total */(p4/* factor_amount */, (10**18 - p1/* internal_block_halfing_proportion */) );
        /* 8e 500000000000000000000000000000000000000000000 5e44*/
        /* 8f 500000000000000000000 5e20*/

        if (v1/* mod_amm */ > 10**36 && v3/* rem */ > 10**36) {
            /* 8e
                50e44 * 5e44 => 250e88 ÷ 100e44 => 2.5e44 = 25e43
            */
            v2/* sub_amount */ = ( ((v1/* mod_amm */ / 10**36) * (v3/* rem */ / 10**36)) / (p3/* block_limit */ / 10**36) ) * 10**36;
        } 
        else if (v3/* rem */ > 10**36) {
            /* might never be run since LARGE rem == LARGE factor_amount == LARGE block_limit == LARGE mod_amm */
            v2/* sub_amount */ = ((v1/* mod_amm */ * (v3/* rem */ / 10**36)) / p3/* block_limit */) * 10**36;
        } 
        else if (v1/* mod_amm */ > 10**36) {
            /* 8f
                50e8 * 5e20 => 250e28 ÷ 100e8 => 2.5e20 = 25e19 
            */
            v2/* sub_amount */ = ((v1/* mod_amm */ / 10**36) * v3/* rem */) / (p3/* block_limit */ / 10**36);
        } 
        else {
            v2/* sub_amount */ = ((v1/* mod_amm */ * v3/* rem */) / p3/* block_limit */);
        }

        return p4/* factor_amount */ - v2/* sub_amount */;
    }//-----TEST_OK-----

    /* get_active_block_limit */
    function f12(
        uint256 p1/* block_limit */,
        uint256 p2/* mint_limit */,
        uint256 p3/* total_supply */,
        uint256 p4/* maturity_limit */
    ) private pure returns (uint256 v/* active_block_limit */) {
        /*  
            it: calculates the active block limit if supply of token is less than maturity limit
                eg. if block_limit = 100 and total_supply = 1000 and maturity_limit = 2000
                    then active_block_limit = (1000 ÷ 2000) * 100 = 50
        */
        v/* active_block_limit */ = p1/* block_limit */;

        if (p4/* maturity_limit */ != 0 && p3/* total_supply */ < p4/* maturity_limit */) {
            /* (total_supply / maturity_limit) * block_limit  */
            if (p3/* total_supply */ >= 10**36 && p1/* block_limit */ >= 10**36) {
                v/* active_block_limit */ =
                    (((p3/* total_supply */ / 10**36) * (p1/* block_limit */ / 10**36)) /
                        (p4/* maturity_limit */ / 10**36)) *
                    10**36;
            } 
            else if (p3/* total_supply */ >= 10**36) {
                v/* active_block_limit */ = (((p3/* total_supply */ / 10**36) * p1/* block_limit */) /
                    (p4/* maturity_limit */ / 10**36));
            } 
            else if (p1/* block_limit */ >= 10**36) {
                v/* active_block_limit */ =
                    ((p3/* total_supply */ * (p1/* block_limit */ / 10**36)) / p4/* maturity_limit */) *
                    10**36;
            } 
            else {
                v/* active_block_limit */ = (p3/* total_supply */ * p1/* block_limit */) / p4/* maturity_limit */;
            }
            if (v/* active_block_limit */ < p2/* mint_limit */) {
                v/* active_block_limit */ = p2/* mint_limit */;
            }
        }
    }//-----TEST_OK-----

    /* check_if_tokens_exceed_requested_limits */
    function f32(
        uint256[] memory p1/* tokens_to_receive */,
        uint256[][2] memory p2/* buy_sell_limits */
    ) private pure {
        /* checks if the tokens set to be received fall within specified bounds */

        for (uint256 t = 0; t < p1/* tokens_to_receive */.length; t++) {
            /* for each token to receive */
            
            if(p2/* buy_sell_limits */[ 0 /* lower_bound */ ][t] > 0 || p2/* buy_sell_limits */[ 1 /* upper_bound */ ][t] > 0 ){
                /* if the lower bound or upper bound values have been specified */
                
                require(
                    p1/* tokens_to_receive */[t] >= p2/* buy_sell_limits */[ 0 /* lower_bound */ ][t] && 
                    p1/* tokens_to_receive */[t] <= p2/* buy_sell_limits */[ 1 /* upper_bound */ ][t] 
                );
                /* token to receive must be on or above its lower_bound and below or on its upper_bound */
            }
        }
    }//-----RETEST_OK-----

    /* check_for_external_amounts */
    function f33(
        uint256[][][] calldata p1/* exchange_nums */,
        uint256[][6] calldata p2/* data */,
        uint256[] memory p3/* tokens_to_receive */
    ) private pure returns (uint256[2] memory v1/* external_amount_data */) {
        /* checks for any amount of ether thats set to be credited in the senders withdraw balance */

        bool v2/* external_set */ = false;
        /* set a default external set variable as false to ensure the external amount data is only modified once */

        for ( uint256 t = 0; t < p2/* data */[1].length; /* exchanges */ t++ ) {
            /* for each exchange specified */

            if ( /* actions */ p2/* data */[0][t] == 1 && /* sell? */ /* exchanges */ p2/* data */[1][t] == 3 /* end_exchange_obj_id */ ) {
                /* if its a sell action and the target exchange is the end exchange */

                uint256[][] calldata v3/* exchange */ = p1/* exchange_nums */[t];
                /* get the end exchange data */

                require(v3/* exchange */[2][ 3 /*<3>balance of exchange parent tokens*/ ] - p3/* tokens_to_receive */[t] >= 1);
                /* end exchange liquidity should not be completely depleted */

                if (!v2/* external_set */) {
                    /* this only runs once */

                    v1/* external_amount_data */[ 0 /* external_amount */ ] = p3/* tokens_to_receive */[t] * v3/* exchange */[4][ 0 /* source_token fee */ ];
                    /* set the amount of wei set to be credited by the seller of end */

                    v1/* external_amount_data */[ 1 /* receiver_acc_id */ ] = p2/* data */[3][t]; /* receivers */
                    /* set the amount in wei and the receiver */

                    v2/* external_set */ = true;
                    /* set the exernal set value to be true to ensure this only runs once */
                } else {
                    /* if selling end more than once, revert */
                    revert("");
                }
            } //only end exchange can do this
        }
    }//-----TEST_OK-----







    


    // /* update_mock_reduction_proportion_ratios */
    // function f249(
    //     uint256[][6] calldata p1/* data */,
    //     uint256[][][] memory p2/* exchange_nums */,
    //     uint256[] calldata p3/* new_ratios */
    // ) external pure returns (uint256[][][] memory v1/* updated_exchange_nums */) {
    //     /* updates the ratios and values used in calculating how much spend you can mint */

    //     v1/* updated_exchange_nums */ = p2/* exchange_nums */;
        
    //     for ( uint256 t = 0; t < p1/* data */[1/* exchanges */].length;  t++ ) {
    //         /* for each targeted exchange in the swap action */
            
    //         if (p2/* exchange_nums */[t][0][ 3 /* exchange_type */ ] == 5/* type_uncapped_supply */ && p2/* exchange_nums */[t][1][ 1 /* block_limit */ ] != 0 ) {
    //             /* if the exchange type is a uncapped exchange and its block limit is defined */

    //             v1/* updated_exchange_nums */[t][2][ 6 /* <6>active_block_limit_reduction_proportion */ ] = p3/* new_ratios */[t];
    //             /* set the new active block limit proportion value in the exchange object in the return value */
    //         }
    //     }
    // }//-----TEST_OK-----

    // /* calculate_mock_tokens_to_receive */
    // function f250(
    //     uint256[][6] calldata p1/* data */,
    //     uint256[][][] calldata p2/* exchange_nums */
    // ) external pure returns (uint256[] memory v1/* tokens_to_receive */){
        
    //     (v1/* tokens_to_receive */,,) = f39/* calculate_tokens_to_receive */( p1/* data */, p2/* exchange_nums */, 0, false, [new uint256[](0), new uint256[](0)] );
    // }//-----TEST_OK-----





    function run() external pure returns (uint256){
        return 42;
    }
}
