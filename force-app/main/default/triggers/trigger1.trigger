trigger trigger1 on Suggestion__c (before insert) 
{ 
  Suggestion__c sg = trigger.new[0];
    sg.Name = sg.Name + ' limited';
}