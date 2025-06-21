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
library G33 {
    
    /* get_enter_contract_multi_transfer_data */
    function f62(
        uint256[] calldata p1/* targets */,
        uint256[][][] calldata p2/* targets_data */,
        uint256 p3/* sender_account */,
        uint256[] calldata p4/* sender_accounts */
    ) external pure returns (uint256[][5] memory v1/* data */) {
        /* calculates, sets and returns the data used for performing transfer actions to a contract when entering a contract */
        /* data[0] = exchange_ids , data[1] = amounts , data[2] = senders , data[3] = receivers */
        
        v1/* data */ = f59/* get_mult_exchanges_count */(p2/* targets_data */);
        /* initalize the return variable with the return data from the get multiple exchanges count function */

        uint256 v2/* transfer_count */ = 0;
        /* initialize a transfer count variable to track the positions being referred to when setting the transfer data */
        
        for (uint256 t = 0; t < p1/* targets */.length; t++) {
            /* for each target contract being entered by the sender */

            uint256 v3/* sender */ = p3/* sender_account */;
            /* initialize a variable that holds the sender account id */

            if(v3/* sender */ == 0){
                /* if sender_account value is zero, sender is in sender_accounts array */

                v3/* sender */ = p4/* sender_accounts */[t];
                /* reset the sender value from the sender_accounts array */
            }
            
            for ( uint256 e = 0; e < p2/* targets_data */[t][ 2 /* exchanges */ ].length; e++ ) {
                /* for each token exchange required by the contract to be transacted with to enter the contract */

                v1/* data */[ 0 /* exchange_ids */ ][v2/* transfer_count */] = p2/* targets_data */[t][ 2 /* exchanges */ ][e];
                /* set the exchange ids */
                
                v1/* data */[ 1 /* amounts */ ][v2/* transfer_count */] = p2/* targets_data */[t][ 3 /* exchange_amounts */ ][e];
                /* set the amounts */

                v1/* data */[ 2 /* senders */ ][v2/* transfer_count */] = v3/* sender */;
                /* set the sender */

                v1/* data */[ 3 /* receivers */ ][v2/* transfer_count */] = p1/* targets */[t];
                /* set the receiver as the target contract id */

                v1/* data */[ 4 /* depth */ ][v2/* transfer_count */] = p2/* targets_data */[t][ 4 /* exchange_amounts_depths */ ][e];
                /* set the amount depths for each token being interacted with */

                v2/* transfer_count */++;
                /* increment our transfer count variable by one */
            }
        }

    }//-----RETEST_OK-----

    /* get_mult_exchanges_count */
    function f59(uint256[][][] calldata p1/* targets_data */) 
    private pure returns (uint256[][5] memory v1/* data */) {
        /* initializes the two dimentional data array used in performing transfers to the contracts when entering contracts */
        /* data[0] = exchange_ids , data[1] = amounts , data[2] = senders , data[3] = receivers */
        
        uint256 v2/* transfer_count */ = 0;
        /* initialise a transfer count variable to track the total number of transfer actions that will take place */
        
        for (uint256 t = 0; t < p1/* targets_data */.length; t++) {
            /* for each target contract being referred to */
            v2/* transfer_count */ += p1/* targets_data */[t][ 2 /* exchanges */ ].length;
            /* increment the transfer count variable by the number of exchanges(transactions from the sender entering the contract to the contract account) required by the contract to enter the contract */
        }
        v1/* data */ = [
            new uint256[](v2),
            new uint256[](v2),
            new uint256[](v2),
            new uint256[](v2),
            new uint256[](v2)
        ];
        /* initialise the two dimentional variable with five arrays whose length is the total number of exchanges being interacted with from the transfer count variable above */
    }//-----RETEST_OK-----





    /* get_consensus_buy_spend_data */
    function f63(
        uint256[] calldata p1/* targets */,
        uint256[][][] calldata p2/* target_nums */,
        uint256[] calldata p3/* target_payers_for_buy_data */,
        uint256[][][2] calldata p4/* exchange_trust_fees_data */,
        uint256[21] calldata p5/* consensus_type_data */
    ) external pure returns (uint256[][5] memory v1/* data */) {
        /* calculates, sets and returns a two dimentional variable used in consensus spend or buy actions */
        /* 
            data[0] = exchange_ids , data[1] = amounts , data[2] = senders , data[3] = receivers , data[4] = depths
            exchange_trust_fees_data[0] : proportion
            exchange_trust_fees_data[1] : trust_fee_targets
        */
        
        v1/* data */ = f57/* get_buy_spend_count_exchanges_count */( (p5/* consensus_type_data */[ 0 /* spend */ ] + p5/* consensus_type_data */[ 2 /* buy */ ]), 2 );
        /* sets the return variable as the return data from the get exchanges count function */
        
        uint256 v2/* transfer_count */ = 0;
        /* initialise a transfer count variable to track the positions being referred to when setting the transfer data */

        for (uint256 t = 0; t < p1/* targets */.length; t++) {
            /* for each consensus target */
            
            if ( p2/* target_nums */[t][1][ 0 /* consensus_type */ ] == 0/* spend */ ||  p2/* target_nums */[t][1][ 0 /* consensus_type */ ] == 2 /* buy */ ) {
                /* if the consensus type is a spend or buy action */
                
                for ( uint256 e = 0; e < p2/* target_nums */[t][ 4 /* (buy/spend_exchanges_pos) */ ].length; e++ ) {
                    /* for each exchange in the buy or spend exchanges set in the proposal object */

                    v1/* data */[ 0 /* exchange_ids */ ][v2/* transfer_count */] = p2/* target_nums */[t][ 4 /* (buy/spend_exchanges_pos) */ ][e];
                    /* set the specific exchange being referred to in the exchange ids array */
                    
                    v1/* data */[ 0 /* exchange_ids */ ][v2/* transfer_count */ + 1] = p2/* target_nums */[t][ 4 /* (buy/spend_exchanges_pos) */ ][e];
                    /* set the same exchange in the preceding position since it will be a trust fee transfer to the trust fee beneficiary */

                    ( v1/* data */[ 1 /* amounts */ ][v2/* transfer_count */ + 1], /* share */ v1/* data */[ 1 /* amounts */ ][v2/* transfer_count */] /* remaining_amount */ ) = f58/* calculate_share_for_buy_spend_consensus */( p2/* target_nums */[t][ 5 /* amounts */ ][e], p4/* exchange_trust_fees_data */[ 0 /* proportion */ ][t][e] );
                    /* calculates the proportion of the amount being transfered using the trust fee proportion set by the exchange authority, and sets it in the preceding position in the amounts array and the remaining amount in the amounts array as well. so if 1000 tokens are being spend with the trust fee being 5%, 950 tokens would be set to the target of the consensus spend and the remaining 50 tokens would go to the exchanges trust fee beneficiary. */

                    if ( p2/* target_nums */[t][1][ 0 /* consensus_type */ ] == 0 /* spend */ ) {
                        /* if the action is a spend action */

                        v1/* data */[ 2 /* senders */ ][v2/* transfer_count */] = p2/* target_nums */[t][1][ 5 /* target_contract_authority */ ];
                        /* set the targeted contract authority of the proposal as the sender of the transaction */

                        v1/* data */[ 2 /* senders */ ][v2/* transfer_count */ + 1] = p2/* target_nums */[t][1][ 5 /* target_contract_authority */ ];
                        /* set the contract authority of the consensus object as the sender in the preceding position since its sending to its target receiver and the exchanges trust fee beneficiary */
                        
                        v1/* data */[ 3 /* receivers */ ][v2/* transfer_count */] = p2/* target_nums */[t][ 6 /* spend_receivers */ ][e];
                        /* send the transfer receiver as the receiver of the consensus spend from the contract */

                    } else {
                        v1/* data */[ 2 /* senders */ ][v2/* transfer_count */] = p3/* target_payers_for_buy_data */[t]; 
                        /* set the sender as the target payer for the buy since the buyer would be sending tokens to the contract authority of the consensus object */
                        
                        v1/* data */[ 2 /* senders */ ][v2/* transfer_count */ +1] = p3/* target_payers_for_buy_data */[t];
                        /* set the sender as the target payer for the buy in the preceding position since the buyer would be sending trust fee to the exchange's trust fee beneficiary as well */
                        
                        v1/* data */[ 3 /* receivers */ ][v2/* transfer_count */] = p2/* target_nums */[t][1][ 5 /* target_contract_authority */ ];
                        /* set the receiver as the contract authority since the consensus' contract authority would be receiving tokens */
                    }
                    v1/* data */[ 3 /* receivers */ ][v2/* transfer_count */ + 1] = p4/* exchange_trust_fees_data */[ 1 /* trust_fee_targets */ ][t][e];
                    /* set the trust fee authority in the preceding position since in both spend and buy actions, the trust fee transaction would have the the trust fee authority as the recipient */

                    v1/* data */[ 4 /* exchange_depths */ ][v2/* transfer_count */] = p2/* target_nums */[t][ 7 /* exchange_depths */ ][e];
                    /* set the transaction's token depth */

                    v1/* data */[ 4 /* exchange_depths */ ][v2/* transfer_count */+1] = p2/* target_nums */[t][ 7 /* exchange_depths */ ][e];
                    /* set the transaction's token depth in the preceding position as well */
                    
                    v2/* transfer_count */ += 2;
                    /* increment the transfer count by two since each transfer would involve a trust fee transaction */
                }
            }
        }
    }//-----RETEST_OK-----

    /* calculate_share_for_buy_spend_consensus */
    function f58(
        uint256 p1/* amount */,
        uint256 p2/* proportion */
    ) private pure returns (uint256 v1/* share */, uint256 v2/* remaining_amount */) {
        /* calculates and returns the proportion from a given amount and the remaining amount as well */
        
        if (p1/* amount */ != 0 || p2/* proportion */ != 0) {
            /* if the amount or proportion is non-zero */
            
            v1/* share */ = p1/* amount */ > 10**18
                ? (p1/* amount */ / 10**18) * p2/* proportion (denominator -> 10**18) */
                : (p1/* amount */ * p2/* proportion */) / 10**18; /* (denominator -> 10**18) */
            /* set the share as the proportion of the amount */
            
            v2/* remaining_amount */ = p1/* amount */ - v1/* share */;
            /* set the remaining amount as the difference between the amount and share calculated above */
        }
    }//-----TEST_OK-----

    /* get_buy_spend_count_exchanges_count */
    function f57(
        uint256 p1/* size */, 
        uint256 p2/* amount_modifier */
    ) private pure returns (uint256[][5] memory v1/* data */) {
        /* calculates and returns a two dimentional array of objects whose length is the size of both spend and buy actions calculated previously multiplied by the amount modifier(two since its an ordinary and trust fee transaction for every spend or buy consensus action) */
        /* data[0] = exchange_ids , data[1] = amounts , data[2] = senders , data[3] = receivers */
        
        uint256 v2/* transfer_count */ = (p1/* size */ * p2/* amount_modifier */);
        /* initialize a transfer count variable as the size or number of spend and buy consensus actions times the amount modifier(which is just two) */
        
        v1/* data */ = [
            new uint256[](v2),
            new uint256[](v2),
            new uint256[](v2),
            new uint256[](v2),
            new uint256[](v2)
        ];
        /* set the return variable as a two dimentional variable consisting of five arrays, each's length being the transfer count variable */
    }//-----TEST_OK-----



    /* get_consensus_mint_dump_data */
    function f60(
        uint256[] calldata p1/* targets */,
        uint256[][][] calldata p2/* target_nums */,
        uint256[21] calldata p3,/* consensus_type_data */
        uint256 p4/* action */
    ) external pure returns (uint256[][5] memory v1/* data */, uint256[][2] memory v3/* buy_sell_limits */) {
        /* calculates, sets and returns the authmint actions from a consensus object */
        /* data[0] actions ,  data[1] exchanges , data[2] target_amounts  ,  data[3] receivers , data[4] sender_accounts*/
        
        (v1/* data */, v3/* buy_sell_limits */) = f56/* get_mint_exchanges_count */(p3/* consensus_type_data */[ p4/* action */ ], p4/* action */);
        /* initializes the return variable from the return data of the get_mint_exchanges_count function */
        
        uint256 v2/* transfer_count */ = 0;
        /* initialises a transfer count variable that tracks the position of the exchnage data being referred to in the loop below */        

        for (uint256 t = 0; t < p1/* targets */.length; t++) {
            /* for each consensus target specified */

            if ( p2/* target_nums */[t][1][ 0 /* consensus_type */ ] == p4/* action */ ) {
                /* if the consensus type is a mint/buy or dump/sell action */

                for ( uint256 e = 0; e < p2/* target_nums */[t][ 4 /* (buy/spend_exchanges_pos) */ ].length; e++ ) {
                    /* for each exchange targeted in the authmint action in the consensus object */
                    
                    v1/* data */[ 1 /* exchanges */ ][v2/* transfer_count */] = p2/* target_nums */[t][ 4 /* (buy/spend_exchanges_pos) */ ][e];
                    /* set the exchanges array as the exchanges being targeted in the authmint action */

                    v1/* data */[ 2 /* target_amounts */ ][v2/* transfer_count */] = p2/* target_nums */[t][ 5 /* amounts */ ][e];
                    /* set the amounts array as the amounts being targeted in the authmint action */

                    v1/* data */[ 3 /* receivers */ ][v2/* transfer_count */] = p2/* target_nums */[t][ 6 /* spend_receivers */ ][e];
                    /* set the receivers array as the receivers bein targeted in the authmint action */

                    v1/* data */[ 4 /* sender_accounts */ ][v2/* transfer_count */] = p2/* target_nums */[t][1][ 5 /* target_contract_authority */ ];
                    /* set the sender of the mint as the contract authority of the proposal */

                    if(p4/* action */ == 5/* 5-swap_tokens */){
                        /* if the action is to swap tokens, or buy and sell tokens */
                        
                        v1/* data */[ 0 /* actions */ ][v2/* transfer_count */] = p2/* target_nums */[t][ 7 /* actions */ ][e];
                        /* record the action data as either buy or sell actions */

                        v3/* buy_sell_limits */[ 0 /* lower-bound */ ][v2/* transfer_count */] = p2/* target_nums */[t][ 8 /* lower-limits */ ][e];
                        /* record the upper limit buy data */

                        v3/* buy_sell_limits */[ 1 /* upper-bound */ ][v2/* transfer_count */] = p2/* target_nums */[t][ 9 /* upper-limits */ ][e];
                        /* record the lower limit buy data */
                    }
                    
                    v2/* transfer_count */++;
                    /* increment the transfer count variable set above */
                }
            }
        }
    }//-----RETEST_OK-----

    /* get_mint_exchanges_count */
    function f56(
        uint256 p1,/* size */
        uint256 p2/* action */
    ) private pure returns (uint256[][5] memory v1/* data */, uint256[][2] memory v2/* buy_sell_limits */) {
        /* calculates and returns a two dimentional array of objects whose size is derived from the size(number of mint actions) */
        /* data[0] = exchange_ids , data[1] = amounts , data[2] = senders , data[3] = receivers */
        
        v1/* data */ = [
            new uint256[](p1/* size */),
            new uint256[](p1/* size */),
            new uint256[](p1/* size */),
            new uint256[](p1/* size */),
            new uint256[](p1/* size */)
        ];
        /* set the return data array as five new arrays whose length is the size specified */

        if(p2/* action */ == 5/* 5-swap_tokens */){
            v2/* buy_sell_limits */ = [new uint256[](p1/* size */), new uint256[](p1/* size */)];
        }
        else{
            v2/* buy_sell_limits */ = [new uint256[](0), new uint256[](0)];
        }
    }//-----RETEST_OK-----





    /* get_freeze_unfreeze_data */
    function f61(
        uint256[][][] calldata p1/* target_nums */,
        uint256[21] calldata p2/* consensus_type_data */
    ) external pure returns (uint256[][6] memory v1/* data */) {
        /* calculates sets and returns a two dimentional array whose data is used in consensus freeze/unfreeze actions */
        /* 
            data[0] = exchange_ids , data[1] = amounts , data[2] = target_freeze_account_id , data[3] = freeze_or_unfreeze_actions 
            data[4] = sender_acc_id, data[5] = depth_data
         */
        
        v1/* data */ = f208/* get_freeze_unfreeze_exchanges_count */(p2/* consensus_type_data */[ 4 /* 4-freeze/unfreeze */ ]);
        /* sets the return data value from the return value set in the get freeze unfreeze exchanges count function */
        
        uint256 v2/* transfer_count */ = 0;
        /* initialise a transfer count variable that tracks the position being referred to in the loop below */

        for (uint256 t = 0; t < p1/* target_nums */.length; t++) {
            /* for each consensus action being targeted */

            if ( p1/* target_nums */[t][1][ 0 /* consensus_type */ ] == 4 /* freeze/unfreeze */ ) {
                /* if the targeted consensus object is a freeze/unfreeze action */
                
                for ( uint256 e = 0; e < p1/* target_nums */[t][ 4 /* (freeze/unfreeze_exchanges_pos) */ ].length; e++ ) {
                    /* for each exchange targeted in the freeze/unfreeze action */

                    v1/* data */[ 0 /* exchange_ids */ ][v2/* transfer_count */] = p1/* target_nums */[t][ 4 /* (freeze/unfreeze_exchanges_pos) */ ][e];
                    /* set the exchange in the exchange ids array */

                    v1/* data */[ 1 /* amounts */ ][v2/* transfer_count */] = p1/* target_nums */[t][ 5 /* amounts */ ][e];
                    /* set the amount being frozen/unfrozen in the amounts array */

                    v1/* data */[ 2 /* target_freeze_account_id */ ][v2/* transfer_count */] = p1/* target_nums */[t][ 6 /* (freeze/unfreeze_accounts_pos) */ ][e];
                    /* set the targeted freeze/unfreeze account in the target freeze account array */

                    v1/* data */[ 3 /* freeze_or_unfreeze_actions */ ][v2/* transfer_count */] = p1/* target_nums */[t][ 8 /* action */][e];
                    /* set the freeze or unfreeze action in the freeze/unfreeze action array */

                    v1/* data */[ 4 /* sender_acc_id */ ][v2/* transfer_count */] = p1/* target_nums */[t][1][ 5 /* target_contract_authority */ ];
                    /* set the consensus' contract authority as the sender account of the freeze action */

                    v1/* data */[ 5 /* depth_data */ ][v2/* transfer_count */] = p1/* target_nums */[t][ 7 /* depth_data */ ][e];
                    /* set the freeze/unfreeze depth required for making the transaction */

                    v2/* transfer_count */++;
                    /* increment the transfer count initialized above */
                }
            }
        }
    }//-----RETEST_OK-----

    /* get_freeze_unfreeze_exchanges_count */
    function f208(
        uint256 p1/* size */
    ) private pure returns (uint256[][6] memory v1/* data */) {
        /* calculates and returns a two dimentional array of objects whose size is derived from the size(number of freeze/unfreeze actions) */
        /* data[0] = exchange_ids , data[1] = amounts , data[2] = senders , data[3] = receivers */
        
        v1/* data */ = [
            new uint256[](p1/* size */),
            new uint256[](p1/* size */),
            new uint256[](p1/* size */),
            new uint256[](p1/* size */),
            new uint256[](p1/* size */),
            new uint256[](p1/* size */)
        ];
        /* set the return data array as six new arrays whose length is the size specified */
    }//-----TEST_OK-----




    
    /* get_reconfig_data */
    function f55(
        uint256[] calldata p1/* targets */,
        uint256[][][] calldata p2/* target_nums */,
        uint256[] calldata p3/* modify_target_types */
    ) external pure returns (uint256[][5][3] memory v1/* data */) {
        /* initializes, calculates and returns the data used in performing reconfiguration actions on token exchanges, contracts and subscription objects */
        /* 
            consensus_target_data[4]: target_array_pos
            consensus_target_data[5]: target_array_items
            consensus_target_data[6]: new_items
        */
        v1/* data */ = f54/* reconfig_data_setup */(p1/* targets */, p2/* target_nums */, p3/* modify_target_types */);
        /* initializes the return variable as the return data from the reconfig data setup function */
        
        uint256[3] memory v2/* transfer_count */ = [ uint256(0), /* contract */ 0, /* exchange */ 0 /* subscription */ ];
        /* initializes an array whose length is three, for each type of target that can be modified */

        for (uint256 t = 0; t < p1/* targets */.length; t++) {
            /* for each consensus target */

            if ( p2/* target_nums */[t][1][ 0 /* consensus_type */ ] == 1 /* reconfig */ ) {
                /* if the target is a reconfig action */

                for ( uint256 e = 0; e < p2/* target_nums */[t][ 4 /* reconfig_data_pos */ ].length; e++ ) {
                    /* for each target in the reconfig proposal */

                    uint256 v3/* pos */ = 0;
                    /* initialize a variable that tells if were changing a contract, exchange or subscription object. by default its zero or a contract */
                    
                    if ( p3/* modify_target_types */[t] == 31 /* 31 <0> (type token_exchange) */ ) {
                        /* if the targeted object being modified is type of the target is a token exchange */

                        v3/* pos */ = 1;
                        /* set the value to 1 since the transfer count value for an exchange is 1 */
                        
                    } else if ( p3/* modify_target_types */[t] == 33 /* 33(subscription_object) */ ) {
                        /* if the object type being modified is a subscription */
                        
                        v3/* pos */ = 2;
                        /* set the value to 2 since the transfer count value for a subscription is 2 */
                    }
                    uint256[5] memory v4/* items */ = [
                        p2/* target_nums */[t][1][ 9 /* modify_target */ ], 
                        p2/* target_nums */[t][ 4 /* reconfig_data_pos */ ][e], 
                        p2/* target_nums */[t][ 5 /* target_array_items */ ][e], 
                        p2/* target_nums */[t][ 6 /* new_items */ ][e], 
                        p2/* target_nums */[t][1][ 5 /* target_contract_authority */ ]
                    ];
                    /* initialize an array whose length is five, containing the modify target, the reconfiguring position, the targeted array being changed, the new item being set and the target contract authority of the proposal as the initiator of the reconfig action */

                    for ( uint256 i = 0; i < v4/* items */.length; i++ ) {
                        /* then for each value in the items array defined above */

                        v1/* data */[v3/* pos */][i][v2/* transfer_count */[v3/* pos */]]  = v4/* items */[i];
                        /* set the modify data in the specified position of the data array(pos representing the entity type were modifying, i representing the corresponding position in the data array and the transfer_count[pos] representing the entity type being modified). pos and transfer_count[pos] are more or less the same thing. */
                    }

                    v2/* transfer_count */[v3/* pos */]++;
                    /* then increment the transfer count at the specific position being targeted */
                }
            }
        }
    }//-----TEST_OK-----

    /* reconfig_data_setup */
    function f54(
        uint256[] calldata p1/* targets */,
        uint256[][][] calldata p2/* target_nums */,
        uint256[] calldata p3/* modify_target_types */
    ) private pure returns (uint256[][5][3] memory v1/* data */) {
        /* initializes the data array used in handling the reconfig data from multiple consensus targets */
        
        uint256[3] memory v2/* transfer_count */ = [ uint256(0), /* contract */ 0, /* exchange */ 0 /* subscription */ ];
        /* initialize a transfer count array for counting the number of contract, exchange and subscription reconfigure actions */
        
        for (uint256 t = 0; t < p1/* targets */.length; t++) {
            /* for each target consensus object passed */

            if ( p2/* target_nums */[t][1][ 0 /* consensus_type */ ] == 1 /* reconfig */ ) {
                /* if the consensus type is a reconfig action */

                if ( p3/* modify_target_types */[t] == 30 /* contract */ ) {
                    /* if the target of the modification action is a contract */
                    
                    v2/* transfer_count */[0] += p2/* target_nums */[t][4].length;
                    /* increment the contract counter in the transfer count variable defined above */
                }
                else if ( p3/* modify_target_types */[t] == 31 /* 31 <0> (type token_exchange) */ ) {
                    /* if the target of the modification action is a token exchange */

                    v2/* transfer_count */[1] += p2/* target_nums */[t][4].length;
                    /* increment the token exchnage counter in the transfer count variable defined above */
                } 
                else if ( p3/* modify_target_types */[t] == 33 /* 33(subscription_object) */ ) {
                    /* if the target of the modification action is a subscription object */

                    v2/* transfer_count */[2] += p2/* target_nums */[t][4].length;
                    /* increment the token exchnage counter in the transfer count variable defined above */
                }
                else{
                    /* revert otherwise since you can only modify a token exchange, contract and subscription object */
                    revert("");
                }
            }
        }
        v1/* data */ = [
            f53/* get_array_group_from_size */(v2/* transfer_count */[0]),
            f53/* get_array_group_from_size */(v2/* transfer_count */[1]),
            f53/* get_array_group_from_size */(v2/* transfer_count */[2])
        ];
        /* then set the three dimentional array using the transfer count data defined and set above */
    }//-----TEST_OK-----

    /* get_array_group_from_size */
    function f53(uint256 p1/* size */) private pure returns (uint256[][5] memory v1/* data */) {
        /* returns a two dimentional array containing five arrays whose size is specified from the functions arguments */
        
        v1/* data */ = [ 
            new uint256[](p1), 
            new uint256[](p1), 
            new uint256[](p1), 
            new uint256[](p1), 
            new uint256[](p1) 
        ];
    }//-----TEST_OK-----








    function run() external pure returns (uint256){
        return 42;
    }

}
