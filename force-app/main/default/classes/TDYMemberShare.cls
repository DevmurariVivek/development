public without sharing class TDYMemberShare {
    @InvocableMethod(label='Invoke Apex for Member Sharing')
    public static void insertGroupMember(List<FlowInputs> request) {
        // List<FlowOutputs> results = new List<FlowOutputs>();

        String userId = request[0].userId;
        String groupId = request[0].groupId;
        insertQueueMemberHelper(userId, groupId);
        
    }
    
    // This future method will asynchronously insert the group member.
    @future
    public static void insertQueueMemberHelper(String userId, String groupId) {

		GroupMember member = new GroupMember();
        member.UserOrGroupId = groupId;
        member.GroupId = userId;
        insert member; 
    }

    // Input details that come to Apex from the flow
    public class FlowInputs {
        @InvocableVariable
        public String userId;
        
        @InvocableVariable
        public String groupId;
    }
}