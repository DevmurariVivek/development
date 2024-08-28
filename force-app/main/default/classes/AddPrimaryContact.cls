public without sharing class AddPrimaryContact implements Queueable{

    //Creating Constructor class
    private Contact contact;
    private String state;

    public AddPrimaryContact(Contact inputContact , String inputstate) {

    //Creating instaces of class for contact and state
    this.contact = inputContact;
    this.state = inputstate;
    }

    //creating execute method 
    public void execute(QueueableContext context){

        //Retrieve 200 account records
        List<Account> accounts = [SELECT Id FROM Account WHERE BillingState = :state LIMIT 200];

        //Create empty list of contacts
        List<Contact> contacts = new List<Contact>();

        //iterate through accounts records
        for (Account acc : accounts) {
             
            //clone the contact record , make clone of the child of specific account , and than add it to list of contacts
            Contact contactclone = contact.clone();
            contactclone.AccountId = acc.Id;
            contacts.add(contactclone);     
        }
        insert contacts;
    }
}