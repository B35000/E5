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

/* E5HelperFunctions */
library E3 {

    struct TD/* TransactionData */ {
        /* struct used to house all the transaction data in the stack of a given run */

        uint256 sv1/* user_acc_id */;
        /* stores the user account id for the sender of the transaction */

        bool sv2/* can_sender_vote_in_main_contract */;
        /* set to true if the sender can vote in the main contract. Usually calculated using the number of transactions run with e and number of entered contracts for the transaction sender. by default in the test values, its two transactions and one entered contract, but just one transaction should do to keep out bots and stuff like that */

        uint256[] sv3/* temp_transaction_data */;
        /* transaction data used for recording the ids created for previous or future transactions in and within a given run */

        uint256[][] sv4/* vals */;
        /* stores the integer data vaules for a given transaction stack */

        address[] sv5/* adds */;
        /* stores the address data values for a given transaction stack */

        string[][] sv6/* strs */;
        /* stores the string data values for a given transaction stack */

        uint256 t;
        /* stores the transaction stack number in focus during a given run */

        uint256 sv7/* new_obj_id */;
        /* stores the id of a new object being created */

        uint256 sv8/* tx_value_available */;
        /* stores the amount of ether available for using to buy end if included in a given run */

        uint256[2] sv9/* user_acc_data */;
        /* stores the user account data including the number of entered contracts and the number of runs made with e */

        bool sv10/* auto_wait_data_exists */;
        /* set to true if e is meant to record an auto wait vote for each participant of a given contract when sending a proposal to said contract */

        uint256[] sv11/* route_data */;
        /* stores the route values for transactions in the stack involving the other smart contracts such as F5, G52, G5, H5 and H52 */
    }

    /* get_multi_stack_or_real_ids */
    function f18(
        uint256[] memory p1/* ids */,
        uint256[] memory p2/* id_types */,
        uint256[] memory p3/* temp_transaction_data */,
        uint256 p4/* sender_acc_id */
    ) private view returns (uint256[] memory v1/* targets */) {
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
                revert("");
            }
        }
    }//-----RETEST_OK-----



    /* get_primary_secondary_target_data */
    function f21(TD/* TransactionData */ memory p1/* tx_data */)
    external view returns (uint256[][5] memory v1/* target_id_data */) {
        /* initializes and sets the data used in performing mod actions */

        uint256[] memory e = new uint256[](0);
        /* initialize an empty array */

        v1/* target_id_data */ = [ e, e, e, e, e ];
        /* initialize the return variable as a two dimentional array of length five */

        uint256 v2/* action */ = p1/* tx_data */.sv4/* vals */[0][ 1 /* action */ ];
        /* initialize a variable that contains the action of the transaction in focus */

        v1/* target_id_data */[ 0 /* target_ids */ ] = f18/* get_multi_stack_or_real_ids */( 
            p1/* tx_data */.sv4/* vals */[ 1 /* targets */ ], 
            p1/* tx_data */.sv4/* vals */[ 2 /* target_id_types */ ], 
            p1/* tx_data */.sv3/* temp_transaction_data */, 
            p1/* tx_data */.sv1/* user_acc_id */
        );
        /* set the first array as the targets for the given transaction */

        if ( v2/* action */ == 7 || v2/* action */ == 4 || v2/* action */ == 2 || v2/* action */ == 17 ) {
            /* if the action is one of the specified transaction types below */
            /*  <7>link_exchanges  <4>modify_moderator_accounts  <2>add_interactible account <17>block_accounts */

            v1/* target_id_data */[ 1 /* secondary_target_ids */ ] = f18/* get_multi_stack_or_real_ids */( 
                p1/* tx_data */.sv4/* vals */[ 3 /* secondary_targets */ ], 
                p1/* tx_data */.sv4/* vals */[ 4 /* secondary_target_types */ ], 
                p1/* tx_data */.sv3/* temp_transaction_data */,
                p1/* tx_data */.sv1/* user_acc_id */
            );
            /* set the secondary targets in the second array since the actions involve targets as well */

            if ( v2/* action */ == 2 /* <2>add_interactible account */ || v2/* action */ == 17 /* <17>block_accounts */) {
                /* if its an add interactible account action */

                v1/* target_id_data */[ 2 /* new_account_time_limits */ ] = p1/* tx_data */.sv4/* vals */[ 5 /* new_account_time_limits */ ];
                /* set the account time limit data specified, in the third array. */
            }
        } 
        else if ( v2/* action */ == 3 /* <3>modify_token_exchange */ ) {
            /* if the action is a modify token exchange action */

            v1/* target_id_data */[ 1 /* target_array_pos */ ] = p1/* tx_data */.sv4/* vals */[ 3 /* target_array_pos */ ];
            /* set the targeted array data being modified in the target exchange objects in the second array */

            v1/* target_id_data */[ 2 /* target_array_items */ ] = p1/* tx_data */.sv4/* vals */[ 4 /* target_array_items */ ];
            /* set the config array item data being changed. for instance, 0 for the default_exchange_amount_buy_limit or 1 for the default_exchange_amount_sell_limit */


            v1/* target_id_data */[ 3 /* new_items */ ] = f18/* get_multi_stack_or_real_ids */( 
                p1/* tx_data */.sv4/* vals */[ 5 /* new_items */ ], 
                p1/* tx_data */.sv4/* vals */[ 6 /* new_item_data_types */ ], 
                p1/* tx_data */.sv3/* temp_transaction_data */,
                p1/* tx_data */.sv1/* user_acc_id */
            );
            /* set the new item data for the data being modified in the fourth item */
        } 
        else if ( v2/* action */ == 11 /* <11>modify_subscription */ ) {
            /* if the action is modifying a subscription action */

            v1/* target_id_data */[ 1 /* target_array_pos */ ] = p1/* tx_data */.sv4/* vals */[ 3 /* target_array_pos */ ];
            /* set the targeted array data being modified in the target subscription objects in the second array */

            v1/* target_id_data */[ 2 /* target_array_items */ ] = p1/* tx_data */.sv4/* vals */[ 4 /* target_array_items */ ];
            /* set the targeted array item data being modified in the target subscription objects in the third array */

            v1/* target_id_data */[ 3 /* new_items */ ] = f18/* get_multi_stack_or_real_ids */( 
                p1/* tx_data */.sv4/* vals */[ 5 /* new_items */ ], 
                p1/* tx_data */.sv4/* vals */[ 6 /* new_item_data_types */ ], 
                p1/* tx_data */.sv3/* temp_transaction_data */,
                p1/* tx_data */.sv1/* user_acc_id */
            );
            /* set the new item data for the data being modified in the fourth item */
        } 
        else if( v2/* action */ == 14 /* <14>modify_proposal */ || v2/* action */ == 15 /* <15>modify_contract */) {
            /* if the action is modifying a proposal action */

            v1/* target_id_data */[ 1 /* target_array_pos */ ] = p1/* tx_data */.sv4/* vals */[ 3 /* target_array_pos */ ];
            /* set the targeted array data being modified in the target subscription objects in the second array */

            v1/* target_id_data */[ 2 /* target_array_items */ ] = p1/* tx_data */.sv4/* vals */[ 4 /* target_array_items */ ];
            /* set the targeted array item data being modified in the target subscription objects in the third array */

            v1/* target_id_data */[ 3 /* new_items */ ] = f18/* get_multi_stack_or_real_ids */( 
                p1/* tx_data */.sv4/* vals */[ 5 /* new_items */ ], 
                p1/* tx_data */.sv4/* vals */[ 6 /* new_item_data_types */ ], 
                p1/* tx_data */.sv3/* temp_transaction_data */,
                p1/* tx_data */.sv1/* user_acc_id */
            );
            /* set the new item data for the data being modified in the fourth item */
        }
        else if ( v2/* action */ == 1 || v2/* action */ == 10 || v2/* action */ == 13 ) {
            /* if the action is one of the below actions */
            /* <1>modify metadata  <10>alias_objects  <13>add_data_to_object */

            v1/* target_id_data */[ 1 /* contexts */ ] = p1/* tx_data */.sv4/* vals */[ 3 /* contexts */ ];
            /* set the context data in the second array */

            v1/* target_id_data */[ 2 /* int_data */ ] = p1/* tx_data */.sv4/* vals */[ 4 /* int_data */ ];
            /* set the int_data? in the third array after */
        }
    }//-----RETEST_OK-----




    /* get_token_primary_secondary_target_data */
    function f23(TD/* TransactionData */ calldata p1/* tx_data */) 
    private view returns (
        uint256[][5] memory v1/* target_id_data */, 
        uint256[][5] memory v2/* data */, 
        uint256[][6] memory v3/* data2 */
    ) {
        /* initializes and sets the data used in performing transactions involvoing tokens */

        uint256[] memory e = new uint256[](0);
        /* initialize an empty array */

        v1/* target_id_data */ = [e, e, e, e, e];
        /* initialize the return value as a two dimentional array whose five arrays in length */

        v1/* target_id_data */[ 0 /* target_ids */ ] = f18/* get_multi_stack_or_real_ids */(
            p1/* tx_data */.sv4/* vals */[ 1 /* targets */ ], 
            p1/* tx_data */.sv4/* vals */[ 2 /* target_id_types */ ], 
            p1/* tx_data */.sv3/* temp_transaction_data */, 
            p1/* tx_data */.sv1/* user_acc_id */
        );
        /* set the targets in the first array */

        uint256 v4/* action */ = p1/* tx_data */.sv4/* vals */[0][1/* <1>action */];
        /* initialize a variable that sets the action for the current transaction */

        if (p1/* tx_data */.sv4/* vals */.length >= 5) {
            /* if more than five arrays have been passed in the current transaction in the stack */

            if (v4/* action */ != 13  && v4/* action */ != 15 && v4/* action */ != 4 && v4/* action */ != 5) {
                /* if the action is not one of the below actions */   
                /* <13>collect_subscriptions <15>archive_proposals_or_contracts <4>vote_proposal <5>submit_conensus_request */

                v1/* target_id_data */[ 1 /* secondary_target_ids */ ] = f18/* get_multi_stack_or_real_ids */( 
                    p1/* tx_data */.sv4/* vals */[ 3 /* targets */ ], 
                    p1/* tx_data */.sv4/* vals */[ 4 /* target_id_types */ ], 
                    p1/* tx_data */.sv3/* temp_transaction_data */, 
                    p1/* tx_data */.sv1/* user_acc_id */ 
                );
                /* set the secondary targets in the second array */

                if(v4/* action */ == 17/* <17>exchange_transfer */){
                    /* if the action is an exchange transfer */

                    v1/* target_id_data */[ 2 /* secondary_target_ids */ ] = f18/* get_multi_stack_or_real_ids */( 
                        p1/* tx_data */.sv4/* vals */[ 7 /* token_targets_id */ ], 
                        p1/* tx_data */.sv4/* vals */[ 8 /* token_target_id_types */ ], 
                        p1/* tx_data */.sv3/* temp_transaction_data */, 
                        p1/* tx_data */.sv1/* user_acc_id */ 
                    );
                    /* set the secondary targets in the second array */
                }
            }
        }

        if(v4/* action */ == 3 /* <3>enter_contract */ || v4/* action */ == 14 /* execute_extend_enter_contract_work */){
            /* if the action is an enter contract or extend enter contract action */

            v1/* target_id_data */[ 1 /* secondary_target_ids */ ] = p1/* tx_data */.sv4/* vals */[ 3 /* expiry_times */ ];
            /* set the expiry time data data in the second array of the target id data */
        }

        if(v4/* action */ == 18 /* <18>contract_force_exit_accounts */){
            /* if the action is a force account exit action */
            
            v1/* target_id_data */[ 3 /* secondary_target_ids */ ] = p1/* tx_data */.sv4/* vals */[ 3 /* force_exit_accounts */ ];
            /* set the targeted force exit account data in the second array of the target id data */
        }

        (v2/* data */, v3/* data2 */) = f22/* run_transfers_setup */(p1/* tx_data */, v1/* target_id_data */);
    }//-----RETEST_OK-----

    /* run_transfers_setup */
    function f22( TD/* TransactionData */ calldata p1/* tx_data */, uint256[][5] memory p2/* target_id_data */ )
    private pure returns (uint256[][5] memory v1/* data */, uint256[][6] memory v2/* data2 */) {
        /* initializes the data whose actions involves transfering tokens */

        uint256 v3/* action */ = p1/* tx_data */.sv4/* vals */[0][ 1 /* action */ ];
        /* initialize a variable set to the action of the transaction in focus */

        if ( v3/* action */ == 1 /* <1>send_from_my_account */ ) {
            /* if the transaction sender is sending tokens from their account across multiple exchanges to multiple recipients*/

            v1/* data */ = [
                p2/* target_id_data */[ 0 /* target_ids */ ], /* exchanges */ 
                p1/* tx_data */.sv4/* vals */[ 5 /* amounts */ ],
                p2/* target_id_data */[ 2 /* e */ ], /* senders unused */ 
                p2/* target_id_data */[ 1 /* secondary_target_ids */ ], /* recipients */ 
                p1/* tx_data */.sv4/* vals */[ 6 /* exchange_depth */ ]
            ];
            /* set the data in the return object */
        } 
        else if ( v3/* action */ == 6 /* <6>freeze_tokens/unfreeze_tokens */ ) {
            /* if the action is freezing or unfreezing tokens for specific targets */

            v2/* data2 */ = [ 
                p2/* target_id_data */[ 0 /* target_ids */ ], /* exchange_ids */ 
                p1/* tx_data */.sv4/* vals */[ 5 /* freeze_amounts */ ], 
                p2/* target_id_data */[ 1 /* secondary_target_ids */ ], /* account_ids */ 
                p1/* tx_data */.sv4/* vals */[ 6 /* actions */ ], 
                p2/* target_id_data */[ 2 /* e */ ],
                p1/* tx_data */.sv4/* vals */[ 7 /* exchange_depth */ ] 
            ];
            /* set the data in the return object */
        } 
        else if ( v3/* action */ == 8 /* <8>buy_tokens/sell_tokens */ || v3/* action */ == 9 /* auth_mint */) {
            /* if the action involves buying or selling tokens */

            v1/* data */ = [ 
                p1/* tx_data */.sv4/* vals */[ 6 /* actions */ ], 
                p2/* target_id_data */[ 0 /* target_ids */ ], /* exchange_ids */ 
                p1/* tx_data */.sv4/* vals */[ 5 /* ammounts */ ], 
                p2/* target_id_data */[ 1 /* secondary_target_ids */ ], /* receivers */ 
                p2/* target_id_data */[ 2 /* e */ ]
            ];
            /* set the data in the return object */
        }
        else if(v3/* action */ == 16/* stack_depth_swap */){
            /* if the action is swapping between multiple depths */
            v2/* data2 */ = [ 
                p2/* target_id_data */[ 0 /* target_ids */ ], /* exchange_ids */ 
                p1/* tx_data */.sv4/* vals */[ 5 /* action */ ], 
                p1/* tx_data */.sv4/* vals */[ 6 /* depths */ ], 
                p1/* tx_data */.sv4/* vals */[ 7 /* authmint_amounts */ ],
                p2/* target_id_data */[ 1 /* secondary_target_ids */ ],
                p2/* target_id_data */[ 2 /* e */ ]/* senders(unused) */
            ];
            /* set the data in the return object */
            if(p1/* tx_data */.sv4/* vals */.length > 8/* senders */){
                /* if a senders array has been defined, we set it as well. This was added after the tests to enable stack_depth_swap actions for other accounts by other accounts. */
                v2/* data2 */[5] = p1/* tx_data */.sv4/* vals */[ 8 /* senders */ ];
            }
        }
        else if(v3/* action */ == 17/* <17>exchange_transfer */){
            /* if the action is an exchange transfer action */
            v2/* data */ = [
                p2/* target_id_data */[ 0 /* target_ids */ ], /* exchanges */ 
                p2/* target_id_data */[ 1 /* secondary_target_ids */ ], /* receivers */ 
                p1/* tx_data */.sv4/* vals */[ 5 /* amounts */ ],
                p1/* tx_data */.sv4/* vals */[ 6 /* exchange_depth */ ],
                p2/* target_id_data */[ 3 /* e */ ],/* initiator_accounts unused */
                p2/* target_id_data */[ 2 /* tertiary_target_ids */ ] /* token_targets */
            ];
        }
    }//-----RETEST_OK-----





    /* get_exchange_transfer_data,  get_stack_depth_swap_data,  get_freeze_unfreeze_data */
    function f259(TD/* TransactionData */ calldata p1/* tx_data */ )
    external view returns(uint256[][6] memory){
        /* returns the data used in performing exchange transfers, stack depth swaps and freeze and unfreeze actions */
        (,, uint256[][6] memory v1/* data2 */) = f23/* get_token_primary_secondary_target_data */(p1/* tx_data */);
        return v1/* data */;
    }//-----RETEST_OK-----

    /* get_pay_or_cancel_subscription_data,  get_contract_target_id_data */
    function f260(TD/* TransactionData */ calldata p1/* tx_data */) 
    external view returns (uint256[][5] memory){
        /* returns the data used in performing paying or cancelling subscriptions and contract actions such as entering or exiting a contract */

        ( uint256[][5] memory v1/* target_id_data */,,) = f23/* get_token_primary_secondary_target_data */(p1/* tx_data */);
        return v1/* target_id_data */;
    }//-----RETEST_OK-----




    /* get_multi_transfer_data */
    function f26(TD/* TransactionData */ calldata p1/* tx_data */ ) 
    external view returns (uint256[][5] memory){
        /* returns the data used in performing transfer actions */

        (, uint256[][5] memory v1/* data */,) = f23/* get_token_primary_secondary_target_data */(p1/* tx_data */);
        return v1/* data */;
    }//-----RETEST_OK-----





    /* get_mint_tokens_data */
    function f28(TD/* TransactionData */ calldata p1/* tx_data */, uint256 p2/* action */) 
    external view returns (uint256[][5] memory, uint256[4] memory , uint256[][2] memory){
        /* returns data used for performing mint or dump actions */

        (, uint256[][5] memory v1/* data */,) = f23/* get_token_primary_secondary_target_data */(p1/* tx_data */);
        /* get the mint action data */

        if(p2/* action */ == 9 /* auth_mint */){
            /* if the action is an authmint action */

            uint256[] memory e = new uint256[](0);
            /* initialize an empty array */
            return (
                v1/* data2 */,
                [p1/* tx_data */.sv1/* user_acc_id */, 0, /* msg.value */ 0, /* user_last_transaction_number */ 0 /* user_last_entered_contracts_number */], 
                [e, e]
            );
            /* return the swap data, metadata and empty arrays since no bound data is required for an authmint */
        }else{
            /* its an ordinary mint action */

            return (
                v1/* data2 */, 
                [p1/* tx_data */.sv1/* user_acc_id */, p1/* tx_data */.sv8/* tx_value_available */, p1/* tx_data */.sv9/* user_acc_data */[ 0 /* transaction_count */ ], p1/* tx_data */.sv9/* user_acc_data */[ 1 /* entered_contracts */ ]], 
                [p1/* tx_data */.sv4/* vals */[ 7 /* lower_bounds */ ], p1/* tx_data */.sv4/* vals */[ 8 /* upper_bounds */ ]] 
            );
            /* return the swap data, metadata and the upper and lower bound data required for a mint or dump action */
        }

        
    }//-----RETEST_OK-----

    /* get_submit_consensus_data */
    function f29(TD/* TransactionData */ calldata p1/* tx_data */) 
    external view returns (
        uint256[] memory v2/* target_proposal_data */, 
        uint256[][] memory v3/* payer_accounts */, 
        uint256[][][2] memory v4/* target_bounty_exchanges_depth-data */
    ){
        /* returns the data used for performing the submit consensus action */

        ( uint256[][5] memory v1/* target_id_data */, , ) = f23/* get_token_primary_secondary_target_data */(p1/* tx_data */);
        /* get the data used for the action */

        v2/* target_proposal_data */ =  v1/* target_id_data */[ 0 /* target_ids */ ];
        (v3/* payer_accounts */, v4/* target_bounty_exchanges_depth-data */) = f253/* get_consensus_collect_subscription_payers_data */(p1/* tx_data */);
    }//-----RETEST_OK-----

    /* get_awward_data */
    function f36(TD/* TransactionData */ calldata p1/* tx_data */)
    external view returns (
        uint256[][2] memory v1/* awward_targets_data */, 
        uint256[][5][] memory v2/* awward_transaction_data */
    ){
        /* calculates and sets the data used to perform awward actions */
        /* 
            0[] <---- tx config data
            1[] <---- target receivers
            2[] <---- target receiver id types
            3[] <---- awward_contexts

            n[] <---- exchanges ids
          n+1[] <---- exchange id types
          n+2[] <---- amounts
          n+3[] <---- depths
        */
        v1/* awward_targets_data */[0/* awward_targets */] = f18/* get_multi_stack_or_real_ids */( 
            p1/* tx_data */.sv4/* vals */[ 1 /* targets */ ], 
            p1/* tx_data */.sv4/* vals */[ 2 /* target_id_types */ ], 
            p1/* tx_data */.sv3/* temp_transaction_data */, 
            p1/* tx_data */.sv1/* user_acc_id */ 
        );
        /* gets the awward targets set to receive the awward */

        v1/* awward_targets_data */[ 1/* awward_target_contexts */ ] = p1/* tx_data */.sv4/* vals */[ 3/* awward_contexts */ ];
        /* set the reward contexts */

        uint256 v3/* targets_count */ = p1/* tx_data */.sv4/* vals */[ 1 /* targets */ ].length;
        /* initialize a variable containing the number of targets specified */

        v2/* awward_transaction_data */ = new uint256[][5][](v3/* targets_count */);
        /* initialize a three dimentional array whose length is the number of targets */

        uint256 v4/* last_pos */ =  4 + ((v3/* targets_count */ - 1) * 4);
        /* record the last position */
        
        uint256 v5/* count */ = 0;
        /* initialize a variable that records the position of each targets data in focus */

        for (uint256 r = 4; r <= v4/* last_pos */; r += 4) {
            /* for each set of awward target's data */
            /* 
                start at 4 since [0] to [3] are used,
                then +4 since each iteration requires four arrays
            */
            uint256 v6/* len */ = p1/* tx_data */.sv4/* vals */[r].length;
            /* record the number of exchanges being used for the awward action in focus */

            v2/* awward_transaction_data */[v5/* count */] = [new uint256[](v6), new uint256[](v6), new uint256[](0), new uint256[](0), new uint256[](v6)];
            /* initialize the awward transfer data in a two dimentional array */

            v2/* awward_transaction_data */[v5/* count */][0/* exchanges_ids */] = f18/* get_multi_stack_or_real_ids */( 
                p1/* tx_data */.sv4/* vals */[ r ], 
                p1/* tx_data */.sv4/* vals */[ r+1 ], 
                p1/* tx_data */.sv3/* temp_transaction_data */, 
                p1/* tx_data */.sv1/* user_acc_id */ 
            );
            /* set the exchange ids into its appropriate position */

            v2/* awward_transaction_data */[v5/* count */][1/* amounts */] = p1/* tx_data */.sv4/* vals */[ r+2 ];
            /* set the amounts specified */

            v2/* awward_transaction_data */[v5/* count */][4/* amount_depths */] = p1/* tx_data */.sv4/* vals */[ r+3 ];
            /* set the exchange amount depths specified */

            // require(
            //     v2/* awward_transaction_data */[v5/* count */][0/* exchanges_ids */][0] == 3 && 
            //     v2/* awward_transaction_data */[v5/* count */][1/* amounts */][0] >= 3 
            // );
            /* make sure the first exchange is end exchange and the amonut is at least 3 */

            v5/* count */++;
            /* increment the count value */
        }

    }//-----RETEST_OK-----




    /* get_consensus_collect_subscription_vote_proposal_bounty_data */
    function f253(TD/* TransactionData */ calldata p1/* tx_data */)
    private pure returns (
        uint256[][] memory v1/* payer_accounts */, 
        uint256[][][2] memory v4/* target_bounty_exchanges_depth-data */ 
    ){
        /* sets the payer account data for submitted collect subscription proposals. Payer account data should be submitted for each targeted subscription in the collect subscription proposals being submitted */
        /* 
            0[<2>payer_account_data_start, <3>payer_account_data_end, <4>vote_proposal_bounty_data_start, <5>vote_proposal_bounty_data_end] <---- tx config data
            1[n(sub1, sub2), o(sub3, sub4, sub5)] <---- target proposal ids(assume n and o are collect subscription proposals)
            2[] <---- target proposal id types

            <3>sub1[] <---- payer account data
            <4>sub2[] <---- payer account data

            <5>sub3[] <---- payer account data
            <6>sub4[] <---- payer account data
            <7>sub5[] <---- payer account data

        */
        uint256[][] calldata v2/* int_data */ = p1/* tx_data */.sv4/* vals */;

        if(v2/* int_data */[0/* tx_config */][2/* payer_account_data_start */] != 0){
            /* if payer_account_data has been specified for consensus objects containing collect subscription actions */

            uint256 v3/* payer_accounts_arrays_count */ = (v2/* int_data */[0/* tx_config */][3/* payer_account_data_end */] - v2/* int_data */[0/* tx_config */][2/* payer_account_data_start */])+1;

            v1/* payer_accounts */ = new uint256[][](v3);
            /* set the return payer_account data array as a new array whose lenght is the defined number of payer account arrays specified */

            uint256 v5/* pos */ = 0;

            for ( uint256 t = v2/* int_data */[0/* tx_config */][2/* payer_account_data_start */]; t <= v2/* int_data */[0/* tx_config */][3/* payer_account_data_end */]; t++ ) {
                /* for each payer accounts array specified */

                v1/* payer_accounts */[v5/* pos */] = v2/* int_data */[t];
                /* set the payer account array in its position */

                v5/* pos */++;
            }
        }

        if(v2/* int_data */[0/* tx_config */][4/* vote_proposal_bounty_data_start */] != 0){
            /* if vote proposal bounty data has been specified for proposals being submitted involving voting in other proposals */

            uint256 v6/* bounty_exchanges_arrays_count */ = (v2/* int_data */[0/* tx_config */][5/* vote_proposal_bounty_data_end */] - v2/* int_data */[0/* tx_config */][4/* vote_proposal_bounty_data_start */ ]+1) / 2;
            /* record the number of bounty exchange arrays specified */

            v4/* target_bounty_exchanges_depth-data */ = [new uint256[][](v6)/* exchanges */ , new uint256[][](v6)/* depths */];
            /* set the target_bounty_exchanges_depth-data array as a new array whose length is the defined number of bounty exchange arrays specified */
            

            for ( uint256 e = 0; e < v6/* bounty_exchanges_arrays_count */; e++ ) {
                /* for each bounty exchange array and bounty exchange depth array specified */

                uint256 v7/* pos */ = v2/* int_data */[0/* tx_config */][4/* vote_proposal_bounty_data_start */ ] + (2 * e);/* record the position in focus */

                v4/* target_bounty_exchanges_depth-data */[0/* exchanges */][e] = v2/* int_data */[v7/* pos */];
                v4/* target_bounty_exchanges_depth-data */[1/* depths */][e] = v2/* int_data */[v7/* pos */+1];
                /* set the bounty exchange and depth array data in their respective positions */

            }
        }
    }//-----RETEST_OK-----




    //
    //
    //
    //
    //
    //
    // ------------------------CONTRACT-FUNCTIONS-------------------------------
    /* fetch_modify_targets */
    function f52( uint256[][][] calldata p1/* target_nums */ ) 
    external pure returns (uint256[] memory v1/* modify_target_ids */) {
        /* returns the targets of consensus objects being modified */

        v1/* modify_target_ids */ = new uint256[](p1.length);
        /* initialize the return value as an array whose size is the number of targets */

        for (uint256 t = 0; t < p1/* target_nums */.length; t++) {
            /* for each target specified */
            
            if ( p1/* target_nums */[t][1][0/* action */] == 1 /* reconfig */ ) {
                /* if the target action is a reconfig action */

                v1/* modify_target_ids */[t] = p1/* target_nums */[t][1][ 9 /* modify_target */ ];
                /* record the modify target accordingly */
            }
        }
    }//-----TEST_OK-----



    function run() external pure returns (uint256){
        return 42;
    }

}
