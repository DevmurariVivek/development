public with sharing class OpportunityTriggerHandler {
    public static void onAfterInsert(List<Opportunity> newOpp) {

        System.debug('In onAfterInsert of OpportunityTrigger');
        //validateOpportunity(newOpp);
        rollupOnAccountAfterInsert(newOpp); 

    }

    public static void onBeforeInsert(List<Opportunity> newOpp) {

        System.debug('In onBeforeInsert of OpportunityTrigger');
        //validateOpportunity(newOpp);
    }

    public static void onAfterUpdate(List<Opportunity> newOpp, List<Opportunity> oldOpp, Map<Id,Opportunity> newOppMap, Map<Id,Opportunity> oldOppMap) {

        System.debug('In onAfterUpdate of OpportunityTrigger');
        //validateOpportunity(newOpp);
        rollupOnAccountAfterUpdate(newOpp, oldOpp, newOppMap, oldOppMap); 
        
    }

    public static void onBeforeUpdate(List<Opportunity> newOpp, List<Opportunity> oldOpp, Map<Id,Opportunity> newOppMap, Map<Id,Opportunity> oldOppMap) {

        System.debug('In onBeforeUpdate of OpportunityTrigger');
        //validateOpportunity(newOpp, oldOpp, oldOppMap);
        //updateAmount(newOpp , oldOppMap);
    }

    public static void onAfterDelete(List<Opportunity> oldOpp, Map<Id, Opportunity> oldOppMap){

        System.debug('In onAfterDelete of OpportunityTrigger');
        //postOppDeleteOperations(oldOpp , oldOppMap);
        rollupOnAccountAfterDelete(oldOpp, oldOppMap); 
    }

    public static void onBeforeDelete(List<Opportunity> oldOpp, Map<Id, Opportunity> oldOppMap){

        System.debug('In onBeforeDelete of OpportunityTrigger');
        // postOppDeleteOperations(oldOpp , oldOppMap); 
        // rollupOnAccountDelete(oldOpp, oldOppMap); -< not applicable for the before delete event 
    }

    public static void onAfterUnDelete(List<Opportunity> newOpp, Map<Id, Opportunity> newOppMap){

        System.debug('In onAfterUnDelete of OpportunityTrigger');
        // postOppDeleteOperations(oldOpp , oldOppMap); 
        rollupOnAccountAfterUndelete(newOpp, newOppMap);
    }

    public static void rollupOnAccountAfterInsert(List<Opportunity> newOpp){

        System.debug('Inside rollupOnAccountAfterInsert');
        // see if the current opp's amount is filled (we're in insert)
        // if yes, check if account is filled 
        // if yes, query all other related / sibling opps
        // use aggregate to sum up total amount
        // update the account

        Set<Id> accountIds = new Set<Id>();
        for (Opportunity opp : newOpp){
            if(opp.Amount != null && opp.AccountId != null){
                accountIds.add(opp.AccountId);
            }
        }
        System.debug(' The accountids ---> ' + accountIds);

        Map<Id, Decimal> accountIdToAmount = new Map<Id, Decimal>();
        for (AggregateResult ar : [SELECT SUM(Amount) Amount, AccountId 
                                   FROM Opportunity 
                                   WHERE AccountId IN : accountIds 
                                   WITH SECURITY_ENFORCED
                                   GROUP BY AccountId]){

                accountIdToAmount.put( (Id)ar.get('AccountId') , (Decimal)ar.get('Amount'));
                System.debug('The Ar ===>  ' + ar);
        }
        System.debug('Th Map --> ' + accountIdToAmount);

        List<Account> accToUpdate = new List<Account>(); 
        for (Account acc : [SELECT AnnualRevenue, Id FROM Account WHERE Id IN : accountIds]){
            
            acc.AnnualRevenue = accountIdToAmount.get(acc.Id);
            accToUpdate.add(acc);
        }

        if(!accToUpdate.IsEmpty()){
            System.debug(' The accToUpdate ---<> ' + accToUpdate);
            update accToUpdate;
        }
    }

    public static void rollupOnAccountAfterUpdate(List<Opportunity> newOpp, List<Opportunity> oldOpp, Map<Id,Opportunity> newOppMap, Map<Id,Opportunity> oldOppMap){

        System.debug(' in rollupOnAccountAfterUpdate');

        Set<Id> accountIds = new Set<Id>();
        for ( Opportunity opp : newOpp){

            if(opp.Amount != null && opp.Amount != oldOppMap.get(opp.Id).Amount && opp.AccountId != null){
                accountIds.add(opp.AccountId);
            }
        }

        System.debug('The accountIds ---> ' + accountIds);

        Map<Id, Decimal> accountIdToAmount = new   Map<Id, Decimal> ();
        List<Account> accToUpdate = new List<Account>();

        for(AggregateResult ar : [SELECT SUM(Amount) Amount, AccountId
                                  FROM Opportunity 
                                  WHERE AccountId IN : accountIds
                                  GROUP BY AccountId]){
               // Account acc = new Account ();

                accountIdToAmount.put( (Id)ar.get('AccountId'), (Decimal)ar.get('Amount'));
                //accToUpdate.add(acc);  
        }

        System.debug('The accountIdToAmount ---> ' + accountIdToAmount);

        for(Account acc : [SELECT Id, AnnualRevenue FROM Account WHERE Id IN : accountIds]){
            if(accountIdToAmount.containsKey(acc.id)){
                // Account acc = new Account ();
                acc.AnnualRevenue = accountIdToAmount.get(acc.Id);
                accToUpdate.add(acc);
            }
        }

        if(!accToUpdate.IsEmpty()){
            System.debug('The ids ---> ' + accToUpdate);
            update accToUpdate;
        }

    }

    public static void rollupOnAccountAfterDelete(List<Opportunity> oldOpp, Map<Id, Opportunity> oldOppMap){

        System.debug(' In rollupOnAccountAfterDelete');

        // here i.e. one opp is getting deleted, 
        // now we have to reduce the amount that is been added on parent account record / substact 
        // first query all opp records that are deleted,
        // get all the related opps, 
        // re-calculate and update accounts. 

        // ideally here we dont have to recalculate / substact the amount as the aggregate sum will be performed only on opps that are not deleted

        Set<Id> accountIds = new Set<Id>();
        for ( Opportunity opp : oldOpp){

            if(opp.Amount != null && opp.AccountId != null){
                accountIds.add(opp.AccountId);
            }
        }

        System.debug('The accountIds ---> ' + accountIds);

        Map<Id, Decimal> accountIdToAmount = new   Map<Id, Decimal> ();
        List<Account> accToUpdate = new List<Account>();

        for(AggregateResult ar : [SELECT SUM(Amount) Amount, AccountId
                                  FROM Opportunity 
                                  WHERE AccountId IN : accountIds
                                  GROUP BY AccountId]){
               // Account acc = new Account ();

                accountIdToAmount.put( (Id)ar.get('AccountId'), (Decimal)ar.get('Amount'));
                //accToUpdate.add(acc);  
        }

        System.debug('The accountIdToAmount ---> ' + accountIdToAmount);

        for(Account acc : [SELECT Id, AnnualRevenue FROM Account WHERE Id IN : accountIds]){
            if(accountIdToAmount.containsKey(acc.id)){
                // Account acc = new Account ();
                acc.AnnualRevenue = accountIdToAmount.get(acc.Id);
                accToUpdate.add(acc);
            }
        }

        if(!accToUpdate.IsEmpty()){
            System.debug('The ids ---> ' + accToUpdate);
            update accToUpdate;
        }
    }

    public static void rollupOnAccountAfterUndelete(List<Opportunity> newOpp, Map<Id, Opportunity> newOppMap){

        System.debug(' In rollupOnAccountAfterUndelete');

        // here we are perfomring the undelete, so the trigger context will run on the new opps
        // in undelete operation, the old id of opp will be retained ?  
        // old : 006J400000LUTPRIA5
        // new : 006J400000LUTPRIA5
        // here is ids are same for restored opp. how come that is considered as insert operation ?

        Set<Id> accountIds = new Set<Id>();
        for ( Opportunity opp : newOpp){

            if(opp.Amount != null && opp.AccountId != null){
                accountIds.add(opp.AccountId);
            }
        }

        System.debug('The accountIds ---> ' + accountIds);

        Map<Id, Decimal> accountIdToAmount = new   Map<Id, Decimal> ();
        List<Account> accToUpdate = new List<Account>();

        for(AggregateResult ar : [SELECT SUM(Amount) Amount, AccountId
                                  FROM Opportunity 
                                  WHERE AccountId IN : accountIds
                                  GROUP BY AccountId]){
               // Account acc = new Account ();

                accountIdToAmount.put( (Id)ar.get('AccountId'), (Decimal)ar.get('Amount'));
                //accToUpdate.add(acc);  
        }

        System.debug('The accountIdToAmount ---> ' + accountIdToAmount);

        for(Account acc : [SELECT Id, AnnualRevenue FROM Account WHERE Id IN : accountIds]){
            if(accountIdToAmount.containsKey(acc.id)){
                // Account acc = new Account ();
                acc.AnnualRevenue = accountIdToAmount.get(acc.Id);
                accToUpdate.add(acc);
            }
        }

        if(!accToUpdate.IsEmpty()){
            System.debug('The ids ---> ' + accToUpdate);
            update accToUpdate;
        }
    }

    public static void updateAmount(List<Opportunity> newOpp , Map<Id,Opportunity> oldOppMap){

        List<Opportunity> oppToUpdate = new List<Opportunity>();
        for (Opportunity opp : newOpp){
            if(opp.StageName != oldOppMap.get(opp.Id).StageName){
                opp.Amount = opp.ExpectedRevenue * opp.Probability;
                //oppToUpdate.add(opp);
            }
        }

        // if(!oppToUpdate.isEmpty()){
        //     System.debug('The updated Opportunity ---> '  + oppToUpdate);
        //     update oppToUpdate;
        // }
    }

    public static void postOppDeleteOperations(List<Opportunity> oldOpp , Map<Id,Opportunity> oldOppMap){
        
        Map<Id,Id> oppToAccountMap = new Map<Id,Id>();
        Set<Id> accountIds = new Set<Id>();

        for (Opportunity opp : oldOpp){
            if(opp.accountId != null){
                accountIds.add(opp.accountId);
                oppToAccountMap.put(opp.Id , opp.accountId);
            }
        }

        Map<Id,Id> accToOwnerMap = new Map<Id,Id>();
        for (Account acc : [SELECT Id,OwnerId FROM Account WHERE Id IN : accountIds WITH SECURITY_ENFORCED]){
            accToOwnerMap.put(acc.Id , acc.OwnerId);
        }

        List<Task> tasklist = new List<Task>();
        for (Opportunity opp : oldOpp){
            if(opp.AccountId != null){
                Task tsk = new Task();
                tsk.WhatId = opp.AccountId;
                tsk.Subject = 'Opportunity ' + opp.Name + ' Is been deleted';
                tsk.OwnerId = accToOwnerMap.get(oppToAccountMap.get(opp.Id));
                tasklist.add(tsk);
            }
        }

        if(tasklist != null){
            System.debug('The tasklist ---> ' + tasklist);
            insert tasklist;
        }
    }

    public static void validateOpportunity (List<Opportunity> newOpp, List<Opportunity> oldOpp, Map<Id,Opportunity> oldOppMap){
        // Approach 1 : This does not use nested loops, handles code using map

        // 1. Query OppIds
        Set<Id> oppIds = new Set<Id>();
        for (Opportunity opp : newOpp){
            
            if(opp.StageName == 'Closed Won' && opp.StageName != oldOppMap.get(opp.Id).StageName && oldOppMap.containsKey(opp.Id)){
                oppIds.add(opp.Id);
            }
        }
        System.debug('The oppIds ---> ' + oppIds);


        // 2. Query related oppolineitems
        Map<Id, List<OpportunityLineItem>> oppToLineItemsMap = new  Map<Id, List<OpportunityLineItem>>();
        for (OpportunityLineItem olt : [SELECT Id,Name,OpportunityId FROM OpportunityLineItem WHERE OpportunityId IN : oppIds WITH SECURITY_ENFORCED]){
            if(!oppToLineItemsMap.containsKey(olt.OpportunityId)){
                oppToLineItemsMap.put(olt.OpportunityId , new List<OpportunityLineItem>());
            }
            oppToLineItemsMap.get(olt.OpportunityId).add(olt);
        }
        System.debug('oppToLineItemsMap ---> ' + oppToLineItemsMap);

        // 3. validate the opp 
        for (Opportunity opp : newOpp){
            if(opp.StageName == 'Closed Won' && oppIds.contains(opp.Id) && opp.StageName != oldOppMap.get(opp.Id).StageName){

                List<OpportunityLineItem> oltlist = oppToLineItemsMap.get(opp.Id);

                if(oltlist == null || oltlist.isEmpty()){
                    opp.addError('Please add atleast one product to the opportunity to mark it closed won.');
                }
            }
        }

        // Approach 2 : But this uses nested for loops 
        // for (Opportunity opp : newOpp){

        //     List<OpportunityLineItem> oltList = new List<OpportunityLineItem>();
        //     List<OpportunityLineItem> oltToQuery = [SELECT Id FROM OpportunityLineItem WHERE OpportunityId =: opp.Id WITH SECURITY_ENFORCED];

        //     //Opportunity oldRecord = Trigger.oldMap.get(opp.Id);
        //     if (opp.StageName == 'Closed Won' && opp.StageName != oldOppMap.get(opp.Id).StageName){

        //         for (OpportunityLineItem olt : oltToQuery){
    
        //             oltList.add(olt);
        //         }

        //         System.debug('Olt size ---> ' + oltList.size());

        //         If(oltList.size() == 0 ){
        //             opp.addError('Please add atleast one product with the opportunity to make it Closed Won');
        //         }
        //     }
        // }
    }
}