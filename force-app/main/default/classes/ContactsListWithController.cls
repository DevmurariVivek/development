public class ContactsListWithController {
    
    public List<Contact> getContacts() {
        List<Contact> results = Database.query(
            'SELECT Id, FirstName, LastName, Title, Email ' +
            'FROM Contact '
        );
        return results;
    }
    public List<Account> getAccounts() {
        System.debug('Account ++++');
        List<Account> results =[Select id,name from Account limit 10];
        System.debug('Result::'+results);
        return results;
    }
    
}