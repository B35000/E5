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





    function run() external pure returns (uint256){
        return 42;
    }
}