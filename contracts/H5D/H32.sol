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

/* E5HelperFunctions */
library H32 {
    struct NumData {
        mapping(uint256 => mapping(uint256 => mapping(uint256 => uint256))) num;
        mapping(uint256 => mapping(uint256 => mapping(uint256 => mapping(uint256 => uint256)))) int_int_int;
        mapping(uint256 => mapping(uint256 => uint256)) num_str_metas;
    }

    /* ensure_type_exchange */
    function f832(uint256[][][] memory p1/* obj_ids */) private pure {
        /* ensures the list of supplied exchange objects are exchanges by checking the type value set */
        for (uint256 r = 0; r < p1/* obj_ids */.length; r++) {
            
            uint256 v1/* recorded_type */ = p1/* obj_ids */[r][0][ 3 /* type */ ];
            /* get the type value and set it in a defined variable */
            
            require( v1/* recorded_type */ == 5 || /* 5-type_uncapped_supply */ v1/* recorded_type */ == 3 /* type_capped_supply */ );
            /* require the type value to be 5, uncapped supply token or 3, capped supply token  */
        }
    }//-----TEST_OK-----

    /* stack_depth_swap */
    function f227(
        uint256[][6] calldata p1/* data */,
        NumData storage p2/* self */,
        uint256 p3/* sender_acc_id */,
        uint256[][][] calldata p4/* num */
    ) external {
        /* performs stack swaps for navigating through a tokens depth values */
        /* data[0] = exchanges, data[1] = action, data[2] = depths, data[3] = amounts, data[4] = receivers, data[5] = senders */
        
        f832/* ensure_type_exchange */(p4/* exchange_data */);
        /* ensure the ids passed are exchagnes */
        
        for (uint256 r = 0; r < p1/* data */[ 0 /* target_ids */ ].length; r++) {
            /* for each targeted exchange */

            uint256 v1/* sender */ = p1/* data */[ 5 /* senders */ ].length != 0 ? p1/* data */[ 5 /* sender */ ][r] : p3/* sender_acc_id */;
            /* initialize a sender variable as either the value in the array containing the authority data if exists or the sender of the transaction */

            mapping(uint256 => uint256) storage v2/* exchange_balances */ = p2/* self */.int_int_int[ p1/* data */[ 0 /* target_exchanges */ ][r] ][ 1 /* data */ ][v1/* sender */];
            /* initialize a storage mapping that points to the targeted accounts data in the specified exchange in focus */

            mapping(uint256 => uint256) storage v3/* exchange_receiver_balances */ = p2/* self */.int_int_int[ p1/* data */[ 0 /* target_exchanges */ ][r] ][ 1 /* data */ ][p1/* data */[ 4 /* target_recipient */ ][r]];
            /* initialize a storage mapping that points to the targeted receiver's account */

            require(p4/* num */[r][0][4/* <4>non-fungible */] == 0);
            /* require exchange to be fungible */
            
            if(p1/* data */[ 1 /* action */ ][r] == 0/* swap_down */){
                /* were moving downwards, towards depth zero */
                
                require(p1/* data */[ 2 /* depths */ ][r] != 0);
                /* ensure depth value is not zero */
                
                v2/* exchange_balances */[p1/* data */[ 2 /* depths */ ][r]] --;
                /* reduce the balance for current depth value */
                
                v3/* exchange_receiver_balances */[p1/* data */[ 2 /* depths */ ][r] -1] += (10**72);
                /* increment the depth for the previous depth value below the current targeted depth value by one end token */
            }
            else if(p1/* data */[ 1 /* action */ ][r] == 1/* swap_up */){
                /* were moving upwards, away from depth zero */
                
                v2/* exchange_balances */[p1/* data */[ 2 /* depths */ ][r]] -= (10**72);
                /* reduce the balance for the currently targeted depth by 1 end */
                
                v3/* exchange_receiver_balances */[p1/* data */[ 2 /* depths */ ][r] +1] ++;
                /* increase the proceeding depth value by one */
            }
            else if(p1/* data */[ 1 /* action */ ][r] == 2/* depth_auth_mint */){
                /* were performing a depth mint as an authority of the targeted exchange, similar to an ordinary auth mint with the exception of bypassing the exchanges supply limit restrictions  */
                
                require(p4/* num */[r][1/* exchange_config */][9/* <9>exchange_authority */] == v1/* sender */ && p4/* num */[r][0][0/* unlocked_supply */] == 1);
                /* require the sender to be the authority controlling the exchange and the supply is unlocked */

                if(p1/* data */[ 5 /* senders */ ].length != 0){
                    /* if the senders array has been defined... */
                    
                    require(p3/* sender_acc_id */ == 0);
                    /* ensure that the sender_account_id is zero, meaning function has been invoked from the contract class while submitting a proposal. */
                }
                
                v3/* exchange_receiver_balances */[p1/* data */[ 2 /* depths */ ][r]] += p1/* data */[ 3 /* depth_amounts */ ][r];
                /* increase their balance at the targeted depth by 1 end */
                
            }
            else{
                /* an invalid action has been passed */

                revert("");
                /* stop the entire run */
            }
        }
    }//-----RETEST_OK-----


    /* execute_freeze_unfreeze_tokens */
    function f127(
        uint256[][6] calldata p1/* data */,
        uint256 p2/* sender_acc_id */,
        NumData storage p3/* self */,
        uint256[][][] calldata p4/* num */
    ) external {
        f832/* ensure_type_exchange */(p4/* num */);
        /* ensure the supplied exchange objects are exchanges */
        
        for ( uint256 t = 0; t < p1/* data */[ 0 /* target_exchanges */ ].length; t++ ) {
            uint256 v1/* sender */ = p1/* data */[ 4 /* sender_acc_id */ ].length != 0 ? p1/* data */[ 4 /* sender_acc_id */ ][t] : p2/* sender_acc_id */;
            /* initialise a sender variable to be from the sender accounts array passed or the sender themselves */
            
            require(p4/* num */[t][1][ 9 /* <9>exchange_authority */ ] == v1/* sender */);
            /* require the exchange authority to be the sender */
            
            mapping(uint256 => mapping(uint256 => uint256)) storage v2/* exchange_balances */ = p3/* self */.int_int_int[ p1/* data */[ 0 /* target_exchanges */ ][t] ][ 1 /* data */ ];
            /* initalize a storage object variable that points to the exchanges balance data */
            
            mapping(uint256 => mapping(uint256 => uint256)) storage v3/* exchange_frozen */ = p3/* self */.int_int_int[ p1/* data */[ 0 /* target_exchanges */ ][t] ][ 2 /* frozen_tokens */ ];
            /* initialise storage object variables for the exchanges balances and exchange frozen balances for balances that have been frozen by authority */

            uint256 v4/* amount */ = p1/* data */[ 1 /* amounts */ ][t];
            /* record the amount to be frozen or unfrozen */
            if(v2/* exchange_balances */[ p1/* data */[ 2 /* target_freeze_account_id */ ][t] ][p1/* data */[ 5 /* depth_values */ ][t]] <= v4/* amount */){
                v4/* amount */ = v2/* exchange_balances */[ p1/* data */[ 2 /* target_freeze_account_id */ ][t] ][p1/* data */[ 5 /* depth_values */ ][t]];
                /* if the ordinary balance for the account is less than the targeted amount to freeze, set the amount ot be their balance */
            }

            if ( p1/* data */[ 3 /* freeze_or_unfreeze_actions */ ][t] == 1 /* freeze_tokens */ ) {
                /* if were freezing a targeted accounts balance */
                v2/* exchange_balances */[ p1/* data */[ 2 /* target_freeze_account_id */ ][t] ][p1/* data */[ 5 /* depth_values */ ][t]] -= v4/* amount */;
                
                v3/* exchange_frozen */[ p1/* data */[ 2 /* target_freeze_account_id */ ][t] ][p1/* data */[ 5 /* depth_values */ ][t]] += v4/* amount */;
                /* deduct the amount from their account and increase the frozen amount accordingly */
            } else {
                /* were unfreezing a targeted accounts balance */
                v3/* exchange_frozen */[ p1/* data */[ 2 /* target_freeze_account_id */ ][t] ][p1/* data */[ 5 /* depth_values */ ][t]] -= p1/* data */[ 1 /* amounts */ ][t];

                v2/* exchange_balances */[ p1/* data */[ 2 /* target_freeze_account_id */ ][t] ][p1/* data */[ 5 /* depth_values */ ][t]] += p1/* data */[ 1 /* amounts */ ][t];
                /* deduct the frozen amount and restore the targeted accounts balance */
            }
        }
    }//-----RETEST_OK-----

    


    /* run_exchange_transfers */
    function f131(
        uint256[][6] calldata p1/* data */,
        uint256[] calldata p2/* tokens_to_receive */,
        uint256 p3/* sender_account */,
        uint256[][][] calldata p4/* exchange_nums */,
        bool p5/* authority_mint */,
        NumData storage p6/* self */
    ) external returns(uint256[4][][] memory v1/* amount_sender_acc_receiver_acc_data */){
        /* runs the exchnange transfers for buy sell and mint actions and updates the balance for the targeted sender */
        
        v1/* amount_sender_acc_receiver_acc_data */ = f90/* run_exchange_transfer_setters */(p1/* data */, p2/* tokens_to_receive */, p4/* exchange_nums */, p3/* sender_account */, p5/* authority_mint */);
        /* sets the data required for running the exchange transfer function(run_exchange_transfer) */
        
        if (!p5/* authority_mint */) {
            /* its an ordinary buy or sell action and not an authmint action */
            
            for ( uint256 t = 0; t < p1/* data */[1].length; /* exchanges */ t++ ) { 
                /* for each targeted exchange in the swap action */   
                
                for (uint256 e = 0; e < p4/* exchange_nums */[t][3].length; e++) {
                    /* for each exchange required by the targeted exchange to be transacted with  */
                    
                    if ( p4/* exchange_nums */[t][3][e] != 0 && p4/* exchange_nums */[t][4][e] != 0 ) {
                        /* if the exchange is non zero */
                        /* t3e: source_token_for_buy   t4e: source_token_fee_for_buy */
                        
                        f130/* run_exchange_transfer */(v1/* amount_sender_acc_receiver_acc_data */[t][e], p4/* exchange_nums */[t][3][e], p6/* self */);
                        /* run a transfer to or from the target exchange, to if its a buy action and from if its a sell action */
                    }
                }
                f128/* update_balance */(p1/* data */, p2/* tokens_to_receive */, p3/* sender_account */, p6/* self */, t, p4/* exchange_nums */[t], p5/* authority_mint */);
                /* update the balance for the sender of the mint action, debiting if they are selling and crediting if they are buying */
            }
        }else{
            /* its an authmint action, therefore no need for running transfer to the exchange object for the buy action */
            f129/* update_balances */(p1/* data */, p2/* tokens_to_receive */, p3/* sender_account */, p6/* self */, p4/* exchange_nums */, p5/* authority_mint */);
            /* update the balance for the sender, crediting since tokens are being minted */
        }
        
    }//-----RETEST_OK-----

    /* run_exchange_transfer_setters */
    function f90(
        uint256[][6] calldata p1/* data */,
        uint256[] calldata p2/* tokens_to_receive */,
        uint256[][][] calldata p3/* exchange_nums */,
        uint256 p4,/* sender_account */
        bool p5/* authority_mint */
    ) private pure returns (uint256[4][][] memory v1/* amount_sender_acc_receiver_acc_data */) {
        /* presets the data required to run the exchange transfer function before the final balance is updated */
        
        v1/* amount_sender_acc_receiver_acc_data */ = new uint256[4][][](p1/* data */[1].length);
        /* initialise a new three dimentional array object with the targeted exchange count as its length */
        
        for ( uint256 t = 0; t < p1/* data */[1].length; /* exchanges */ t++ ) {
            /* for each exchange in the data array object */
            
            v1/* amount_sender_acc_receiver_acc_data */[t] = new uint256[4][](p3/* exchange_nums */[t][3].length);
            /* initialise a two dimentional array object with the source tokens for buying number as its length  */
            
            for ( uint256 e = 0; e < p3/* exchange_nums */[t][3].length; e++ ) {
                /* for each exchange id in the source tokens for buying */
                
                if ( p3/* exchange_nums */[t][3][e] != 0 && p3/* exchange_nums */[t][4][e] != 0 ) { 
                    /* if the exchange id is not zero  */
                    /* t3e: source_token_for_buy   t4e: source_token_fee_for_buy  t5e: source_token_depth_for_buy */
                    
                    uint256[4] memory v2/* items */ = [uint256(0), 0, 0, 0];
                    /* initalize a new array of length 4 to contain the exchange transfer data */

                    if ( p1/* data */[0][t] == 0 /* action buy? */ ) {
                        /* if the action is a buy action */
                        
                        uint256 v3/* sender */ = p1/* data */[ 4 /* sender_accounts */ ].length > 0 ? p1/* data */[ 4 /* sender_accounts */ ][t] : p4/* sender_account */;
                        /* initalize a sender variable to be either from the senders array if exists or the transaction sender otherwise */
                        
                        if(!p5/* authority_mint */){
                            /* if its an ordinary mint action */
                            v2/* items */ = [
                                p1/* data */[2/*target_amounts */][t] * p3/* exchange_nums */[t][4][e], 
                                v3/* sender */, 
                                p1/* data */[1/* exchanges */][t],
                                p3/* exchange_nums */[t][5/* depth values */][e]
                            ];
                            /* set the amount (as the targeted amount times the amount required by the exchange for the specific token from the source amounts for buy values), sender, exchange and depth value */
                        }else{
                            v2/* items */ = [
                                p1/* data */[2/*target_amounts */][t], 
                                v3/* sender */, 
                                p1/* data */[1/* exchanges */][t],
                                p3/* exchange_nums */[t][5/* depth values */][e]
                            ];
                            /* set the targeted amount, sender(since its a buy action), exchange id(as the receiver since the exchange receives tokens for a buy) and depth value */
                        }
                        
                    }else{
                        /* its a sell action */
                        v2/* items */ = [
                            p2/* tokens_to_receive */[t] * p3/* exchange_nums */[t][4][e], 
                            p1/* data */[1/* exchanges */][t], 
                            p1/* data */[3 /* receivers */][t],
                            p3/* exchange_nums */[t][5/* depth values */][e]
                        ];
                        /* set the amount(as the tokens to receive times the amount required by the exchange for the specific token from the source amounts for buy values), the exchange(as the sender since its a sell action), the receiver and the depth value */
                    }
                    v1/* amount_sender_acc_receiver_acc_data */[t][e] = v2/* items */;
                    /* set the array data in the amount_sender_acc_receiver_acc_data array */
                }
            }
        }
    }//-----RETEST_OK-----

    /* run_exchange_transfer */
    function f130(
        uint256[4] memory p1/* amount_sender_acc_receiver_acc */,
        uint256 p2/* exchange_id */,
        NumData storage p3/* self */
    ) private {
        /* runs the exchange transfer to and from the targeted exchange before updating the senders balance after */
        
        mapping(uint256 => mapping(uint256 => uint256)) storage v1/* acc_mapping */ = p3/* self */.int_int_int[ p2/* exchange_id */ ][ 1 /* data */ ];
        /* initialise a storage object variable for the targeted exchange data that holds the balance data */ 

        uint256 v2/* parent_exchange */ = p3/* self */.int_int_int[p2/* exchange_id */][ 0 /* control */ ][0/* control_data */][ 5 /* parent_exchange */ ];
        /* get the parent exchange value from the exchange control data */

        uint256 v3/* num_str_metas_pointer */ = p3/* self */.num_str_metas[p2/* exchange_id */][p1/* amount_sender_acc_receiver_acc */[ 3 /* depth */ ]];
        /* initialize a storage object pointing to the exchanges depth metadata */

        require(v3/* num_str_metas_pointer */ >= block.timestamp);
        /* require that the non-fungible token can be transferred if it complies with it's specified limit during purchasing */

        require(p1/* amount_sender_acc_receiver_acc */[ 0 /* amount */ ] <= 10**72);
        /* ensure the amount being transfered is not more than 1 end to avoid overflows */

        //debit action is ignored if the amount is being deducted from the account of the exchange's parent exchange.
        if ( !(v2/* parent_exchange */ == p1/* amount_sender_acc_receiver_acc */[ 1 /* sender_acc_id */ ] && p1/* amount_sender_acc_receiver_acc */[ 0 /* amount */ ] == 10**72) ) {
            /* ensure sender has enough balance for transfer */
            
            v1/* acc_mapping */[ p1/* amount_sender_acc_receiver_acc */[ 1 /* sender_acc_id */ ] ] [ p1/* amount_sender_acc_receiver_acc */[ 3 /* depth */ ]] -= p1/* amount_sender_acc_receiver_acc */[ 0 /* amount */ ];
            /* deduct the targeted amount from the sender set */
        }

        //credit action is ignored if the amount is being added to the account of the exchange's parent exchange.
        if ( !(v2/* parent_exchange */ == p1/* amount_sender_acc_receiver_acc */[ 2 /* receiver_acc_id */ ] && p1/* amount_sender_acc_receiver_acc */[ 0 /* amount */ ] == 10**72) ) {
            
            v1/* acc_mapping */[ p1/* amount_sender_acc_receiver_acc */[ 2 /* receiver_acc_id */ ] ] [p1/* amount_sender_acc_receiver_acc */[ 3 /* depth */ ]] += p1/* amount_sender_acc_receiver_acc */[ 0 /* amount */ ];
            /* increase the targeted amount for the recipient */
        }
    }//-----RETEST_OK-----






    /* update_balances */
    function f129(
        uint256[][6] calldata p1/* data */,
        uint256[] calldata p2/* tokens_to_receive */,
        uint256 p3/* sender_account */,
        NumData storage p4/* self */,
        uint256[][][] calldata p5/* exchange_nums */,
        bool p6/* authority_mint */
    ) private {
        /* initalizes and runs the update balance function for updating the recipients balance after the exchange transfers */
        for ( uint256 r = 0; r < p1/* data */[1].length; /* exchanges */ r++ ) {
            
            f128/* update_balance */(p1/* data */, p2/* tokens_to_receive */, p3/* sender_account */, p4/* self */, r, p5/* exchange_nums */[r], p6/* authority_mint */);
            /* updates the balance for the targeted recipient for the mint or dump action */
        }
    }//-----RETEST_OK-----

    /* update_balance */
    function f128(
        uint256[][6] calldata p1/* data */,
        uint256[] calldata p2/* tokens_to_receive */,
        uint256 p3/* sender_account */,
        NumData storage p4/* self */,
        uint256 p5/* r */,
        uint256[][] calldata p6/* exchange_data */,
        bool p7/* authority_mint */
    ) private {
        /* updates the balance for the recipient for the mint or dump action */
        
        uint256 v1/* sender */ = p1/* data */[ 4 /* sender_accounts */ ].length > 0 ? p1/* data */[ 4 /* sender_accounts */ ][p5/* r */] : p3/* sender_account */;
        /* initialise the sender from the data's senders array or the sender of the transaction themselves */
        
        mapping(uint256 => mapping(uint256 => uint256)) storage v2/* int_int_pointer */ = p4/* self */.int_int_int[ p1/* data */[1][p5/* r */] /* exchanges */ ][ 1 /* data */];
        /* initalise a storage variable that points to the exchanges data mapping that holds the exchanges balances */
        
        uint256 v3/*exchange_default_depth*/ = p6/* exchange_data */[2/* exchange_config_data */][7/* default_depth */];
        /* initalize a variable that holds the exchanges default depth */

        uint256 v4/* num_str_metas_pointer */ = p4/* self */.num_str_metas[p1/* data */[1][p5/* r */] /* exchanges */ ][ v3/*exchange_default_depth*/ ];

        if ( p1/* data */[0/* actions */][p5/* r */] == 1 /* sell? */ ) {
            /* if the action is a sell action or dump action */
            
            v2/* int_int_pointer */[v1/* sender */][v3/* exchange_default_depth */] -= p1/* data */[2][p5/* r */]; /* target_amounts */
            /* deduct the balance of the sender since their selling their tokens */

            if(p6/* exchange_data */[2][ 13 /* <13>temp_non_fungible_depth_token_transaction_end_time  */ ] != 0){
                /* its an non-fungible token*/

                require(v4/* num_str_metas_pointer */ != 0);
                /* ensure the depth has been consumed */
                
                p4/* self */.num_str_metas[p1/* data */[1][p5/* r */] /* exchanges */ ][ v3/*exchange_default_depth*/ ] = 0;
                /* revert the time after which the token can no longer be transferred back to its default */
            }
        }
        else {
            /* the action is a buy action */

            if(p6/* exchange_data */[1][ 19 /* <19>maximum_mint_token_supply  */ ] != 0 && p6/* exchange_data */[0][ 3 /* exchange_type */ ] == 5 /* type_uncapped_supply */ && !p7/* authority_mint */){
                /* if the maximum_mint_token_supply has been specified for a uncapped token. */

                uint256 v5/* total_supply */ = p6/* exchange_data */[2][ 13 /* <13>temp_non_fungible_depth_token_transaction_end_time  */ ] != 0 ? p6/* exchange_data */[2][ 17 /* <17>temp_non_fungible_depth_token_class_total_supply  */ ] : p6/* exchange_data */[2][ 2 /* <2>token_exchange_liquidity/total_supply  */ ];
                
                require(v5/* total_supply */ + p2/* tokens_to_receive */[p5/* r */] <= p6/* exchange_data */[1][ 19 /* <19>maximum_mint_token_supply  */ ]);
                /* ensure sender isnt minting more token than have been required by the exchange author */
            }

            v2/* int_int_pointer */[p1/* data */[3/* receivers */][p5/* r */]][v3/* exchange_default_depth */] += p2/* tokens_to_receive */[p5/* r */];
            /* increase the balance of the sender since their buying tokens */

            if(p6/* exchange_data */[2][ 13 /* <13>temp_non_fungible_depth_token_transaction_end_time  */ ] != 0){
                /* its an non-fungible token*/
                // console.log("num_str_metas_pointer:", v4/* num_str_metas_pointer */);

                require(v4/* num_str_metas_pointer */ == 0 && p2/* tokens_to_receive */[p5/* r */] == 1);
                /* ensure the depth has not been consumed and sender is minting 1 token */

                p4/* self */.num_str_metas[p1/* data */[1][p5/* r */] /* exchanges */ ][ v3/*exchange_default_depth*/ ] = p6/* exchange_data */[2][ 13 /* <13>temp_non_fungible_depth_token_transaction_end_time  */ ];
                /* record the time after which the non-fungible token can no longer be transferred */
            }
            else{
                p4/* self */.num_str_metas[p1/* data */[1][p5/* r */] /* exchanges */ ][ v3/*exchange_default_depth*/ ] = 10**72;
                /* record the default time since its a fungible token */
            }
        }
    }//-----RETEST_OK-----





    /* balance_of */
    function f140(
        uint256[] calldata p1/* exchanges */, 
        uint256[] calldata p2/* accounts */, 
        NumData storage p3/* self */,
        uint256[] calldata p4/* depths */,
        uint256 p5/* unfroozen_or_froozen */
    ) external view returns(uint256[] memory v1/* data */) {
        /* scans the balance for specific accounts supplied at specific depths 1(unfroozen), 2(froozen) */

        v1/* data */ = new uint256[](p1.length);
        /* initialize the return variable */

        for ( uint256 r = 0; r < p1/* exchanges */.length; r++ ) {
            /* for each target specified */

            v1/* data */[r] = p3/* self */.int_int_int[ p1/* exchanges */[r] ][ p5/* unfroozen_or_froozen */ ][ p2/* accounts */[r] ][ p4/* depths */[r]];
            /* record the balance stored in the return variable */
        }
    }//-----TEST_OK-----

    /* account_balances_of */
    function f140e(
        uint256[] calldata p1/* exchanges */,
        uint256 p2/* account */, 
        NumData storage p3/* self */,
        uint256[] calldata p4/* depths */
    ) external view returns(uint256[] memory v1/* data */) {
        /* scans the balance of an account at specific exchanges and depths */

        v1/* data */ = new uint256[](p1.length);
        /* initialize the return variable */

        for ( uint256 r = 0; r < p1/* exchanges */.length; r++ ) {
            /* for each exchange specified */

            v1/* data */[r] = p3/* self */.int_int_int[ p1/* exchanges */[r] ][ 1 /* data */ ][ p2/* account */ ][p4/* depths */[r]];
            /* record the balance in the return variable */
        }
    }//-----TEST_OK-----

    /* balance_of_multiple_accounts */
    function f270(
        uint256[] calldata p1/* exchanges_or_accounts */, 
        uint256[][] calldata p2/* accounts_or_exchanges */, 
        NumData storage p3/* self */,
        uint256[] calldata p4/* depths */,
        uint256 p5/* unfroozen_or_froozen */,
        uint256 p6/* action */
    ) external view returns(uint256[][] memory v1/* data */) {
        /* scans the balance for specific accounts supplied at specific depths 1(unfroozen), 2(froozen) */
        /* 
            action 0: p1 = exchanges and p2 = accounts, 
            action 1: p1 = accounts and p2 = exchanges 
        */

        v1/* data */ = new uint256[][](p1.length);
        /* initialize the return variable */

        for ( uint256 r = 0; r < p1/* exchanges_or_accounts */.length; r++ ) {
            /* for each target specified */

            uint256 v2/* number_of_accounts_or_exchanges */ = p2/* accounts_or_exchanges */[r].length;
            /* record the number of accounts or exchanges in a variable */

            uint256[] memory v3/* account_balance_data */ = new uint256[](v2/* number_of_accounts_or_exchanges */);
            /* create a new array that will contain the balance data for the specified accounts in focus */

            for ( uint256 a = 0; a < v2/* number_of_accounts_or_exchanges */; a++ ) {
                /* for each account or exchange specified */

                if(p6/* action */ == 0){
                    /* a list of accounts(p2) for each target exchange(p1) specified */

                    v3/* account_balance_data */[a] = p3/* self */.int_int_int[ p1/* exchanges */[r] ][ p5/* unfroozen_or_froozen */ ][ p2/* accounts */[r][a] ][ p4/* depths */[r]];
                    /* record the balance stored in the account balance data array */
                }
                else{
                    /* a list of exchanges(p2) for each targeted account(p1) specified */

                    v3/* account_balance_data */[a] = p3/* self */.int_int_int[ p2/* exchanges */[r][a] ][ p5/* unfroozen_or_froozen */ ][ p1/* accounts */[r] ][ p4/* depths */[r]];
                    /* record the balance stored in the account balance data array */
                }
            }

            v1/* data */[r] = v3/* account_balance_data */;
        }
    }//-----TEST_OK-----





    /* set_up_mock_data */
    // function f248( uint256[] calldata p1/* exchanges */, uint256[][][] calldata p2/* exchange_nums */ ) 
    // external pure returns(uint256[][5] memory v1/* data */){
        
    //     v1/* data */ = [new uint256[](p1.length), p1/* exchanges */, new uint256[](p1.length), new uint256[](p1.length), new uint256[](p1.length)];
    //     /* initialize the return 2D array with arrays with the specified number of targets as their sizes */

    //     for ( uint256 t = 0; t < p1/* exchanges */.length; t++ ) {
    //         /* for each exchange targeted */

    //         v1/* data */[2/* target_amounts */][t] = p2/* exchange_nums */[t][1/* exchange_config */][0/* 0>default_exchange_amount_buy_limit */];
    //         /* set the mint limit specified in the exchange config as the mock amount */

    //     }
    // }//-----TEST_OK-----


    function run() external pure returns (uint256){
        return 42;
    }

}