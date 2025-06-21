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
library E34 {

    struct NumData {
        mapping(uint256 => mapping(uint256 => mapping(uint256 => uint256))) num;
        mapping(uint256 => mapping(uint256 => mapping(uint256 => uint256))) int_int_int;
        mapping(uint256 => mapping(uint256 => mapping(uint256 => uint256))) num_str_metas;
    }

    /* record_boot_id_types */
    function f102(
        uint256[][] calldata p1/* boot_id_data_type_data */,
        NumData storage p2/* self */
    ) external {
        /* records the type data for the end, spend and main contract boot objects */
        
        for (uint256 t = 0; t < p1/* boot_id_data_type_data */.length; t++) {
            /* for each data item targeted */
            
            p2/* self */.num[ p1/* boot_id_data_type_data */[t][0/* id */] ][ 0 /* control */ ][ 0 /* data_type */ ] = p1/* boot_id_data_type_data */[t][1/* type */];
            /* record its type value defined in its respective data type module */
        }
    }//-----TEST_OK-----

    /* update_main_contract_limit_data */
    function f94(
        uint256[] calldata p1/* new_main_contract_config */,
        NumData storage p2/* self */
    ) external {
        /* updates the main contract data if changed in the G5 contract by a consensus submit action */
        /* 
            <11>tx_gas_limit <12>contract_block_invocation_limit , <13>contract_time_invocation_limit , <14>minimum_entered_private_contracts,  <16>tag_indexing_limit  , <19>minimum_transaction_count
            <24>tx_gas_reduction_proportion , <25>tx_gas_anchor_price , <26>tx_gas_lower_limit
        */
        uint256[1] memory v1/* pos_used */ = [uint256(16)];
        /* initialize an array with just one value(16). its bad code that was copypasted with the assumption that more values(other than 16) would be used in this library in the future */
        
        for (uint256 t = 0; t < v1/* pos_used */.length; t++) { 
            /* for each value in the defined array above */
            
            p2/* self */.num[ 2 /* main_contract_obj_id */ ][1][ v1/* pos_used */[t] ] = p1/* new_main_contract_config */[ v1/* pos_used */[t] ];
            /* set the new data from the main contract argument data defined */ 
        }
    }//-----TEST_OK-----


    /* start_ensure_types */
    function f71(
        uint256[2] calldata p1/* types */,
        uint256[][5] calldata p2/* target_id_data */,
        NumData storage p3/* self */
    ) external view {
        /* function used to ensure the data types for specific targets passed */
        
        if (p1/* types */[0] != 0) {
            /* if non-zero, the first array of targets in the target id data is defined and should be checked */
            
            f70/* ensure_type */( p1/* types */[0], p2/* target_id_data */[ 0 /* target_ids */ ], p3/* self */ );
            /* ensure the first array of targets since they are defined, with the object type specified in the types array argument */
            
            if (p1/* types */[1] != 0) {
                /* if non-zero, the second array of target ids in the target id data is also defined and should be checked */
                
                f70/* ensure_type */( p1/* types */[1], p2/* target_id_data */[ 1 /* secondary_target_ids */ ], p3/* self */ );
                /* ensure the second array of targets since they are defined, with the object type specified in the types array argument */
            }
        }
    }//-----TEST_OK-----

    /* ensure_type */
    function f70(
        uint256 p1/* id_type */, 
        uint256[] calldata p2/* items */, 
        NumData storage p3/* self */
    ) private view {
        /* ensures supplied targets are of a specific object type */

        for (uint256 t = 0; t < p2/* items */.length; t++) {
            /* for each target in the items specified */

            require(p3/* self */.num[ p2/* items */[t] ][0][0] == p1/* id_type */);
            /* ensure the target type data is the specified object type required */
        }
    }//-----TEST_OK-----





    /* revoke_author_owner_privelages */
    function f277(
        uint256[][5] calldata p1/* target_id_data */,
        NumData storage p2/* self */,
        uint256 p3/* sender_acc_id */
    ) external {
        /* function used to revoke a set of targets author privelages */

        for ( uint256 r = 0; r < p1/* target_id_data */[ 0 /* target_ids */ ].length; r++ ) {
            /* for each target specified by the sender */

            require(p1/* target_id_data */[ 0 /* target_ids */ ][r] > 1000);
            /* ensure target is valid */

            mapping(uint256 => mapping(uint256 => uint256)) storage v2/* obj_nums */ = p2/* self */.num[ p1/* target_id_data */[ 0 /* target_ids */ ][r] ];
            /* initialize a storage object that points to the targeted objects data */


            uint256 v1/* target_type */ = v2/* obj_nums */[ 0 /* control */ ][ 0 /* data_type */ ];
            /* initialize a variable that stores the target type of the target specified */

            require( v1/* target_type */ != 29 && v1/* target_type */ != 32 && v1/* target_type */ != 35 && v1/* target_type */ != 24 );
            /* 29(account_obj_id) , 32(consensus_request) , 35(tag_object) , 24(shadow_object) */
            /* make sure target is not an account, proposal or tag object */

            uint256 v3/* sender */ = p3/* sender_acc_id */;
            /* initialize a variable to contain the sender account id */

            if(v3/* sender */ == 0){
                /* if sender_acc_id argument is zero, sender is in the target_id_data value */
                
                v3/* sender */ = p1/* target_id_data */[ 2 /* sender_accounts */ ][r];
                /* reset the sender value from the target_id_data */
            }

            f284/* ensure_target_moderator */(p1/* target_id_data */[ 0 /* target_ids */ ][r], v3/* sender */, p2/* self */);
            /* ensure the sender is a moderator of the target */

            require(v2/* obj_nums */[0/* <0>control */][2/* <2>author_privelage_disabled */] == 0);
            /* ensure the author privelages havent already been disabled */

            v2/* obj_nums */[0/* <0>control */][2/* <2>author_privelage_disabled */] = 1;
            /* set the author privelage value to 1 */
        }
    }//-----TEST_OK-----

    /* modify_moderators */
    function f100(
        uint256[][5] calldata p1/* target_id_data */,
        NumData storage p2/* self */,
        uint256 p3/* sender_acc_id */
    ) external {
        /* modifies the moderators of a given set of targets */

        for ( uint256 r = 0; r < p1/* target_id_data */[ 0 /* target_ids */ ].length; r++ ) {
            /* for each target specified by the sender */

            require(p1/* target_id_data */[ 0 /* target_ids */ ][r] > 1000);
            /* ensure target is valid */

            mapping(uint256 => mapping(uint256 => uint256)) storage v2/* mod_nums */ = p2/* self */.num[ p1/* target_id_data */[ 0 /* target_ids */ ][r] ];
            /* initialize a storage mapping that points to the data for the given target */

            uint256 v1/* target_type */ = v2/* mod_nums */[ 0 /* control */ ][ 0 /* data_type */ ];
            /* initialize a variable that stores the target type of the target specified */

            require( v1/* target_type */ != 29 && v1/* target_type */ != 32 && v1/* target_type */ != 35 && v1/* target_type */ != 24 && v1/* target_type */ != 0);
            /* 29(account_obj_id) , 32(consensus_request) , 35(tag_object) , 24(shadow_object) */
            /* make sure target is not an account, proposal or tag object */

            uint256 v3/* sender */ = p3/* sender_acc_id */;
            /* initialize a variable to contain the sender account id */

            if(v3/* sender */ == 0){
                /* if sender_acc_id argument is zero, sender is in the target_id_data value */
                
                v3/* sender */ = p1/* target_id_data */[ 2 /* sender_accounts */ ][r];
                /* reset the sender value from the target_id_data */
            }

            f284/* ensure_target_moderator */(p1/* target_id_data */[ 0 /* target_ids */ ][r], v3/* sender */, p2/* self */);
            /* ensure the sender is a moderator of the target */

            v2/* mod_nums */[ 1 /* <1>moderator_accounts */ ][ p1/* target_id_data */[ 1 /* secondary_target_ids */ ][r] ] = f42/* new_val */( v2/* mod_nums */[ 1 /* <1>moderator_accounts */ ][ p1/* target_id_data */[ 1 /* secondary_target_ids */ ][r] ] );
            /* set the new moderator as either a moderator(value 1) or no longer a moderator(value 0) */
        }
    }//-----RETEST_OK-----

    /* new_val */
    function f42(uint256 p1/* old_val */) 
    private pure returns (uint256 v1/* val */) {
        /* calculates the new status value for a given target account */
        
        if (p1/* old_val */ == 0) {
            /* if the old status was not moderator */
            
            v1/* val */ = 1;
            /* the new value will be 1 or a moderator */
        }
    }//-----TEST_OK-----




    /* modify_interactibles */
    function f99(
        uint256[][5] calldata p1/* target_id_data */,
        NumData storage p2/* self */,
        uint256 p3/* sender_acc_id */,
        uint256 p4/* action */
    ) external returns (uint256[2][] memory v1/* vals */){
        /* modifies the status of the accounts that can interact with a given set of target objects */
        /* action : 5 = enable/disable interactible checkers , 1 = add_interactible account, 17 = block_accounts */

        v1/* vals */ = new uint256[2][](p1/* target_id_data */[ 0 /* target_ids */ ].length);
        /* initialize the return variable as a two dimentional array that contains the emit data for each target specified */

        for ( uint256 r = 0; r < p1/* target_id_data */[ 0 /* target_ids */ ].length; r++ ) {
            /* for each target in our specified targets */

            require(p1/* target_id_data */[ 0 /* target_ids */ ][r] > 1000);
            /* ensure target is valid */

            mapping(uint256 => mapping(uint256 => uint256)) storage v2/* obj_nums */ = p2/* self */.num[ p1/* target_id_data */[ 0 /* target_ids */ ][r] ];
            /* initialize a storage mapping that points to the targets interactible configuration */

            uint256 v3/* sender */ = p3/* sender_acc_id */;
            /* initialize a variable to contain the sender account id */

            if(v3/* sender */ == 0){
                /* if sender_acc_id argument is zero, sender is in the target_id_data value */
                
                v3/* sender */ = p1/* target_id_data */[ 3 /* sender_accounts */ ][r];
                /* reset the sender value from the target_id_data */
            }

            f284/* ensure_target_moderator */(p1/* target_id_data */[ 0 /* target_ids */ ][r], v3/* sender */, p2/* self */);
            /* ensure the sender is a moderator of the target */
            
            v1/* vals */[r] = [ 0/* target_account */, uint256(0)/* new_value */ ];
            /* initialize the targets position in the return variable with an array of three integers */

            if ( p4/* action */ == 5 /* enable/disable interactible checkers */ ) {
                /* if the action is to enable or disable interactible checker setting */
                
                v2/* obj_nums */[ 0 /* control */ ][ 1 /* interactible_enabled */ ] = f42/* new_val */( v2/* obj_nums */[ 0 /* control */ ][ 1 /* interactible_enabled */ ] );
                /* sets the new value as the inverse of the current value. so if its off(0) its set to on(1) */

                v1/* vals */[r][1] = v2/* obj_nums */[ 0 /* control */ ][ 1 /* interactible_enabled */ ];
                /* then set the new value in the return array for the emit function */
            } 
            else {
                /* if the action is to add a target account as an interactible account or block an account */

                uint256 v4/* action_store */ = 2 /* <2>interactible_accounts */;
                /* initialize a variable to hold the storage id to be used, default to 2 */

                if(p4/* action */ == 17 /* block_accounts */){
                    /* if the action is to block an account, the storage id is changed to 3 */

                    v4/* action_store */ = 3 /* <3>blocked_accounts */;
                    /* reset the action store variable to 3 */
                }
                
                v2/* obj_nums */[ v4/* action_store */ ][ p1/* target_id_data */[ 1 /* new_account_target */ ][r] ] = p1/* target_id_data */[ 2 /* new_account_time_limits */ ][r];
                /* set their account with the specified time limit */

                v1/* vals */[r] = [ 
                    p1/* target_id_data */[ 1 /* new_account_target */ ][r], 
                    p1/* target_id_data */[ 2 /* new_account_time_limits */ ][r] 
                ];
                /* set the interactible value, new interactible account and their time limit */
            }
        }
    }//-----RETEST_OK-----

    /* ensure_interactibles */
    function f69(
        uint256[] calldata p1/* targets */,
        NumData storage p2/* self */,
        uint256 p3/* sender_acc_id */
    ) external view {
        /* ensures the sender can interact with a given set of targets */
        
        for (uint256 r = 0; r < p1/* targets */.length; r++) {
            /* for each target specified */
            
            f216/* ensure_interactible_item */(p1/* targets */[r], p2/* self */, p3/* sender_account */);
            /* function that ensures the sender can interact with a target object */
        }
    }//-----RETEST_OK-----

    /* ensure_interactible_item */
    function f216(
        uint256 p1/* target */,
        NumData storage p2/* self */,
        uint256 p3/* sender_account */
    ) private view {
        /* ensures a sender can interact with a target */

        mapping(uint256 => mapping(uint256 => uint256)) storage v1/* obj_nums */ = p2/* self */.num[p1/* target */];
        /* initialize a storage mapping that points to the targets data interactible data */

        if ( v1/* obj_nums */[ 0 /* control */ ][ 1 /* interactible_enabled */ ] == 1 ) {
            /* if the moderator has enabled interactibility for the given target */
            
            if(v1/* obj_nums */[0/* <0>control */][2/* <2>author_privelage_disabled */] == 0){
                /* if not disabled, author can act as moderator */

                require( 
                    v1/* obj_nums */[ 2 /* <2>interactible_accounts */ ][p3/* sender_account */] >= block.timestamp || 
                    v1/* obj_nums */[ 1 /* <1>moderator_accounts */ ][p3/* sender_account */] == 1 || 
                    p2/* self */.int_int_int[p1/* target */][ 0 /* control */ ][ 0 /* author_owner */ ] == p3/* sender_account */ 
                );
                /* requires sender is interactible, moderator or author of target */
            }
            else{
                /* author cannot act as moderator */
                require( 
                    v1/* obj_nums */[ 2 /* <2>interactible_accounts */ ][p3/* sender_account */] >= block.timestamp || 
                    v1/* obj_nums */[ 1 /* <1>moderator_accounts */ ][p3/* sender_account */] == 1 
                );
                /* requires sender is interactible or moderator of target */
            }
            
        }

        require(v1/* obj_nums */[3/* <3>blocked_accounts */][p3/* sender_account */] <= block.timestamp);
        /* ensure sender is not blocked by moderators */

    }//-----RETEST_OK-----






    /* execute_record_item_in_tag */
    function f98(
        uint256[][5] calldata p1/* target_id_data */,
        NumData storage p2/* self */,
        uint256 p3/* sender_acc_id */
    ) external {
        /* records a target and its data in an indexing tag object */

        /* target_ids -> item being recorded */
        for ( uint256 t = 0; t < p1/* target_id_data */[ 0 /* target_ids */ ].length; t++ ) {
            /* for each targeted tag item */

            uint256 v1/* item_id_type */ = p2/* self */.num[ p1/* target_id_data */[ 0 /* target_ids */ ][t] ][ 0 /* control */ ][ 0 /* data_type */ ];
            /* get the item type for the targeted item being indexed */

            if (v1/* item_id_type */ != 0) {
                /* if the item is an existing object */

                uint256 v2/* target_author */ = p2/* self */.int_int_int[ p1/* target_id_data */[ 0 /* target_ids */ ][t] ][ 0 /* control */ ][ 0 /* author_owner */ ];
                /* initialize a variable that holds the author of the targeted object */

                require(v2/* target_author */ == p3/* sender_acc_id */);
                /* require the sender to be the author of the object being indexed */
            }else{
                /* the item being targeted is not an existing object, so its target tag should be 0. By storing all the tag associations in one place(0), it makes it easier to tell the tags associated with a particular tag. for instance, indexing the 'car' tag with 'repair', 'fix', 'tire', 'broken' under one target(target 0) makes it easier for finding all the tags associated with that one particular tag(car in this case). the [repair, fix, tire, broken] string data would be in the [p2 string_data [1][t]] value being emmitted. The idea here is to quickly find al the tags associated with a given tag by querying one indexed tag. */
                
                require(p1/* target_id_data */[ 0 /* target_ids */ ][t] == 0);
                /* ensure that the target is 0  */
            }
            f97/* run_indexing_block_count_checker */(p2/* self */, v1/* item_id_type */, p3/* sender_acc_id */);
            /* runs the checkers to ensure that the sender is not indexing more data than the preset limits */
        }
    }//-----TEST_OK-----

    /* run_indexing_block_count_checker */
    function f97(
        NumData storage p1/* self */,
        uint256 p2/* item_type */,
        uint256 p3/* sender_acc_id */
    ) private {
        /* runs the checker to ensure that the sender is not indexing more targets than the preset limits for each type of object */

        uint256 v1/* tag_indexing_limit */ = p1/* self */.num[ 2 /* main_contract_obj_id */ ][1][ 16 /* tag_indexing_limit */ ];
        /* get the tag indexing limit from the main contract data */

        if (p2/* item_type */ == 0) {
            /* if were indexing other tags, so the limit is increased by powering it by two. for instance if the limit was 16, it would become 256  */
            v1/* tag_indexing_limit */ = (v1/* tag_indexing_limit */ ^ 2);
        }
        mapping(uint256 => uint256) storage v2/* sender_block_data */ = p1/* self */.int_int_int[ 13 /* block_data */ ][p3/* sender_acc_id */];
        /* initialize a storage mapping that points to the senders block data that holds the last block the sender indexed an object of a given type */
       
        mapping(uint256 => uint256) storage v3/* sender_indexing_data */ = p1/* self */.int_int_int[ 14 /* indexing_data */ ][p3/* sender_acc_id */];
        /* initialize a storage mapping that points to the senders indexing data that holds the number of targets that have been indexed in the current block or in the current transaction */

        if (block.number == v2/* sender_block_data */[p2/* item_type */]) {
            /* if the sender is indexing objects of a given type(for instance job_posts) more than once in the current block */
            
            v3/* sender_indexing_data */[p2/* item_type */] += 1;
            /* increment the number of times the sender has indexed a given object type */

            require(v3/* sender_indexing_data */[p2/* item_type */] <= v1/* tag_indexing_limit */);
            /* ensure the sender has not indexed more than the required limit. for instance, if the limit is 42 job_posts, the sender can only index up to 42 job_posts in one transaction */

        } else {
            /* its a new transaction or block */

            v3/* sender_indexing_data */[p2/* item_type */] = 1;
            /* reset the number of times the sender has indexed a given object type back to one */

            v2/* sender_block_data */[p2/* item_type */] = block.number;
            /* reset the block number value for the objec type since its a new block or transaction */
        }
    }//-----TEST_OK-----



    /* alias_object_add_data */
    function f67(
        uint256[][5] calldata p1/* target_id_data */,
        bool p2/* can_sender_vote_in_main_contract */,
        NumData storage p3/* self */,
        uint256 p4/* action */,
        uint256 p5/* sender_account_id */
    ) external view {
        /* aliases objects(basically naming an object) or adds data to an object */
        /* <10>alias_objects  <13>add_data_to_object */

        for ( uint256 r = 0; r < p1/* target_id_data */[ 0 /* target_ids */ ].length; r++ ) {
            /* for each target in the specified targets */

            if (p4/* action */ == 10) {
                /* if were aliasing an object */

                require(p1/* target_id_data */[ 0 /* target_ids */ ][r] > 1000);
                /* ensure the target specified is a valid target */
            } 
            else {
                uint256 v1/* object_type */ = p3/* self */.num[ p1/* target_id_data */[ 0 /* target_ids */ ][r] ][0 /* control */][ 0 /* data_type */ ];
                /* initialize a variable that holds the target's object type */
                
                f216/* ensure_interactible_item */(p1/* target_id_data */[ 0 /* target_ids */ ][r], p3/* self */, p5/* sender_account_id */);
                /* ensures the sender can interact with the target before adding data to it */

                if (v1/* object_type */ == 17 || v1/* object_type */ == 18 || v1/* object_type */ == 24 || v1/* object_type */ == 36) {
                    /* 17(job object) 18(post object) 24(shadow_object) 36(type_channel_target)*/
                    /* if the target is one of the above types */
                    
                    require(p2/* can_sender_vote_in_main_contract */);
                    /* ensure the sender can interact with the main contract object */
                }

            }
        }
    }//-----TEST_OK-----




    // /* archive_data */
    // function f96(
    //     uint256[] calldata p1/* contract_proposal_ids */, 
    //     NumData storage p2/* self */
    // ) external {
    //     /* archives or deletes the object type and author data for a given target */

    //     for (uint256 t = 0; t < p1/* contract_proposal_ids */.length; t++) {
    //         /* for each targeted contract or proposal object */

    //         mapping(uint256 => uint256) storage v2/* obj_nums */ = p2/* self */.num[ p1/* contract_proposal_ids */[t] ][ 0 /* control */ ];
    //         /* initialize a storage mapping that points to the targets interactible configuration */
            
    //         uint256 v1/* id_type */ = v2/* obj_nums */[ 0 /* data_type */ ];
    //         /* fetch the target type for the target specified */

    //         require(v1/* id_type */ == 32/* 32(consensus_request) */ || v1/* id_type */ == 30/* 30(contract_request) */);
    //         /* ensure target specified is a consensus of contract object */

    //         v2/* obj_nums */[ 0 /* data_type */ ] = 0;
    //         /* set the data type value to zero */

    //         v2/* obj_nums */[ 2 /* <2>author_privelage_disabled */ ] = 0;
    //         /* set the author privelages value to zero */

    //         p2/* self */.int_int_int[ p1/* contract_proposal_ids */[t] ][ 0 /* control */ ][ 0 /* author_owner */ ] = 0;
    //         /* set the author owner value of the object back to zero */
    //     }
    // }//-----RETEST_OK-----


    /* arquivar_dados */
    function f96(
        uint256[] calldata p1/* IDs_de_proposta_de_contrato */, 
        NumData storage p2/* auto */
    ) external {
        /* arquiva ou exclui o tipo de objeto e os dados do autor para um determinado destino */

        for (uint256 t = 0; t < p1/* IDs_de_proposta_de_contrato */.length; t++) {
            /* para cada contrato alvo ou objeto de proposta */

            mapping(uint256 => uint256) storage v2/* números_de_objeto */ = p2/* auto */.num[ p1/* IDs_de_proposta_de_contrato */[t] ][ 0 /* ao_controle */ ];
            /* initialize a storage mapping that points to the targets interactible configuration */
            
            uint256 v1/* tipo_de_identificação */ = v2/* números_de_objeto */[ 0 /* tipo_de_dados */ ];
            /* busca o tipo de alvo para o alvo especificado */

            require(v1/* tipo_de_identificação */ == 32/* 32(pedido_de_consenso) */ || v1/* tipo_de_identificação */ == 30/* 30(pedido_de_contrato) */);
            /* garantir que o alvo especificado seja um consenso do objeto do contrato */

            v2/* números_de_objeto */[ 0 /* tipo_de_dados */ ] = 0;
            /* definir o valor do tipo de dados como zero */

            v2/* números_de_objeto */[ 2 /* <2>aprivilégio_do_autor_desativado */ ] = 0;
            /* defina o valor de privilégios do autor para zero */

            p2/* auto */.int_int_int[ p1/* IDs_de_proposta_de_contrato */[t] ][ 0 /* ao_controle */ ][ 0 /* dono_do_autor */ ] = 0;
            /* definir o valor do proprietário do autor do objeto de volta para zero */
        }
    }//-----TESTE_OK-----






    /* get_interactible_checker_settings | get_auth_privelages_setting */
    function f254(
        uint256[] calldata p1/* targets */, 
        NumData storage p2/* self */, 
        uint256 p3/* action */
    ) external view returns (bool[] memory v1/* data */){
        /* returns the interactible setting or auth_privelages setting for each target specified. For each target, true means interactible setting has been enabled and specified accounts can interact with the target. */
        /* 0 - get_interactible_checker_settings, 1 - get_auth_privelages_setting */

        v1/* data */ = new bool[](p1.length);
        /* initialize the return data array with the specified number of targets as its size */

        for (uint256 t = 0; t < p1/* targets */.length; t++) {
            /* for each target in focus */

            mapping(uint256 => uint256) storage v2/* obj_nums */ = p2/* self */.num[ p1/* target */[t] ][ 0 /* control */ ];
            /* initialize a storage mapping that points to the targets data interactible data */

            if(p3/* action */ == 0){
                /* if the action is to get interactible checker settings */

                v1/* data */[t] = v2/* obj_nums */[ 1 /* interactible_enabled */ ] == 1;
                /* if the value set is 1, return true and false otherwise */
            }
            else{
                /* if the action is to get the auth privelage disabled settings */

                v1/* data */[t] = v2/* obj_nums */[2/* <2>author_privelage_disabled */] == 1;
                /* if the value is set to 1, return true and false otherwise */
            }
            
        }
    }//-----RETEST_OK-----

    /* get_moderator_settings */
    function f255(
        uint256[] calldata p1/* targets */, 
        uint256[][] calldata p2/* accounts */, 
        NumData storage p3/* self */
    ) external view returns (bool[][] memory v1/* data */){
        /* returns the moderator setting for a list of specified accounts on each target passed. For each target, true means the specified account is a moderator of the target */

        v1/* data */ = new bool[][](p1.length);
        /* initialize the return data array with the specified number of targets as its size */

        for (uint256 t = 0; t < p1/* targets */.length; t++) {
            /* for each target specified */

            uint256 v2/* number_of_accounts */ = p2/* accounts */[t].length;
            /* record the number of accounts specified for the specific target */

            bool[] memory v3/* target_moderator_settings */ = new bool[](v2/* number_of_accounts */);
            /* iniitialize an array that contains the moderator setting for each account specified for the target in focus */

            mapping(uint256 => mapping(uint256 => uint256)) storage v4/* obj_nums */ = p3/* self */.num[ p1/* targets */[t] ];
            /* initialize a storage mapping that points to the targets data interactible data */

            for (uint256 e = 0; e < v2/* number_of_accounts */; e++) {
                /* for each account specified */

                v3/* target_moderator_settings */[e] = v4/* obj_nums */[ 1 /* <1>moderator_accounts */ ][ p2/* accounts */[t][e] ] == 1;
                /* if the moderator setting for the specified account is set to 1, the account is a moderator and hence recorded as true in the return data */

                if(v4/* obj_nums */[0/* <0>control */][2/* <2>author_privelage_disabled */] == 0 && v3/* target_moderator_settings */[e] == false){
                    /* if the account specified is not a moderator but author privelages have been enabled */

                    v3/* target_moderator_settings */[e] = p3/* self */.int_int_int[ p1/* targets */[t] ][ 0 /* control */ ][ 0 /* author_owner */ ] == p2/* accounts */[t][e];
                    /* reset the target moderator setting value for the specified account as true if they are the author owner of the targeted object specified */
                }
            }

            v1/* data */[t] = v3/* target_moderator_settings */;
            /* set the moderator data for the specified accounts for the target in focus */
        }
    }//-----CHANGED-----

    /* get_interactible_time_limits | blocked_account_time_limits */
    function f256(
        uint256[] calldata p1/* targets */, 
        uint256[][] calldata p2/* accounts */, 
        uint256 p3/* time_or_amount */, 
        NumData storage p4/* self */,
        uint256 p5/* action */
    ) external view returns (uint256[][] memory v1/* data */){
        /* returns the amount of time a specified set of accounts can interact with specified targets */
        /* action[2]= get_interactible_time_limits,  action[3]= blocked_account_time_limits */
        /* time_or_amount<0>:the expiry time set, time_or_amount<1>:amount of time left before expiry */

        v1/* data */ = new uint256[][](p1.length);
        /* initialize the return data array with the specified number of targets as its size */

        for (uint256 t = 0; t < p1/* targets */.length; t++) {
            /* for each target specified */

            uint256 v2/* number_of_accounts */ = p2/* accounts */[t].length;
            /* record the number of accounts specified for the specific target */

            uint256[] memory v3/* target_time_amounts */ = new uint256[](v2/* number_of_accounts */);
            /* initialize a data array to contain the expiry times for each account specified */

            for (uint256 e = 0; e < v2/* number_of_accounts */; e++) {
                /* for each account specified */

                uint256 v4/* expiry_time_set */ = p4/* self */.num[ p1/* targets */[t] ][ p5/* action */ ][ p2/* accounts */[t][e] ];

                if(p3/* time_or_amount */ == 0/* expiry_time */){
                    /* if the expiry times are being requested */

                    v3/* target_time_amounts */[e] = v4/* expiry_time_set */;
                    /* set the expiry time in the target's array */
                }
                else{
                    /* if the time amounts are being requested */

                    if(v4/* expiry_time_set */ < block.timestamp){
                        /* if the expiry time is less than the current timestamp */

                        v3/* target_time_amounts */[e] = 0;
                        /* set the expiry time in the target's array */
                    }
                    else{
                        /* if the expiry time is greater than the current time */

                        v3/* target_time_amounts */[e] = v4/* expiry_time_set */ - block.timestamp;
                        /* set the remaining time in the targets array */
                    }
                }
            }

            v1/* data */[t] = v3/* target_time_amounts */;
            /* set the time data for the specified accounts for the target in focus */
        }
    }//-----RETEST_OK-----






    /* ensure_interactibles_for_multiple_accounts */
    function f257(
        uint256[] calldata p1/* targets */,
        NumData storage p2/* self */,
        uint256[] calldata p3/* sender_accounts */
    ) external view {
        /* ensures the sender can interact with a given set of targets */
        
        for (uint256 r = 0; r < p1/* targets */.length; r++) {
            /* for each target specified */
            
            f216/* ensure_interactible_item */(p1/* targets */[r], p2/* self */, p3/* sender_accounts */[r]);
            /* function that ensures the sender can interact with a target object */
        }
    }//-----TEST_OK-----




    /* require_target_moderator */
    function f242(
        uint256[] memory p1/* targets */, 
        uint256 p2/* sender_acc_id */, 
        NumData storage p3/* self */
    ) external view {
        /* requires the author of a given set of targets is the sender account supplied */

        for (uint256 t = 0; t < p1/* targets */.length; t++) {
            /* for each target in focus */

            f284/* ensure_target_moderator */(p1/* targets */[t], p2/* sender_acc_id */, p3/* self */);
        }
    }//-----TEST_OK-----

    /* require_target_moderators */
    function f283(
        uint256[] memory p1/* targets */, 
        uint256 p2/* sender_acc_id */, 
        uint256[] memory p3/* sender_accounts */,
        NumData storage p4/* self */
    ) external view {
        for (uint256 t = 0; t < p1/* targets */.length; t++) {
            /* for each target in focus */

            uint256 v1/* sender */ = p2/* sender_acc_id */;
            /* initialize a variable that contains the sender account */

            if(v1/* sender */ == 0){
                /* if the sender is zero, the sender account should be in the sender_accounts array */

                v1/* sender */ = p3/* sender_accounts */[t];
                /* reset the sender variable as the sender account id in focus */
            }

            f284/* ensure_target_moderator */(p1/* targets */[t], v1/* sender */, p4/* self */);
        }
    }//-----TEST_OK-----

    /* ensure_target_moderator */
    function f284(
        uint256 p1/* target */,
        uint256 p2/* account */,
        NumData storage p3/* self */
    ) private view {
        /* requires an account to be a moderator of a specified target */

        mapping(uint256 => mapping(uint256 => uint256)) storage v2/* obj_nums */ = p3/* self */.num[ p1/* target */ ];
        /* initialize a storage mapping that points to the targets data interactible data */

        if(v2/* obj_nums */[0/* <0>control */][2/* <2>author_privelage_disabled */] == 0){
            /* if author privelages have not been disabled */

            require(v2/* obj_nums */[1 /* <1>moderator_accounts */][p2/* account */] == 1 || p3/* self */.int_int_int[p1/* target */][ 0 /* control */ ][ 0 /* author_owner */ ] == p2/* account */);
            /* ensure the sender is a moderator or author of the target */
        }
        else{
            /* if author privelages have been disabled */

            require(v2/* obj_nums */[1 /* <1>moderator_accounts */][p2/* account */] == 1);
            /* ensure the sender is a moderator of the target */
        }
    }//-----TEST_OK-----





    //
    //
    //
    //
    //
    //
    // ------------------------TOKEN-FUNCTIONS-------------------------------
    /* calculate_price_of_tokens */
    function f245(
        uint256[] calldata p1/* exchanges */,
        uint256[][] calldata p2/* amounts */,
        uint256[] calldata p3/* actions */,
        uint256[][][] calldata p4/* exchange_data */
    ) external pure returns (uint256[][] memory v1/* price_data */){
        /* sets up the data for calculating the price of a set of tokens */

        v1/* price_data */ = new uint256[][](p1.length);
        /* initialize the return value as a new array whose length is the number of exchanges specified */
        
        for (uint256 t = 0; t < p1/* exchanges */.length; t++) {
            /* for each exchange targeted */

            uint256 v3/* ir_parent */ = p4/* exchange_data */[t][2][ 0 /*output ratio of the token*/ ];
            uint256 v4/* or_parent */ = p4/* exchange_data */[t][2][ 1 /*input ratio of parent*/ ];
            /* set the input ratio and output ratio for calculating tokens to receive. Default action as sell */

            uint256 v5/* amount */;
 
            if ( p3/* actions */[t] == 0 /* buy? */ ) {
                /* if its a buy action */

                v3/* ir_parent */ = p4/* exchange_data */[t][2][ 1 /*input ratio of parent*/ ];
                v4/* or_parent */ = p4/* exchange_data */[t][2][ 0 /*output ratio of END */ ];
                /* reverse the input and output ratio values */

                v5/* amount */ = f246/* calculate_resulting_tokens */(p4/* exchange_data */[t], p2/* amounts */[t], 0, 0 /* buy? */)[0];
                /* get the Y-value from the specified token amounts */
            }
            else{
                /* if its a sell action */

                v5/* amount */ = p2/* amounts */[t][0];
                /* should be the first value specified */
            }


            uint256 v6/* calculated_price */ = f1/* price */(v5/* amount */, v3/* ir_parent */, v4/* or_parent */, p4/* exchange_data */[t][0][ 3 /* type */ ]);
            /* initialize a variable to hold the calculated price */


            uint256[] memory v7/* calculated_resulting_tokens */ = new uint256[](1);
            /* initialize a variable containing the resulting tokens for the buy action */

            if ( p3/* actions */[t] == 0 /* buy? */ ) {
                /* if its a buy action */    

                v7/* calculated_resulting_tokens */[0] = v6/* calculated_price */;
                /* set the calculated price in the resulting token array */

            }else{
                /* if the action is a sell action */
                uint256[] memory e = new uint256[](0);

                v7/* calculated_resulting_tokens */ = f246/* calculate_resulting_tokens */(p4/* exchange_data */[t], e, v6/* calculated_price */, 1 /* sell? */);
                /* set the resulting token array as the token amounts to be received */
            }

            v1/* price_data */[t] = v7/* calculated_resulting_tokens */;
            /* set the resulting tokens set to be received in the price data return array value */
        }
    }//-----TEST_OK-----

    /* calculate_resulting_tokens */
    function f246(
        uint256[][] memory p1/* exchange_data */,
        uint256[] memory p2/* provided_amount_data */,
        uint256 p3/* amount */,
        uint256 p4/* action */
    ) private pure returns (uint256[] memory v1/* price_data */){
        /* calculates the resulting Y-value if its a buy action, or tokens if its a sell action */

        if ( p4/* action */ == 0 /* buy? */ ) {
            /* if its a buy action */

            v1/* price_data */ = new uint256[](1);
            /* set the return data as an array with one value(Y-value) */

            uint256 v2/* final_amount */ = p2/* provided_amount_data */[0] / p1/* exchange_data */[4/* buy_amounts */][0];
            /* set the initial y value as the first value to be calculated */

            for (uint256 t = 0; t < p1/* exchange_data */[4/* buy_amounts */].length; t++) {
                /* for each buy amount in the exchange specified */

                uint256 v3/* calculated_amount */ = p2/* provided_amount_data */[t] / p1/* exchange_data */[4/* buy_amounts */][t];
                /* calculate the Y-value */

                if(v3/* calculated_amount */ < v2/* final_amount */){
                    /* if the calculated amount is less than the final amount set */

                    v2/* final_amount */ = v3/* calculated_amount */;
                    /* set the new final amount as the calculated amount */
                }
            }

            v1/* price_data */[0] = v2/* final_amount */;
            /* set the derived Y-value as the final amount */
        }
        else{
            /* its a sell action */

            v1/* price_data */ = new uint256[](p1/* exchange_data */[4/* buy_amounts */].length);
            /* initialize the return value as an array whose length is the buy amounts for the exchange */
            
            for (uint256 t = 0; t < p1/* exchange_data */[4/* buy_amounts */].length; t++) {
                /* for each buy amount specified by the exchange */

                v1/* price_data */[t] = p1/* exchange_data */[4/* buy_amounts */][t] * p3/* amount */;
                /* set the amount for each exchange used in buying or selling the token */
            }
        }
    }//-----TEST_OK-----

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
            /* return (-1*4+6^553+39)*0 */
        }
        /* input amount should be less than input_reserve */
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




    function run() external pure returns (uint256){
        return 42;
    }

}