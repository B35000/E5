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

/* TokensHelperFunctions */
library H3 {

    struct NumData {
        mapping(uint256 => mapping(uint256 => mapping(uint256 => uint256))) num;
        mapping(uint256 => mapping(uint256 => mapping(uint256 => uint256))) int_int_int;
        mapping(uint256 => mapping(uint256 => mapping(uint256 => uint256))) num_str_metas;
    }

    /* boot */
    function f121(
        uint256[][][] calldata p1/* boot_data */,
        uint256[][] calldata p2/* boot_id_data_type_data */,
        NumData storage p3/* self */
    ) external {
        /* records and sets the boot data for the default tokens such as end and spend */
        
        for (uint256 t = 0; t < p2/* boot_id_data_type_data */.length; t++) {
            /* for each entity expressed in the type data array */
            
            if(p2/* boot_id_data_type_data */[t][1/* type */] == 31 /* 31(token_exchange) */){
                /* if the type expressed for the targeted object is a token exchange, record its data here */
                
                f120/* record_new_objects_data */(p2/* boot_id_data_type_data */[t][0/* id */], p1/* boot_data */[t], p3/* self */);
                /* call the record new token exchange object function */
            }
        }
    }//-----TEST_OK-----

    /* record_new_objects_data */
    function f120(
        uint256 p1/* new_obj_id */,
        uint256[][] memory p2/* new_obj_id_num_data */,
        NumData storage p3/* self */
    ) public {
        /* records a new token exchanges data in its specified id */
       
        mapping(uint256 => mapping(uint256 => uint256)) storage p4/* new_obj_id_nums */ = p3/* self */.num[p1/* new_obj_id */];
        /* initialise a storage pointer for the new object id */
        
        for (uint256 e = 0; e < p2/* new_obj_id_num_data */.length; e++) {
            /* for each array in the token exchange */
            
            for (uint256 v = 0; v < p2/* new_obj_id_num_data */[e].length; v++) {
                /* for each item in the array */
                
                if (p2/* new_obj_id_num_data */[e][v] != 0) {
                    /* if the value is non-zero */
                    
                    p4/* new_obj_id_nums */[e][v] = p2/* new_obj_id_num_data */[e][v];
                    /* record the item in its specific position */
                }
            }
        }
        p3/* self */.num_str_metas[p1/* new_obj_id */][ 1 /* num_data */ ][ 3 /* source_tokens_count */ ] = p2/* new_obj_id_num_data */[ 3 /* source_tokens_count */ ].length;
        /* record the length of the source tokens used for buying the token */
    }//-----TEST_OK-----

    /* ensure_type_exchange */
    function f83(
        uint256[] memory p1/* _ids */, 
        NumData storage p2/* self */
    ) private view {
        /* ensures the specified ids passed are exchanges */
        
        for (uint256 r = 0; r < p1/* _ids */.length; r++) {
            /* for each id from the supplied array */
            
            uint256 v1/* recorded_type */ = p2/* self */.num[ p1/* _ids */[r] ][0][ 3 /* type */ ];
            /* initialize the exchanges recorded type as a variable */
            
            require( v1/* recorded_type */ == 5 || /* 5-type_uncapped_supply */ v1/* recorded_type */ == 3 /* type_capped_supply */ );
            /* require that the type is 5,uncapped token exchange or 3,capped token exchange */
        }
    }//-----TEST_OK-----




    /* modify_token_exchange */
    function f122(
        uint256[][5] calldata p1/* data */,
        NumData storage p2/* self */,
        uint256 p3/* sender_account */
    ) external {
        /* modifies a given token exchange's configuration */
        /* data[0] = target_exchanges, data[1] = target_arrays, data[2] = target_array_items, data[3] = new_items, data[4] = authority */
        
        f83/* ensure_type_exchange */(p1/* data */[ 0 /* targets */ ], p2/* self */);
        /* ensure were targeting an exchange object */
        
        for ( uint256 t = 0; t < p1/* data */[ 0 /* targets */ ].length; t++ ) {
            /* for each exchange target specified */
            
            uint256 v1/* sender */ = p1/* data */[ 4 /* authority */ ].length != 0 ? p1/* data */[ 4 /* authority */ ][t] : p3/* sender_account */;
            /* initialize a sender variable from the authority array if it exists or the sender account otherwise */
            
            mapping(uint256 => mapping(uint256 => uint256)) storage v2/* target_nums */ = p2/* self */.num[ p1/* data */[ 0/* targets */ ][t] ];
            /* initialise a storage mapping variable that points to the specific token exchange from its id */

            require( v2/* target_nums */[1][ 9 /* <9>exchange_authority */ ] == v1/* sender */ );
            /* require sender to be authority of the exchange */

            require(p1/* data */[ 1 /* target_array_pos */ ][t] >= 1 && p1/* data */[ 1 /* target_array_pos */ ][t] <= 5);
            /* only the exchange configuration, source tokens, source amounts and source depths can be changed */

            if(v2/* target_nums */[0][ 2 /* <2>fully_custom */ ] == 0){
                /* if the token is not fully custom */

                require(p1/* data */[ 1 /* target_array_pos */ ][t] == 1);
                /* can only modify the tokens configuration */
            }

            if(p1/* data */[ 1 /* target_array_pos */ ][t] == 3){
                /* if the targeted array is the exchanges array */

                mapping(uint256 => uint256) storage v3/* source_token_count */ = p2/* self */.num_str_metas[ p1/* data */[ 0 /* targets */ ][t] ][ 1 /* num_data */ ];
                /* initialize a storage object that points to the tokens's source token count value that records how many tokens are used in buying the token */
                
                require(p1/* data */[ 2/* target_array_items */ ][t] <= v3/* source_token_count */[3/* source_tokens_count */]);
                /* ensure that the specified array item is one of the existing exchanges or a new exchange thats being added */
                
                if(p1/* data */[ 2/* target_array_items */ ][t] == v3/* source_token_count */[3/* source_tokens_count */]){
                    /* if a new exchange is being added */

                    v3/* source_token_count */[3/* source_tokens_count */] += 1;
                    /* increment the source token count variable since a new exchange has been added */
                }
            }
            
            v2/* target_nums */[ p1/* data */[ 1 /* target_array_pos */ ][t] ][ p1/* data */[ 2 /* target_array_items */ ][t] ] = p1/* data */[ 3 /* new_items */ ][t];
            /* set the new data in the targeted item of the first array */
        }
    }//-----RETEST_OK-----

    




    /* run_exchange_checkers */
    function f123(
        uint256[][5] calldata p1/* data */,
        uint256[4] calldata p2/* metas */,
        bool p3/* authority_mint */,
        NumData storage p4/* self */
    ) external returns (uint256[][][] memory v1/* exchange_data */){
        /* runs the checkers before finalizing on the mint or dump action */
        /* metas[0] sender_account, metas[1] msg_value, metas[2] user_last_transaction_number, metas[3] user_last_entered_contracts_number */
        
        f83/* ensure_type_exchange */(p1/* data */[1/* exchanges */], p4/* self */);
        /* ensures the supplied exchange ids are of type exchange */
        
        v1/* exchange_data */ = f86/* read_ids */(p1/* data */[1/* exchanges */], p4/* self */);
        /* read the exchange object and record it in the three dimentional return variable array */

        for ( uint256 t = 0; t < p1/* data */[1/* exchanges */].length; t++ ) {
            require(p1/* data */[ 0 /* actions */ ][t] == 0 || p1/* data */[ 0 /* actions */ ][t] == 1);
            /* ensure correct action type */
            
            uint256[][] memory v2/* exchange */ = v1/* exchange_data */[ t /* <t>exchange_id */ ];
            /* get the specific exchange were handling */

            require(p1/* data */[ 2 /* target_amounts */ ][ t /* target_amount */ ] > 0);
            /* ensure requested amount is not 0 */

            require( v2/* exchange */[ 3 /* source_tokens */ ].length != 0 );
            /* ensure id passed is a token exchange */

            uint256 v3/* sender */ = p1/* data */[ 4 /* sender_accounts */ ].length > 0 ? p1/* data */[ 4 /* sender_accounts */ ][t] : p2/* metas */[ 0 /* sender_account */ ];
            /* initialise a sender variable from the sender account array if exists or the sender of the transaction itelf */

            if (!p3/* authority_mint */) {
                /* if were performing an ordinary mint or dump */
                
                if(v2/* exchange */[1][17/* <17>minimum_transactions_for_first_buy */] != 0){
                    require(p2/* metas */[2/* user_last_transaction_number */] >= v2/* exchange */[1][17/* <17>minimum_transactions_for_first_buy */]);
                }
                /* ensure sender has made required amount of transactions for first swap action */

                if(v2/* exchange */[1][18/* <18>minimum_entered_contracts_for_first_buy */] != 0){
                    require(p2/* metas */[3/* user_last_entered_contracts_number */] >= v2/* exchange */[1][18/* <18>minimum_entered_contracts_for_first_buy */]);
                }
                /* ensure sender has entered required amount of contracts for first swap action */
                
                mapping(uint256 => uint256) storage v4/* pointer */ = p4/* self */.int_int_int[ p1/* data */[ 1 /* exchanges */ ][t] ][v3/* sender */];
                /* initialize a storage pointer variable that points to the senders data in the exchange including the last time they swapped, the last block they swapped and the number of transactions they had made during their last swap */

                require( v4/* pointer */[ 0 /* last_swap_block */ ] != block.number );
                /* ensure first time swapping in current block and sender is not interacting multiple times with a given exchange in one transaction */

                if ( v2/* exchange */[1][ 3 /* minimum_blocks_between_swap */ ] != 0 ) {
                /* if a required number of blocks between swaps exists */ 
                    
                    if ( v4/* pointer */[ 0 /* last_swap_block */ ] != 0 ) {
                        /* the value would be non-zero if the sender has swapped tokens in the exchange before */
                        
                        require( block.number - v4/* pointer */[ 0 /* last_swap_block */ ] >= v2/* exchange */[1][ 3 /* minimum_blocks_between_swap */ ] );
                        /* ensure sender has waited required number of blocks for this new swap action */
                    }
                }
                v4/* pointer */[ 0 /* last_swap_block */ ] = block.number;
                /* record and update the current block as the last block the sender has swapped in the exchange */

                if ( v2/* exchange */[1][ 4 /* minimum_time_between_swap */ ] != 0 ) {
                    /* the value would be non-zero if a required amount of time between swaps exists */
                    
                    if ( v4/* pointer */[ 1 /* last_swap_timestamp */ ] != 0 ) {
                        /* if the sender has swapped tokens in the exchange before */
                        
                        require( block.timestamp - v4/* pointer */[ 1 /* last_swap_timestamp */ ] >= v2/* exchange */[1][ 4 /* minimum_time_between_swap */ ] );
                        /* ensure minimum amount of time required has passed from last swap action */
                    }
                    v4/* pointer */[ 1 /* last_swap_timestamp */ ] = block.timestamp;
                    /* record and update the current time as the last time the sender has swapped in the exchange */
                }

                if ( v2/* exchange */[1][ 2 /* minimum_transactions_between_swap */ ] != 0 ) {
                    /* the value would be non-zero if a required number of transactions between swaps exists */
                    
                    if ( v4/* pointer */[ 2 /* last_transaction_number */ ] != 0 ) {
                        /* if the sender has swapped in the exchange before, the value would be non-zero */
                        
                        require( p2/* metas */[ 2 /* user_last_transaction_number */ ] - v4/* pointer */[ 2 /* last_transaction_number */ ] >= v2/* exchange */[1][ 2 /* minimum_transactions_between_swap */ ] );
                        /* ensure minimum amount of transactions required have been made from last swap action */
                    }
                    v4/* pointer */[ 2 /* last_transaction_number */ ] = p2/* metas */[ 2 /* user_last_transaction_number */ ];
                    /* record and update the senders number of transactions made with e */
                }
                

                if ( v2/* exchange */[1][ 13 /* <13>minimum_entered_contracts_between_swap */ ] != 0 ) {
                    
                    if ( v4/* pointer */[ 3 /* user_last_entered_contracts_number */ ] != 0 ) {
                        
                        require( p2/* metas */[ 3 /* user_last_entered_contracts_number */ ] - v4/* pointer */[ 3 /* user_last_entered_contracts_number */ ] >= v2/* exchange */[1][ 13 /* <13>minimum_entered_contracts_between_swap */ ] );
                    }
                    v4/* pointer */[ 3 /* user_last_entered_contracts_number */ ] = p2/* metas */[ 3 /* user_last_entered_contracts_number */ ];
                }
                /* ensure minimum amount of contracts required have been entered from last swap action */
                
                if ( p1/* data */[ 0 /* actions */ ][t] == 0 /* buy? */ ) {
                    /* if were performing a mint action */
      
                    require( p1/* data */[ 2 /* target_amounts */ ][ t /* target_amount */ ] <= v2/* exchange */[1][ 0 /* <0><0>default_exchange_amount_buy_limit  */ ] );
                    /* require that the sender is not minting more than the limited amount */
                } else {
                    /* if were performing a dump action */
                    
                    require( p1/* data */[ 2 /* target_amounts */ ][ t /* target_amount */ ] <= v2/* exchange */[1][ 11 /* <11>default_exchange_amount_sell_limit */ ] );
                    /* require that the sender is not dumping more than the limited amount */
                }
                /* ensure amount being bought or sold does not exceed its limit */
            } else {
                require( 
                    v2/* exchange */[1][ 9 /* <9>exchange_authority */ ] == v3/* sender */ && 
                    v2/* exchange */[0][ 3 /* exchange_type */ ] == 5 /* type_uncapped_supply */ 
                ); /* require exchange authority to be sender */

                require( p1/* data */[ 0 /* actions */ ][t] == 0 /* buy */ );
                /* can only authmint as buy action */
            }
        }
    }//-----TEST_OK-----

    /* calculate_share_of_total */
    function f7(uint256 p1, uint256 p2) private pure returns (uint256) {
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





    /* update_reduction_proportion_ratios */
    function f124(
        uint256[][5] calldata p1/* data */,
        uint256[][][] calldata p2/* exchange_nums */,
        NumData storage p3/* self */,
        uint256[] calldata p4/* new_ratios */
    ) external returns (uint256[][][] memory v1/* updated_exchange_nums */) {
        /* updates the ratios and values used in calculating how much spend you can mint */
        
        v1/* updated_exchange_nums */ = p2/* exchange_nums */;
        /* set the return updated exchange nums value from the supplied exchange nums argument. */
        
        for ( uint256 t = 0; t < p1/* data */[1].length; /* exchanges */ t++ ) {
            /* for each targeted exchange in the swap action */
            
            if ( p1/* data */[0/* actions */][t] == 0 /* buy? */ ) {
                /* we only update teh active block limit if the action is a buy action */
                
                if ( p3/* self */.num[ p1/* data */[1/* exchanges */][t] ][0][ 3 /* exchange_type */ ] == 5/* type_uncapped_supply */ && p3/* self */.num[ p1/* data */[1/* exchanges */][t] ][1][ 1 /* block_limit */ ] != 0 ) {
                    /* if the exchange type is a uncapped exchange and its block limit is defined */

                    p3/* self */.num[ p1/* data */[1/* exchanges */][t] ][2][ 6 /* <6>active_block_limit_reduction_proportion */ ] = p4/* new_ratios */[t];
                    /* set the new active block limit proportion value in the exchange object in storage */
                    
                    v1/* updated_exchange_nums */[t][2][ 6 /* <6>active_block_limit_reduction_proportion */ ] = p4/* new_ratios */[t];
                    /* set the new active block limit proportion value in the exchange object in the return value */
                }
            }
        }
    }//-----TEST_OK-----

    /* get_consensus_spend_mint_trust_fees */
    function f88(
        uint256[][][] calldata p1/* target_nums */,
        NumData storage p2/* self */
    ) external view returns (uint256[][][2] memory v1/* exchange_trust_fees_data */) {
        /* calculates and returns a three dimentional array containing the trust fee and trust fee target data used in calculating how much tokens are required to be sent to the exchange's trust fee target(<10>trust_fee_target) from a contract spend action. */
        /* 
            exchange_trust_fees_data[0] : proportion
            exchange_trust_fees_data[1] : trust_fee_targets
        */
        v1/* exchange_trust_fees_data */ = [ new uint256[][](p1/* target_nums */.length), new uint256[][](p1/* target_nums */.length) ];
        /* initialize the return variable using the number of target consensus objects passed */
        
        for (uint256 t = 0; t < p1/* target_nums */.length; t++) {
            /* for each target consensus object */
            
            if ( p1/* target_nums */[t][1][ 0 /* consensus_type */ ] == 0 || /* spend */ p1/* target_nums */[t][1][ 0 /* consensus_type */ ] == 2 /* buy */ ) {
                /* if the consensus action is a buy or spend action */
                
                v1/* exchange_trust_fees_data */[ 0 /* proportion */ ][t] = new uint256[](p1[t][4].length);
                /* initialize the proportion array with the length as the number of buy or spend exchanges being used */
                
                v1/* exchange_trust_fees_data */[ 1 /* trust_fee_targets */ ][t] = new uint256[](p1[t][4].length);
                /* initialise the trust fee targets with the lentgh as the number of buy or spend exchanges being used */
                
                for ( uint256 e = 0; e < p1/* target_nums */[t][ 4 /* (buy/spend_exchanges_pos) */ ].length; e++ ) {
                    /* for each exchange being used for spending or buying in the proposal object */
                    
                    mapping(uint256 => uint256) storage v2/* exchange_conf */ = p2/* self */.num[ p1/* target_nums */[t][ 4 /* (buy/spend_exchanges_pos) */ ][e] ][1];
                    /* initialize a storage object variable that points to the exchanges configuration */
                    
                    v1/* exchange_trust_fees_data */[ 0 /* proportion */ ][t][e] = v2/* exchange_conf */[7 /* <7>trust_fee_proportion */];
                    /* set the trust fee proportion from the exchange's configuration data */
                    
                    v1/* exchange_trust_fees_data */[ 1 /* trust_fee_targets */ ][t][e] = v2/* exchange_conf */[10 /* <10>trust_fee_target */];
                    /* set the trust fee target from the exchange's configuration data */
                }
            }
        }
    }//-----TEST_OK-----





    /* read_ids */
    function f86(
        uint256[] memory p1/* _ids */, 
        NumData storage p2/* self */
    ) public view returns (uint256[][][] memory v1/* ints */) {
        /* returns a three dimentional array containing the exchange objects and their data */
        
        v1/* ints */ = new uint256[][][](p1.length);
        /* initialize the return value as a three dimentional array with its length being the number of targets specified */
        
        for (uint256 r = 0; r < p1/* _ids */.length; r++) {
            /* for each target specified */
            
            v1/* ints */[r] = f85/* read_id */(p1/* _ids */[r], p2/* self */);
            /* set its data in the return object position as the return data from the read id function */
        }
    }//-----TEST_OK-----

    /* read_id */
    function f85(
        uint256 p1/* _id */, 
        NumData storage p2/* self */
    ) public view returns (uint256[][] memory v1/* id_data */) {
        /* returns a two dimentional array containing the data for a specified exchange item from its id */
        
        v1/* id_data */ = new uint256[][]( 6 /* data_len */ );
        /* initialize the return variable as a two dimentional array whose length is 6 arrays long */
        
        uint256 v2/* source_tokens_count */ = p2/* self */.num_str_metas[p1/* _id */][ 1 /* id_data */ ][3/* source_tokens_count */];
        /* initialize a variable that contains the number of tokens used for buying the target token */
        
        uint256[6] memory v3/* data */ = [ 4, 20, 8, v2/* source_tokens_count */, v2/* source_tokens_count */ , v2/* source_tokens_count */ ];
        /* initialise a data array containing the variable length of each array, in the two dimentional array that contains the exchange's data */

        for ( uint256 s = 0; s < 6; /* data_len */ s++ ) {
            /* for each array in the exchange object */
            
            uint256 v4/* items_len */ = v3/* data */[s];
            /* initialize a variable containing the length of the specific data array being referred to from the data variable speficied above */
            
            v1/* id_data */[s] = new uint256[](v4);
            /* set the return variable at the specific array item being referenced to be a new array with its length being the item length referred to in the variable above */

            for (uint256 t = 0; t < v4/* items_len */; t++) {
                /* for each item in the array being referred to, from the items length specified above */
                
                v1/* id_data */[s][t] = p2/* self */.num[p1/* _id */][s][t];
                /* set the specific item's data in the return vaiable */
            }
        }
    }//-----RETEST_OK-----

    /* update_exchange_ratios */
    function f125(
        uint256[][5] calldata p1/* data */,
        uint256[] calldata p2/* tokens_to_receive */,
        NumData storage p3/* self */
    ) external {
        /* updates the exchange ratios and tokens supply data during a swap action */
        
        for ( uint256 r = 0; r < p1/* data */[1/* exchanges */].length;  r++ ) {
            /* for each target exchange in the specified targets */
            
            mapping(uint256 => mapping(uint256 => uint256)) storage v2/* exchange */ = p3/* self */.num[ p1/* data */[1][r] /* exchanges */ ];
            /* initialize a storage object containing a mapping that points to the exchange object's data */
            
            if ( p1/* data */[0/* actions */][r] == 1 /* sell? */ ) {
                /* if were selling or dumping a token */

                if ( v2/* exchange */[0][3] == 3 /* <3>type_capped_supply */ ) {
                    /* if the token is a capped token */

                    v2/* exchange */[2][0] += p1/* data */[2/* target_amounts */][r];
                    //adjust token_exchange_ratio_x

                    v2/* exchange */[2][1] -= p2/* tokens_to_receive */[r];
                    //adjust parent_token_exchange_ratio_y

                    v2/* exchange */[2][ 2 /* <2>token_exchange_liquidity*/ ] += p1/* data */[2][r]; /* target_amounts */
                    //adjust exchange tokens liquidity
                } else {
                    /* the token is an uncapped token */
                    v2/* exchange */[2][ 2 /* <2>token_exchange_liquidity*/ ] -= p1/* data */[2][r]; /* target_amounts */
                    /* adjust the exchange tokens liquidity */
                    
                }

                // v2/* exchange */[2][ 3 /* <3>parent_tokens_balance */ ] -= p1/* data */[2][r]; /* target_amounts */
                v2/* exchange */[2][ 3 /* <3>parent_tokens_balance */ ] -= p2/* tokens_to_receive */[r];
                /* adjust the parent token balance. its reduced since by selling, the exchange would send tokens from its account in another exchange */
            } else {
                /* its a buy or mint action */
                if ( v2/* exchange */[0][3] == 3 /* <3>type_capped_supply */ ) {
                    /* if the token is a capped token */
                    
                    v2/* exchange */[2][0] -= p2/* tokens_to_receive */[r];
                    //adjust token_exchange_ratio_x
                    
                    v2/* exchange */[2][1] += p1/* data */[2][r]; /* target_amounts */
                    //adjust parent_token_exchange_ratio_y

                    v2/* exchange */[2][ 2 /* <2>token_exchange_liquidity*/ ] -= p2/* tokens_to_receive */[r];
                    //adjust exchange tokens liquidity
                } else {
                    v2/* exchange */[2][ 2 /* <2>token_exchange_liquidity*/ ] += p2/* tokens_to_receive */[r];
                    /* update exchange tokens liquidity */
                    
                }

                v2/* exchange */[2][ 3 /* <3>parent_tokens_balance */ ] += p1/* data */[2/* target_amounts */][r]; 
                /* adjust the parent tokens balance. its increased since by buying, the exchange would receive tokens from the buyer in its account in other exchanges */
            }
        }
    }//-----CHANGED-----





    /* scan_account_exchange_data */
    function f241(
        uint256[] calldata p1/* accounts */, 
        NumData storage p2/* self */,
        uint256[] calldata p3/* exchanges */
    ) external view returns (uint256[4][] memory v1/* data */){
        /* scans the int_int_int datastorage object for an accounts last_swap_block, last_swap_time, last_transaction_number and user_last_entered_contracts_number */

        v1/* data */ = new uint256[4][](p1.length);
        /* initialize the return variable as a new array whose length being the number of targets specified in the arguments */

        for (uint256 t = 0; t < p1/* accounts */.length; t++) {
            /* for each target specified */

            mapping(uint256 => uint256) storage v2/* pointer */ = p2/* self */.int_int_int[p3/* exchanges */[t]][p1/* accounts */[t]];
            /* initialize a storage pointer variable that points to the accounts data in the targeted exchange including the last time they swapped, the last block they swapped and the number of transactions they had made during their last swap */

            v1/* data */[t] = [
                v2/* pointer */[ 0 /* last_swap_block */ ], 
                v2/* pointer */[ 1 /* last_swap_timestamp */ ], 
                v2/* pointer */[ 2 /* last_transaction_number */ ], 
                v2/* pointer */[ 3 /* user_last_entered_contracts_number */ ]
            ];
            /* set the data in the return data array */
        }
    }//-----CHANGED-----


    /* run_exchange_transfer_checkers */
    function f231(
        uint256[][6] calldata p1/* data */,
        uint256 p2/* initiator_account */,
        NumData storage p3/* self */
    ) external view returns (uint256[][5] memory v1/* data */){
        /* ensures exchange transfer actions are valid */
        /* data[0]:exchanges, data[1]:receivers, data[2]:amounts, data[3]:depths, data[4]:initiator_accounts, data[5]:token_targets */

        f83/* ensure_type_exchange */(p1/* data */[0/* exchanges */], p3/* self */);
        /* ensure the supplied ids are the correct type */

        for (uint256 t = 0; t < p1/* data */[0/* exchanges */].length; t++) {
            /* for each exchange that has been targeted */

            uint256 v2/* initiator */ = p2/* initiator_account */ == 0 ? p1/* data */[4/* initiator_accounts */][t]: p2/* initiator_account */;
            /* initialize a new variable that holds the account that initiated the exchange transfer action */


            uint256 v3/* exchange_authority */ = p3/* self */.num[ p1/* data */[0/* exchanges */][t] ][1/* exchange_config */][9 /* <9>exchange_authority */];
            /* get the specific exchange's authority were handling */

            uint256 v4/* unlocked_liquidity */ = p3/* self */.num[ p1/* data */[0/* exchanges */][t] ][0][1 /* <1>unlocked_liquidity */];

            require(v3/* exchange_authority */ == v2/* initiator */ && v4/* unlocked_liquidity */ == 1);
            /* ensure the initiator to be the exchange authority of the exchange and the exchange's unlocked liquidity is turned on */
        }

        v1/* data */ = [
            p1/* data */[5/* token_targets */], 
            p1/* data */[2/* amounts */], 
            p1/* data */[0/* exchanges */], 
            p1/* data */[1/* receivers */], 
            p1/* data */[3/* depths */]
        ];
        /* set the return data to finish the exchange transfer action */
    }//-----RETEST_OK-----







    function run() external pure returns (uint256){
        return 42;
    }

}