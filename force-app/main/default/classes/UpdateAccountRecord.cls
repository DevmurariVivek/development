//Code to update parent account of prticular account using queueable apex
public class UpdateAccountRecord implements Queueable{

    private List<Account> accList;
    private Id parentId;

    public UpdateAccountRecord(List<Account> accRecord ,Id id){
        this.accList = accRecord;
        this.parentId = id;

    }
    public void execute(QueueableContext context){
        for (Account acc : accList) {
            acc.ParentId=parentId;
            
        }
        update accList;

    }
}