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

/* SubscriptionHelperFunctions3 */
library F33 {

    /* get_consensus_subscription_data */
    function f251(
        uint256[21] calldata p2/* consensus_type_data */,
        uint256[][][] calldata p1/* target_nums */
    ) external pure returns (uint256[][3][3] memory v1/* data */) {
        /* calculates sets and returns a three dimentional array whose data is used in consensus subscription actions */
        /* 
            collect_subscriptions: data[0] = target_subscriptions , data[1] = sender_accounts 
            pay_subscription: data[0] = target_subscriptions, data[1] = sender_accounts, data[2] = amounts
            cancel_subscription: data[0] = target_subscriptions, data[1] = sender_accounts, data[2] = amounts
        */
        
        v1/* data */ = f252/* get_collect_subscription_targets_count */(p2/* consensus_type_data */);
        /* sets the return data value from the return value set in the get collect subscription targets count function */
        
        uint256[3] memory v2/* transfer_count */ = [ uint256(0/* collect_subscriptions */),  0/* pay_subscription */,  0/* cancel_subscription */ ];
        /* initialise a transfer count variable that tracks the position being referred to in the loop below */


        for (uint256 t = 0; t < p1/* target_nums */.length; t++) {
            /* for each consensus action being targeted */

            if ( p1/* target_nums */[t][1][ 0 /* consensus_type */ ] >= 8 && p1/* target_nums */[t][1][ 0 /* consensus_type */ ] <= 10) {
                /* if the targeted consensus object is a collect_subscriptions(8), pay_subscription(9) or cancel_subscription(10) action */

                uint256 v3/* pos */ = p1/* target_nums */[t][1][ 0 /* consensus_type */ ] - 8;
                /* record the position to be used in the return arrays. collect_subscriptions would be the first, or position zero(8-8); pay_subscriptions would be the second, or position one(9-8) and cancel_subscription would be the third, or position two(10-8) */
                
                for ( uint256 e = 0; e < p1/* target_nums */[t][ 4 /* subscription-targets */ ].length; e++ ) {
                    /* for each subscription targeted in the subscription action */

                    v1/* data */[v3/* pos */][ 0 /* subscription_targets */ ][v2/* transfer_count */[v3/* pos */]] = p1/* target_nums */[t][ 4 /* collect_subscriptions */ ][e];
                    /* set the target in the subscription ids array */

                    v1/* data */[v3/* pos */][ 1 /* sender_accounts */ ][v2/* transfer_count */[v3/* pos */]] = p1/* target_nums */[t][1][ 5 /* target_contract_authority */ ];
                    /* set the sender as the targeted contract authority of the proposal */

                    if(p1/* target_nums */[t][1][ 0 /* consensus_type */ ] != 8/* collect_subscriptions */){
                        /* if the consensus type is a pay or cancel subscription action */

                        v1/* data */[v3/* pos */][ 2 /* amounts */ ][v2/* transfer_count */[v3/* pos */]] = p1/* target_nums */[t][ 5 /* amounts */ ][e];
                        /* set the amount in the amounts array */
                    }

                    v2/* transfer_count */[v3/* pos */]++;
                    /* increment the transfer count initialized above for the action type in focus */
                }
            }
        }

    }//-----RETEST_OK-----

    /* get_consensus_subscription_targets_count */
    function f252(
        uint256[21] memory p2/* consensus_type_data */
    ) private pure returns (uint256[][3][3] memory v1/* data */) {
        /* calculates and returns the data array to contain the consensus subscription actions */
        /* 
            consensus_type_data[8] = collect_subscriptions, 
            consensus_type_data[9] = pay_subscriptions, 
            consensus_type_data[10] = cancel_subscriptions  
        */
        uint256 v2/* collect_subscription_count */ = p2/* consensus_type_data */[8/* collect_subscriptions */];
        /* record the number of collect subscription actions */

        uint256 v3/* pay_subscription_count */ = p2/* consensus_type_data */[9/* pay_subscriptions */];
        /* record the number of pay subscription actions */

        uint256 v4/* cancel_subscription_count */ = p2/* consensus_type_data */[10/* cancel_subscriptions */];
        /* record the number of cancel subscription actions */
        
        v1/* data */ = [
            [
                new uint256[](v2/* collect_subscription_count */), 
                new uint256[](v2/* collect_subscription_count */), 
                new uint256[](0) 
            ],
            [ 
                new uint256[](v3/* pay_subscription_count */), 
                new uint256[](v3/* pay_subscription_count */), 
                new uint256[](v3/* pay_subscription_count */) 
            ],
            [ 
                new uint256[](v4/* cancel_subscription_count */), 
                new uint256[](v4/* cancel_subscription_count */), 
                new uint256[](v4/* cancel_subscription_count */) 
            ]
        ];
        /* set the return data array as new arrays whose length is the size specified */
    }//-----RETEST_OK-----





    //
    //
    //
    //
    //
    //
    // ------------------------TOKEN-FUNCTIONS-------------------------------
    /* calculate_reduction_proportion_ratios */
    function f40(
        uint256[][][] calldata p1/* exchanges */,
        uint256[] calldata p2/* actions */,
        uint256 p3/* block_number */
    ) external pure returns (uint256[] memory v1/* new_ratios */, uint256[] memory v12/* <15>temp_non_fungible_depth_token_transaction_class_array */) {
        /* calculates the new proportion value used in calculating the mint limit */

        v1/* new_ratios */ = new uint256[](p1.length);
        v12/* <15>temp_non_fungible_depth_token_transaction_class_array */ = new uint256[](p1.length);
        /* initialize a new array to hold the new values */

        for (uint256 t = 0; t < p1/* exchanges */.length; t++) {
            /* for each exchange in the targeted exchanges specified by the sender */

            uint256[][] memory v2/* exchange */ = p1/* exchanges */[t];
            /* get the exchanges data and store it in memory */

            v1/* new_ratios */[t] = v2/* exchange */[2][ 6 /* <6>active_block_limit_reduction_proportion*/ ];
            /* set the default new ratio as the current one  */

            v12/* <15>temp_non_fungible_depth_token_transaction_class_array */[t] = v2/* exchange */[2][ 15 /* <15>temp_non_fungible_depth_token_transaction_class */ ];

            if ( v2/* exchange */[0][3/* exchange_type */] == 5 && /* type_uncapped_supply */ v2/* exchange */[1][1/* block_limit */] != 0 ) {
                /* if the exchange type is a uncapped token and its block limit is specified */

                if ( p2/* actions */[t] == 0 && /* buy? */ p3/* block_number */ - v2/* exchange */[2][ 5 /* <5>active_mint_block */ ] >= 1 ) {
                    /* if the action is a buy action and were in a new block */

                    if ( v2/* exchange */[2][ 4 /* <4>total_minted_for_current_block */ ] > v2/* exchange */[1][ 1 /* <1>max_block_buyable_amount */ ] ) {
                        /* if limit has been exceeded, reduce [2]<6>active_block_limit_reduction_proportion value by  [1]<6>block_limit_reduction_proportion */

                        uint256 v3/* block_limit_sensitivity */ = v2/* exchange */[1][ 12 /* <12>block_limit_sensitivity */ ];
                        /* initialize a variable that contains the block limit sensitivity */

                        if (v3/* block_limit_sensitivity */ == 0) {
                            v3/* block_limit_sensitivity */ = 1;
                        }
                        /* if the sensitivity value is undefined, set it to one */

                        uint256 v4/* factor */ = f11/* calculate_factor */( v2/* exchange */[1][ 5 /* <5>internal_block_halfing_proportion */ ], v2/* exchange */[2][ 4 /* <4>total_minted_for_current_block */ ], v2/* exchange */[1][ 1 /* <1>max_block_buyable_amount */ ] );
                        /* calculate the factor value used to calculate the new proportion and mint limit */

                        if(v4/* factor */ != 0){
                            /* if the factor derived is non-zero */

                            uint256 v5/* new_proportion */ = f5/* calculate_share_of_total */( v2/* exchange */[2][ 6 /* <6>active_block_limit_reduction_proportion */ ], f3/* compound */( v2/* exchange */[1][ 6 /* <6>block_limit_reduction_proportion */ ], v4/* factor */ * v3/* block_limit_sensitivity */ ) );
                            /* calculate the new proportion as a compounded share of the active block limit reduction value(<6>active_block_limit_reduction_proportion) */

                            v1/* new_ratios */[t] = v5/* new_proportion */  == 0 ? 1 : v5/* new_proportion */ ;
                            /* if the calculated value is zero, set it to one instead */
                        }

                        if ( p3/* block_number */ - v2/* exchange */[2][ 5 /* <5>active_mint_block */ ] > 1 ) {
                            /* limit was exceeded in a block before the previous block */

                            uint256 v6/* numerator */ = v1/* new_ratios */[t] * (10**18); /* (denominator -> 10**18) */
                            /* initialize a numerator variable thats the product of the new active reduction proportion value(<6>active_block_limit_reduction_proportion) and 10**18 */

                            uint256 v7/* power */ = (p3/* block_number */ - v2/* exchange */[2][ 5 /* <5>active_mint_block */ ]) - 1;
                            /* initialize a power variable thats the difference between the current block number and the last block number that the exchange was involved in a mint action less one */

                            v1/* new_ratios */[t] = f14/* calculate_new_increased_active_block_limit_reduction_proportion */( v6/* numerator */, v7/* power */, v2/* exchange */[1][ 8 /* <8>block_reset_limit */ ], v2/* exchange */[1][ 6 /* <6>block_limit_reduction_proportion */ ] );
                            /* recalculate the new increased active block limit since the value has to be pushed up for the blocks that no minting took place */
                        }
                    } else {
                        /* limit has not been exceeded, so increase [2]<6>active_block_limit_reduction_proportion
                            value by [1]<6>block_limit_reduction_proportion, if value is less than 100%, 
                        */
                        if ( v2/* exchange */[2][ 6 /* <6>active_block_limit_reduction_proportion */ ] < 10**18 /* (100%) */ ) {
                            /* if the value is less than 100% */

                            uint256 v8/* numerator */ = v2/* exchange */[2][ 6/* <6>active_block_limit_reduction_proportion */] * (10**18); /* (denominator -> 10**18) */
                            /* initialize a numerator value as the product of the active block limit value and 10**18 */

                            uint256 v9/* power */ = p3/* block_number */ - v2/* exchange */[2][ 5 /* <5>active_mint_block */ ];
                            /* initialize a power variable thats the difference between the current block number and the last block number that the exchange was involved in a mint action  */

                            v1/* new_ratios */[t] = f14/* calculate_new_increased_active_block_limit_reduction_proportion */( v8/* numerator */, v9/* power */, v2/* exchange */[1][ 8 /* <8>block_reset_limit */ ], v2/* exchange */[1][ 6 /* <6>block_limit_reduction_proportion */ ] );
                            /* recalculate the new increased active block limit since the value has to be pushed up for the blocks that no minting took place */
                        }
                    }
                }
            }  
        }
    }//-----RETEST_OK-----

    /* calculate_new_increased_active_block_limit_reduction_proportion */
    function f14(
        uint256 p1/* numerator */,
        uint256 p2/* power */,
        uint256 p3/* block_reset_limit */,
        uint256 p4/* block_limit_reduction_proportion */
    ) private pure returns (uint256) {
        /* 
            it: calculates the new active block limit proportion if the block limit was not exceeded in preceding blocks
            numerator = active_block_limit_reduction_proportion * (10**18)
            eg. if active_block_limit_reduction_proportion = 81% and power = 2 and block_limit_reduction_proportion = 90%
                new_limit = 81*100 = 8100
                then 90% => 0.9^2 = 0.81 => 81%
                then 8100 ÷ 81 = 100%
        */
        if (p2/* power */ > p3/* block_reset_limit */ && p3/* block_reset_limit */ != 0) {
            /* if a reset limit exists and the power is greater than it */

            p2/* power */ = p3/* block_reset_limit */;
            /* set the power to be the reset limit */
        }
        else if(p2/* power */ >= 35){
            /* if the power is greater than thirtyfive */

            p2/* power */ = 35;
            /* set it to 35 */
        }
        uint256 v1/* denominator */ = f3/* compound */(p4/* block_limit_reduction_proportion */, p2/* power */);
        /* intialize a denominator variable thats the compounded value of the block limit reduction proportion using the power */

        uint256 v2/* new_val */ = p1/* numerator */ / v1/* denominator */;
        /* then set the return value as the numerator divided by the denominator */

        if ( v2/* new_val */ > 10**18 /* (denominator -> 10**18) */ ) {
            /* if the value is more than 100% */
            v2/* new_val */ = 10**18; /* (denominator -> 10**18) */
            /*  set it to 100% */
        }
        return v2/* new_val */;
    }//-----TEST_OK-----

    /* calculate_factor */
    function f11(
        uint256 p1/* reduction_proportion */,
        uint256 p2/* total_minted_for_current_block */,
        uint256 p3/* max_block_buyable_amount */
    ) private pure returns (uint256) {
        /* if total_minted_for_current_block exceeds max_block_mintable_amount, the amount of spend that can be minted is reduced
            (100%/50%)*(200,000,000/100,000,000) = 2*2 = 4
            then the factor_amount = 10,000,000(active_mintable_amount) / 4 = 2,500,000
        */
        if(p1/* reduction_proportion */ == 0 || p2/* total_minted_for_current_block */ == 0 || p3/* max_block_buyable_amount */==0){
            /* if one of the values passed is zero, return zero */
            return 0;
        }
        return ((10**18) / p1/* reduction_proportion */) * ((p2/* total_minted_for_current_block */ == 0 ? 1 /* 1 to avoid exception */ : p2/* total_minted_for_current_block */ ) / p3/* max_block_buyable_amount */);
    } //-----TEST_OK-----


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




    function run() external pure returns (uint256){
        return 42;
    }
}