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

/* SubscriptionHelperFunctions */
library F3 {
    uint256 constant default_time_unit = 3180;

    struct NumData {
        mapping(uint256 => mapping(uint256 => mapping(uint256 => uint256))) num;
        mapping(uint256 => mapping(uint256 => mapping(uint256 => uint256))) num_str_metas;
        mapping(uint256 => mapping(uint256 => mapping(uint256 => uint256))) int_int_int;
    }

    /* record_new_objects_data */
    function f103(
        uint256 p1/* new_obj_id */,
        uint256[][] calldata p2/* new_obj_id_num_data */,
        NumData storage p3/* self */
    ) external {
        /* records a new subscription objects data in its specified location */
        
        mapping(uint256 => mapping(uint256 => uint256)) storage v1/* new_obj_id_nums */ = p3/* self */.num[p1/* new_obj_id */];
        /* initialize a storage object mapping that points to the new objects data location */

        for (uint256 e = 1; e < p2/* new_obj_id_num_data */.length; e++) {
            /* for each array in the new objects specified data */

            for (uint256 v = 0; v < p2/* new_obj_id_num_data */[e].length; v++) {
                /* for each item in the array in focus */
                
                if (p2/* new_obj_id_num_data */[e][v] != 0) {
                    /* if the item is non-zero */

                    v1/* new_obj_id_nums */[e][v] = p2/* new_obj_id_num_data */[e][v];
                    /* record its data in the specified location */
                }
            }
        }
        p3/* self */.num_str_metas[p1/* new_obj_id */][ 1 /* num_data */ ][2] = p2/* new_obj_id_num_data */[2].length;
    }//-----TEST_OK-----



    /* get_transfer_data_for_collect_or_pay_subscription_payments */
    function f46(
        uint256[] calldata p1/* targets */,
        uint256[][][] memory p2/* targets_data */,
        uint256[] memory p3/* amounts */,
        uint256 p4/* action */,
        uint256 p5/* sender_account */,
        uint256[] calldata p6/* sender_accounts */
    ) private pure returns (uint256[][5] memory v1/* data */) {
        /* calculates, sets and returns a two dimentional array containing data required for running transfers to or from the subscription object */
        /* 
            data[0] = exchange_ids , data[1] = amounts , data[2] = senders , data[3] = receivers, data[4] = depths
            <1>subs_multi_transfer <2>contracts_multi_transfer
        */
        
        v1/* data */ = f45/* get_mult_exchanges_count */(p2/* targets_data */);
        /* initializes the return array as the return data from the get_mult_exchnages_count function */

        uint256 v2/* transfer_count */ = 0;
        /* initialize a transfer count variable to track the position of the exchanges being focused on */

        for (uint256 t = 0; t < p1/* targets */.length; t++) {
            /* for each target subscription object */

            uint256 v4/* sender */ = p5/* sender_account */;
            /* initialize a variable that holds the sender account id */

            if(v4/* sender */ == 0){
                /* if sender_account value is zero, sender is in sender_accounts array */

                v4/* sender */ = p6/* sender_accounts */[t];
                /* reset the sender value from the sender_accounts array */
            }

            for ( uint256 e = 0; e < p2/* targets_data */[t][ 2 /* exchanges */ ].length; e++ ) {
                /* for each exchange used in buyint the subscription object */

                v1/* data */[ 0 /* exchange_ids */ ][v2/* transfer_count */] = p2/* targets_data */[t][ 2 /* exchanges */ ][e];
                /* set the exchange id from the exchange array of the subscription object */

                v1/* data */[ 1 /* amounts */ ][v2/* transfer_count */] = (p2/* targets_data */[t][ 3 /* amounts */ ][e] * p3/* amounts */[t]);
                /* set the amount as the product of the amount specified with the amount set for each token used in buying the subscription object */
                
                if ( p4/* action */ == 0 /* pay_subscription */ ) {
                    /* if the action is a pay subscription action */

                    v1/* data */[ 2 /* senders */ ][v2/* transfer_count */] = v4/* sender */;
                    /* record the sender in the sender array */
                    
                    if ( p2/* targets_data */[t][1][ 2 /* <2>can_cancel_subscription(0 if false, 1 if true) */ ] != 0 ) { 
                        /* if the subscription object type is cancellable */
                        
                        v1/* data */[ 3 /* receivers */ ][v2/* transfer_count */] = p1/* targets */[t]; /* subscription object id */
                        /* set the receiver of the transfer to be the subscription object itself */
                    } else { 
                        /* if the subscription object type is non-cancellable */
                        
                        uint256 v3/* recipient */ = p2/* targets_data */[t][1][ 6 /* <6>subscription_beneficiary */ ];
                        /* set the recipient as the subscription beneficiary */
                        
                        if(v3/* recipient */ == 0){
                            /* if no subscription beneficiary has been defined */

                            v3/* recipient */ = p2/* targets_data */[t][1][ 0 /* <0>target_authority_id */ ];
                            /* set the target authority as the beneficiary */
                        }

                        v1/* data */[ 3 /* receivers */ ][v2/* transfer_count */] = v3/* recipient */;
                        /* set the receiver of the transfer to be the subscription authority */
                    }
                } else {
                    /* collect subscription or cancel subscription */
                    
                    v1/* data */[ 2 /* senders */ ][v2/* transfer_count */] = p1/* targets */[t]; /* subscription object id */
                    /* set the sender of the transfer to be the subscription object itself */
                    
                    if(p4/* action */ == 2/* collect_subscription */){
                        /* if the action is a collect subscription action */

                        uint256 v3/* recipient */ = p2/* targets_data */[t][1][ 6 /* <6>subscription_beneficiary */ ];
                        /* set the recipient as the subscription beneficiary */
                        
                        if(v3/* recipient */ == 0){
                            /* if no subscription beneficiary has been defined */

                            v3/* recipient */ = p2/* targets_data */[t][1][ 0 /* <0>target_authority_id */ ];
                            /* set the target authority as the beneficiary */
                        }

                        v1/* data */[ 3 /* receivers */ ][v2/* transfer_count */] = v3/* recipient */;
                    }
                    else{
                        /* action is cancel subscription */

                        v1/* data */[ 3 /* receivers */ ][v2/* transfer_count */] = v4/* sender */;
                        /* if the action is a cancel subscription, the receiver should be the sender account */
                    }
                }

                v1/* data */[ 4 /* amount_depths */ ][v2/* transfer_count */] = p2/* targets_data */[t][ 4 /* exchanges */ ][e];
                /* set the depth value for the transfer */
                
                v2/* transfer_count */++;
                /* increment the transfer count value */
            }
        }
    }//-----RETEST_OK-----

    /* get_mult_exchanges_count */
    function f45(uint256[][][] memory p1/* targets_data */) 
    private pure returns (uint256[][5] memory v1/* data */) {
        /* initializes and returns a two dimentional array object that contains the data used in running the transfers to and from the subscription object */
        /* data[0] = exchange_ids , data[1] = amounts , data[2] = senders , data[3] = receivers */
        
        uint256 v2/* transfer_count */ = 0;
        /* initialize a transfer count variable that holds the total amount of transfers set to take place */

        for (uint256 t = 0; t < p1/* targets_data */.length; t++) {
            /* for each target subscription */
            
            v2/* transfer_count */ += p1/* targets_data */[t][ 2 /* exchanges */ ].length;
            /* increment the transfer count by the number of exchanges used to buy the subscription */
        }
        v1/* data */ = [
            new uint256[](v2),
            new uint256[](v2),
            new uint256[](v2),
            new uint256[](v2),
            new uint256[](v2)
        ];
        /* initialize and return the two dimentional array containing five arrays whose length is the transfer count value calculated above */
    }//-----TEST_OK-----




    /* run_subscription_checkers */
    function f43(uint256[][][] memory p1/* subs_data */) private pure {
        /* runs checkers on multiple subscription items */
        
        for (uint256 t = 0; t < p1/* subs_data */.length; t++) {
            /* for each subscription target specified */
            
            f44/* run_checker */(p1/* subs_data */[t]);
            /* runs the checker function */
        }
    }//-----TEST_OK-----

    /* run_checker */
    function f44(uint256[][] memory p1/* subscription_nums */) private pure {
        /* checks to ensure the subscription object is valid */
        
        require( 
            p1/* subscription_nums */[ 2 /* exchange_ids */ ].length != 0 && 
            p1/* subscription_nums */[1][ 2 /* can_cancel_subscription */ ] <= 1 && 
            p1/* subscription_nums */[1][ 4 /* <4>minimum_cancellable_balance_amount */ ] <= 10**63 && 
            p1/* subscription_nums */[1][ 5 /* <5>time_unit */ ] <= 10**36
        );
        /* ensures the exchanges set are not zero in length and the can cancel subscription, the minimum cancellable amount and the set time unit is valid */
    }//-----RETEST_OK-----

    /* start_run_checker */
    function f75(uint256 p1/* obj_id */, NumData storage p2/* self */) external view {
        /* starts the checkers for confirming subscription objects are valid */
        
        uint256[][] memory v1/* subscription_nums */ = f73/* read_id */(p1/* obj_id */, p2/* self */);
        /* fetches the subscription object data and stores it in a two dimentional array object */

        f44/* run_checker */(v1/* subscription_nums */);
        /* runs the checker that validates the subscription's data */
    }//-----TEST_OK-----





    /* execute_pay_or_cancel_subscription */
    function f107(
        uint256[] calldata p1/* targets */,
        uint256[] calldata p2/* amounts */,
        uint256 p3/* sender_account */,
        uint256 p4/* action */,
        NumData storage p5/* self */,
        uint256[] calldata p6/* sender_accounts */
    ) external returns (uint256[][5] memory v1/* data */){
        /* function code used for paying or cancelling a subscription payment */

        f72/* require_subscription */(p1/* targets */, p5/* self */);
        /* checks to ensure the supplied target ids are subscription objects */

        for (uint256 t = 0; t < p1/* targets */.length; t++) {
            /* for each subscription target */
            
            mapping(uint256 => mapping(uint256 => uint256)) storage v2/* target_data */ = p5/* self */.int_int_int[ p1/* targets */[t] ];
            /* initialize a storage object mapping that points to the targets payment data */
            
            mapping(uint256 => uint256) storage v3/* target_config */ = p5/* self */.num[ p1/* targets */[t] ][1];
            /* initialize a storage mapping that points to the subscription targets configuration data */

            uint256 v5/* time_unit */ = v3/* target_config */[5/* <5>time_unit */];
            /* initialize a variable containing the set time unit for the subscription */

            if(v5/* time_unit */ == 0){
                /* if the time unit set in the subscription is 0 */

                v5/* time_unit */ = default_time_unit;
                /* reset it to the default time unit */
            }

            uint256 v7/* sender */ = p3/* sender_account */;
            /* initialize a variable that holds the sender account id */

            if(v7/* sender */ == 0){
                /* if sender_account value is zero, sender is in sender_accounts array */

                v7/* sender */ = p6/* sender_accounts */[t];
                /* reset the sender value from the sender_accounts array */
            }
            
            if ( p4/* action */ == 0 /* pay_subscription */ ) {
                /* if the action is a pay subscription action */

                require( p2/* amounts */[t] >= v3/* target_config */[ 1 /* <1>minimum_buy_amount */ ] && p2/* amounts */[t] != 0 );
                /* ensure amount passed is greater than minimum and non-zero */

                if(v3/* target_config */[3/* <3>maximum_buy_amount */] != 0){
                    /* if a maximum buy amount has been specified */

                    require(p2/* amounts */[t] <= v3/* target_config */[3/* <3>maximum_buy_amount */]);
                    /* ensure amount doesn't exceed maximum buy amount */
                }
                
                if ( block.timestamp > v2/* target_data */[ 1 /* last_time_paid */ ][v7/* sender */] + v2/* target_data */[ 2 /* time_paid_for */ ][v7/* sender */] ) {
                    /* if first time paying or sender's last time paying was a long time ago */
                    
                    v2/* target_data */[ 1 /* last_time_paid */ ][v7/* sender */] = block.timestamp;
                    /* record the senders last time paid as current timestamp */

                    v2/* target_data */[ 2 /* time_paid_for */ ][v7/* sender */] = (p2/* amounts */[t] * v5/* time_unit */);
                    /* record the time paid for as the product of the amount specified by the sender and the default time unit which is a contract constant value */
                } else {
                    /* its not the first time the sender is paying for the subscription or the sender is adding to an existing payment that is still valid */
                    
                    v2/* target_data */[ 2 /* time_paid_for */ ][v7/* sender */] += (p2/* amounts */[t] * v5/* time_unit */);
                    /* if sender has already paid, it just adds to their balance */
                }
                if ( v3/* target_config */[ 2 /* <2>can_cancel_subscription(0 if false, 1 if true) */ ] != 0 ) {
                    /* if the subscription is cancellable */
                    
                    v2/* target_data */[ 3 /* unclaimed_time_paid */ ][v7/* sender */] += (p2/* amounts */[t] * v5/* time_unit */);
                    /* it adds to unclaimed time paid balance */
                }

            } else {
                /* action is a cancel subscription action */
                
                require( p2/* amounts */[t] != 0 && v2/* target_data */[ 1 /* last_time_paid */ ][v7/* sender */] + v2/* target_data */[ 2 /* time_paid_for */ ][v7/* sender */] > block.timestamp && v3/* target_config */[ 2 /* <2>can_cancel_subscription(0 if false, 1 if true) */ ] != 0 );
                /* require amount is non-zero, sender has active subscription and subscription is cancellable */
                
                v2/* target_data */[ 2/* time_paid_for */ ][v7/* sender */] -= (p2/* amounts */[t] * v5/* time_unit */);
                /* decrement the time paid for by the amount specified by the sender */

                v2/* target_data */[ 3/* unclaimed_time_paid */ ][v7/* sender */] -= (p2/* amounts */[t] * v5/* time_unit */);
                /* updates the unclaimed time paid for value as well for the sender */

                
                if(v3/* target_config */[ 4 /* <4>minimum_cancellable_balance_amount */ ] != 0){
                    /* if a minimum cancellable amount has been defined */
                    
                    require( v2/* target_data */[ 2 /* time_paid_for */ ][v7/* sender */] > (v5/* time_unit */ * v3/* target_config */[ 4 /* <4>minimum_cancellable_balance_amount */ ]) );
                }
                else{
                    require( v2/* target_data */[ 2 /* time_paid_for */ ][v7/* sender */] > v5/* time_unit */ );
                }
                /* ensure remaining time paid for is more than one time unit */
            }
        }
        uint256[][][] memory v4/* targets_data */ = f74/* read_ids */(p1/* targets */, p5/* self */);
        /* read and set the subscription target data in memory */

        v1/* data */ = f46/* get_transfer_data_for_collect_or_pay_subscription_payments */( p1/* targets */, v4/* targets_data */, p2/* amounts */, p4/* action */, p3/* sender_account */, p6/* sender_accounts */);
        /* calls and gets the transfer data for collecting or paying subscription transfer actions */
    }//-----RETEST_OK-----

    /* collect_subscriptions */
    function f106(
        uint256[] calldata p1/* targets */,
        uint256[][] calldata p2/* payer_accounts */,
        uint256 p3/* sender_account */,
        NumData storage p4/* self */,
        uint256[] calldata p5/* sender_accounts */
    ) external returns (uint256[][5] memory v1/* data */, uint256[] memory v2/* target_collectible_block_amounts */) {
        /* function code used for performing collect subscription actions when collecting from cancellable subscription objects */
        
        v2/* target_collectible_block_amounts */ = new uint256[](p1.length);
        /* initialize an array with its length being the number of targets specified which will house the total number of time units that can be reclaimed */

        f72/* require_subscription */(p1/* targets */, p4/* self */);
        /* check to ensure the targets passed are subscription objects */

        for (uint256 t = 0; t < p1/* targets */.length; t++) {
            /* for each subscription target specified */

            mapping(uint256 => uint256) storage v3/* target_config */ = p4/* self */.num[p1/* targets */[t]][1];
            /* initialize a storage mapping that points to the subscription object's data */

            uint256 v7/* sender */ = p3/* sender_account */;
            /* initialize a variable that holds the sender account id */

            if(v7/* sender */ == 0){
                /* if sender_account value is zero, sender is in sender_accounts array */

                v7/* sender */ = p5/* sender_accounts */[t];
                /* reset the sender value from the sender_accounts array */
            }

            require( v3/* target_config */[ 0 /* <0>target_authority_id */ ] == v7/* sender */ && v3/* target_config */[ 2 /* <2>can_cancel_subscription(0 if false, 1 if true) */ ] != 0 );
            /* ensure the sender is the authority of the subscription and the subscription is cancellable */

            uint256 v4/* total_target_collectible_block_time_amount */ = 0;
            /* initialize a variable to hold the total amount of time that can be claimed by the subscription owner */
            
            for (uint256 a = 0; a < p2/* payer_accounts */[t].length; a++) {
                /* for each payer specified by the sender */
                
                v4/* total_target_collectible_block_time_amount */ += f105/* get_collectible_amount */(p1/* targets */[t], p2/* payer_accounts */[t][a], p4/* self */);
                /* increment the total target collectible time amount by the return value from the get collectible amount function */
            }
            uint256 v6/* time_unit */ = v3/* target_config */[5/* <5>time_unit */];
            /* initialize a variable containing the set time unit for the subscription */

            if(v6/* time_unit */ == 0){
                /* if the time unit set in the subscription is 0 */

                v6/* time_unit */ = default_time_unit;
                /* reset it to the default time unit */
            }

            v2/* target_collectible_block_amounts */[t] = (v4/* total_target_collectible_block_time_amount */ / v6/* time_unit */);
            /* set the block amount for the total amount of time that can be reclaimed for the specific subscription object, as the total time divided by the default time unit */
        }
        uint256[][][] memory v5/* targets_data */ = f74/* read_ids */(p1/* targets */, p4/* self */);
        /* initialize a three dimentional array to contain the subscription data for all the targets specified */

        v1/* data */ = f46/* get_transfer_data_for_collect_or_pay_subscription_payments */(p1/* targets */, v5/* targets_data */, v2/* target_collectible_block_amounts */, 2/* action */, p3/* sender_account */, p5/* sender_accounts */);
        /* gets the data used for performing transfer action for collecting or cancelling subscription payments */
    }//-----RETEST_OK-----

    /* get_collectible_amount */
    function f105(
        uint256 p1/* target */, 
        uint256 p2/* payer_account */, 
        NumData storage p3/* self */
    ) private returns (uint256) {
        /* gets the total amount of time that can be reclaimed by the subscription owner at the current timestamp */
        
        mapping(uint256 => mapping(uint256 => uint256)) storage v1/* target_data */ = p3/* self */.int_int_int[p1/* target */];
        /* initialize a storage mapping that points to the targets payment data */
        
        uint256 v2/* last_time_paid */ = v1/* target_data */[ 1 /* last_time_paid */ ][p2/* payer_account */];
        /* initialize a variable that holds the senders last time paid value */
        
        uint256 v3/* time_paid_for */ = v1/* target_data */[ 2 /* time_paid_for */ ][p2/* payer_account */];
        /* initialize a variable that holds the senders time paid for value */
        
        uint256 v4/* unclaimed_time_paid */ = v1/* target_data */[ 3 /* unclaimed_time_paid */ ][p2/* payer_account */];
        /* initialize a variable that holds the senders unclaimed time paid for */

        require(v2/* last_time_paid */ != 0);
        /* require that the sender has paid for the subscription before */

        uint256 v5/* time_amount */ = 0;
        /* initialize a time amount variable set to zero */

        if (block.timestamp > v2/* last_time_paid */ + v3/* time_paid_for */) {
            /* if the sum of last time paid for and the time paid for is less than the current timestamp, meaning the target account's subscription has expired */
            
            v5/* time_amount */ += v4/* unclaimed_time_paid */;
            /* increment the time amount by the unclaimed time paid since the subscription time has expired */

            v1/* target_data */[ 3 /* unclaimed_time_paid */ ][p2/* payer_account */] = 0;
            /* reset the unclaimed time paid for the target account to be zero */
        } else {
            /* the target account has got time in the subscription that has not expired yet */
            
            uint256 v6/* uncollectible_amount */ = (v2/* last_time_paid */ + v3/* time_paid_for */) - block.timestamp;
            /* calculate the amount of time that cannot be collected yet using the current time */

            uint256 v7/* collectible_amount */ = v4/* unclaimed_time_paid */ - v6/* uncollectible_amount */;
            /* calculate the collectible amount of time from the unclaimed time paid for */

            v1/* target_data */[ 3 /* unclaimed_time_paid */ ][p2/* payer_account */] -= v7/* collectible_amount */;
            /* reduce the unclaimed time amount for the sender by the collectible amount since the time is being claimed */

            v5/* time_amount */ += v7/* collectible_amount */;
            /* increase the time amount by the collectible amount calculated above */
        }

        return v5/* time_amount */;
        /* return the total amount of time */
    }//-----TEST_OK-----




    /* modify_subscription */
    function f104(
        uint256[][5] calldata p1/* data */,
        uint256 p2/* sender_account */,
        NumData storage p3/* self */
    ) external {
        /* modifies subscription objects */

        f72/* require_subscription */(p1/* data */[ 0 /* targets */ ], p3/* self */);
        /* checks to ensure the specified targets are subscription objects */

        for ( uint256 t = 0; t < p1/* data */[ 0 /* targets */ ].length; t++ ) {
            /* for each targeted subscription object */
            
            uint256 v1/* sender */ = p1/* data */[ 4 /* authority */ ].length != 0 ? p1/* data */[ 4 /* authority */ ][t] : p2/* sender_account */;
            /* initialize a sender variable as either the value in the array containing the authority data if exists or the sender of the transaction */
            
            mapping(uint256 => mapping(uint256 => uint256)) storage v2/* target_nums */ = p3/* self */.num[ p1/* data */[ 0 /* targets */ ][t] ];
            /* initializes a storage object that points to the subscription data */

            require( 
                p1/* data */[ 0 /* targets */ ][t] > 1000 && 
                v2/* target_nums */[1][ 0 /* <0>target_authority_id */ ] == v1/* sender */ && 
                (p1/* data */[ 1 /* target_array_pos */ ][t] == 1 || p1/* data */[ 1 /* target_array_pos */ ][t] == 2 || p1/* data */[ 1 /* target_array_pos */ ][t] == 3 || p1/* data */[ 1 /* target_array_pos */ ][t] == 4) 
            );
            // prevents modifying the data type array and ensures the sender is the correct authority

            if ( p1/* data */[ 1 /* target_array_pos */ ][t] == 1 ) {
                /* if the subscription configuration is being targeted */
                
                require( p1/* data */[ 2 /* target_array_items */ ][t] != 2 /* <2>can_cancel_subscription(0 if false, 1 if true) */ );
                /* prevent modifying subscription type */

                if ( v2/* target_nums */[1][ 2 /* <2>can_cancel_subscription(0 if false, 1 if true) */ ] != 0 ) {
                    /* if subscription can be cancelled */

                    require( p1/* data */[ 2 /* target_array_items */ ][t] != 5 /* <5>time_unit */ );
                    /* prevent modifying time unit */
                }
            }
            
            if ( v2/* target_nums */[1][ 2 /* <2>can_cancel_subscription(0 if false, 1 if true) */ ] != 0 ) {
                /* if subscription can be cancelled */
                
                require(p1/* data */[ 1 /* target_array_pos */ ][t] != 2 && p1/* data */[ 1 /* target_array_pos */ ][t] != 3 );
                /* this prevents modifying exchanges and amounts */

            }
            
            if(p1/* data */[ 1 /* target_array_pos */ ][t] == 2){
                /* if the targeted array is the exchanges array */

                mapping(uint256 => uint256) storage v3/* source_token_count */ = p3/* self */.num_str_metas[ p1/* data */[ 0 /* targets */ ][t] ][ 1 /* num_data */ ];
                /* initialize a storage object that points to the subscription's source token count value that records how many tokens are used in paying for the subscription */
                
                require(p1/* data */[ 2/* target_array_items */ ][t] <= v3/* source_token_count */[2/* source_tokens_count */]);
                /* ensure that the specified array item is one of the existing exchanges or a new exchange thats being added */
                
                if(p1/* data */[ 2/* target_array_items */ ][t] == v3/* source_token_count */[2/* source_tokens_count */]){
                    /* if a new exchange is being added */

                    v3/* source_token_count */[2/* source_tokens_count */] += 1;
                    /* increment the source token count variable since a new exchange has been added */
                }
            }

            v2/* target_nums */[ p1/* data */[ 1 /* target_array_pos */ ][t] ][ p1/* data */[ 2 /* target_array_items */ ][t] ] = p1/* data */[ 3 /* new_items */ ][t];
            /* set and update the data accordingly */
        }

        uint256[][][] memory v4/* targets_data */ = f74/* read_ids */(p1/* data */[ 0 /* targets */ ], p3/* self */);
        /* initialize a three dimentional array to contain the subscription data for all the targets specified */

        f43/* run_subscription_checkers */(v4/* targets_data */);
        /* recheck the modified subscriptions to ensure their configuration remains valid */
    }//-----RETEST_OK-----




    /* require_subscription */
    function f72(uint256[] memory p1/* _ids */, NumData storage p2/* self */) private view {
        /* checks to ensure the ids passed point to subscription objects */

        for (uint256 r = 0; r < p1/* _ids */.length; r++) {
            /* for each id passed */

            uint256 v1/* source_tokens_count */ = p2/* self */.num_str_metas[ p1/* _ids */[r] ][ 1 /* num_data */ ][2];
            /* get the number of tokens used for buying the subscription */

            require(v1/* source_tokens_count */ != 0);
            /* ensure there exists source tokens since no subscription can have no source tokens */
        }
    }//-----TEST_OK-----

    /* read_ids */
    function f74(uint256[] memory p1/* _ids */, NumData storage p2/* self */) 
    public view returns (uint256[][][] memory v1/* ints */) {
        /* reads multiple subscription objects and stores and returns them in a three dimentional array */
        
        v1/* ints */ = new uint256[][][](p1.length);
        /* initialize a new three dimentional array whose length is the number of targets specified */

        for (uint256 r = 0; r < p1/* _ids */.length; r++) {
            /* for each subscription target */

            v1/* ints */[r] = f73/* read_id */(p1/* _ids */[r], p2/* self */);
            /* sets the subscription object data in its specific position in the return variable */
        }
    }//-----TEST_OK-----

    /* read_id */
    function f73(uint256 p1/* id */, NumData storage p2/* self */) 
    public view returns (uint256[][] memory v6/* return_data */) {
        /* reads the data for a specified subscription id */

        v6/* return_data */ = new uint256[][](5);/* data_len */
        /* initialize a return variable as a two dimentional array whose length is five */

        uint256 v1/* source_tokens_count */ = p2/* self */.num_str_metas[p1/* id */][ 1 /* num_data */ ][2];
        /* record the source token count in a variable */

        uint256[5] memory v2/* data */ = [ 0, 7, v1/* source_tokens_count */, v1/* source_tokens_count */, v1/* source_tokens_count */ ];
        /* record the lengths of each array for the target subscription */

        mapping(uint256 => mapping(uint256 => uint256)) storage v3/* id_nums */ = p2/* self */.num[p1/* id */];
        /* intialize a storage mapping that points to the subscription object's data */

        for ( uint256 s = 0; s < 5; /* data_len */ s++ ) {
            /* for each of the subscription's arrays being targeted */

            uint256 v4/* items_len */ = v2/* data */[s];
            /* record the number of items in the subscription array in focus */

            v6/* return_data */[s] = new uint256[](v4);
            /* set the array's position as a new array whose lenght is the items_len specified above */

            mapping(uint256 => uint256) storage v5/* id_array_nums */ = v3/* id_nums */[s];
            /* initialize a storage mapping that points to the array's items in focus */

            for (uint256 t = 0; t < v4/* items_len */; t++) {
                /* for each item in the array in focus */

                v6/* return_data */[s][t] = v5/* id_array_nums */[t];
                /* read and record the targeted array item in the return data */
            }
        }
    }//-----RETEST_OK-----





    /* scan_int_int_int */
    function f168(uint256[][] calldata p1/* _ids */, NumData storage p2/* self */) 
    external view returns (uint256[] memory v1/* data */) {
        /* scans the int_int_int storage object for its data */

        v1/* data */ = new uint256[](p1.length);
        /* intializes the return value as a new array whose length is the number of ids targeted */

        for (uint256 t = 0; t < p1/* _ids */.length; t++) {
            /* for each targeted value specified */

            v1/* data */[t] = p2/* self */.int_int_int[ p1/* _ids */[t][0] ][ p1/* _ids */[t][1] ][ p1/* _ids */[t][2] ];
            /* set the data value at the specified location in the return variable position */
        }
    }//-----TEST_OK-----

    /* get_subscription_time_value */
    function f229(
        uint256[] calldata p1/* _ids */, 
        NumData storage p2/* self */, 
        uint256[][] calldata p3/* accounts */
    ) external view returns (uint256[][] memory v1/* data */) {
        /* scans the int_int_int storage object for its subscription payment data and returns the remaining time left for every account specified that has a valid subscription payment */

        v1/* data */ = new uint256[][](p1.length);
        /* intializes the return value as a new array whose length is the number of ids targeted */

        for (uint256 t = 0; t < p1/* _ids */.length; t++) {
            /* for each targeted value specified */
  
            mapping(uint256 => mapping(uint256 => uint256)) storage v2/* target_data */ = p2/* self */.int_int_int[p1/* _ids */[t]];
            /* initialize a storage mapping that points to the targets payment data */

            uint256[] memory v6/* account_subscription_data */ = new uint256[](p3/* accounts */[t].length);
            /* initialize an array to contain the subscription data for the accounts specified for each target subscription */

            for (uint256 a = 0; a < p3/* accounts */[t].length; a++) {
                /* for each account specified */

                uint256 v3/* last_time_paid */ = v2/* target_data */[ 1 /* last_time_paid */ ][p3/* accounts */[t][a]];
                /* initialize a variable that holds the senders last time paid value */
            
                uint256 v4/* time_paid_for */ = v2/* target_data */[ 2 /* time_paid_for */ ][p3/* accounts */[t][a]];
                /* initialize a variable that holds the senders time paid for value */

                if (v3/* last_time_paid */ + v4/* time_paid_for */ > block.timestamp) {
                    /* if the accounts subscription is still valid */

                    v6/* account_subscription_data */[a] = (v3/* last_time_paid */ + v4/* time_paid_for */) - block.timestamp;
                    /* record the remaining time for the account specified. This should be the uncollectible amount. */
                }
            }

            v1/* data */[t] = v6/* account_subscription_data */;
            /* set the subscription data for the specified accounts for the targeted subscription object in its correct position */
        }
    }//-----CHANGED-----

    /* get_subscription_collectible_time_value */
    function f235(
        uint256[] calldata p1/* _ids */, 
        NumData storage p2/* self */, 
        uint256[][] calldata p3/* accounts */
    ) external view returns (uint256[][] memory v1/* data */) {
        /* scans the int_int_int storage object for its subscription payment data and returns the amount of time that can be claimed by the subscription owner as payment as time progresses */

        v1/* data */ = new uint256[][](p1.length);
        /* intializes the return value as a new array whose length is the number of ids targeted */

        for (uint256 t = 0; t < p1/* _ids */.length; t++) {
            /* for each targeted value specified */
  
            mapping(uint256 => mapping(uint256 => uint256)) storage v2/* target_data */ = p2/* self */.int_int_int[p1/* _ids */[t]];
            /* initialize a storage mapping that points to the targets payment data */

            uint256[] memory v7/* account_subscription_data */ = new uint256[](p3/* accounts */[t].length);
            /* initialize an array to contain the subscription data for the accounts specified for each target subscription */

            for (uint256 a = 0; a < p3/* accounts */[t].length; a++) {
                /* for each account specified */

                uint256 v3/* last_time_paid */ = v2/* target_data */[ 1 /* last_time_paid */ ][p3/* accounts */[t][a]];
                /* initialize a variable that holds the senders last time paid value */
            
                uint256 v4/* time_paid_for */ = v2/* target_data */[ 2 /* time_paid_for */ ][p3/* accounts */[t][a]];
                /* initialize a variable that holds the senders time paid for value */

                uint256 v5/* unclaimed_time_paid */ = v2/* target_data */[ 3 /* unclaimed_time_paid */ ][p3/* accounts */[t][a]];
                /* initialize a variable that holds the senders unclaimed time paid for */

                if (v3/* last_time_paid */ + v4/* time_paid_for */ > block.timestamp) {
                    /* if the accounts subscription is still valid */

                    uint256 v6/* uncollectible_amount */ = (v3/* last_time_paid */ + v4/* time_paid_for */) - block.timestamp;
                    /* calculate the amount of time that cannot be collected yet using the current time */

                    v7/* account_subscription_data */[a] = v5/* unclaimed_time_paid */ - v6/* uncollectible_amount */;
                    /* record the collectible time for the account specified */
                }
                else{
                    /* if the accounts subscription is now invalid */

                    v7/* account_subscription_data */[a] = v5/* unclaimed_time_paid */;
                    /* record the collectible time for the account specified */
                }
            }

            v1/* data */[t] = v7/* account_subscription_data */;
            /* set the subscription collection data for the specified accounts for the targeted subscription object in its correct position */
        }
    }//-----CHANGED-----






    function run() external pure returns (uint256){
        return 42;
    }

}
