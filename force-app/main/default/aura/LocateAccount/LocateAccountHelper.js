({
    getData: function(component,event,helper){
        var action = component.get("c.AccountData");
        action.setParams({
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                var records =response.getReturnValue();
                records.forEach(function(record){
                    record.linkName = '/'+record.Id;
                });
                component.set("v.acclst", records);
             //   console.log('here'+JSON.stringify(records));
                component.set('v.filteredData', records); 

                this.preparePagination(component, response);
         
            }
        });
        $A.enqueueAction(action);

    },  
   
    searchRecordsBySearchPhrase : function (component) {
        
    /* action.setParams({ searchKey : component.get("v.searchPhrase"),
        });
       if (!$A.util.isEmpty(searchPhrase)) { */
            let searchPhrase = component.get("v.searchPhrase");
            let acclst = component.get("v.acclst");    
            let filteredData = acclst.filter(record => record.Name.includes(searchPhrase));
            component.set("v.filteredData", filteredData);
             this.preparePagination(component, filteredData);

      //  }else{
      //      alert('Kindly Add Some Keywords Into Search Box...');
       // }
    },    
    
    viewRecord : function(component, event) {
        var row = event.getParam('row');
        var recordId = row.Id;
        var viewRec= $A.get("event.force:navigateToSObject");
        viewRec.setParams({
            "recordId": recordId,
            "slideDevName": "detail"
        });
        viewRec.fire();
     
    },
    editRecord : function(component, event) {
        var row = event.getParam('row');
        var recordId = row.Id;
        var editRec= $A.get("event.force:editRecord");
        editRec.setParams({
            "recordId": recordId
        });
        editRec.fire();
        
    },
    deleteRecord : function(component, event) {
       
        var accountRec = event.getParam('row');        
        var action = component.get("c.delAccount");
        action.setParams({
            "accountRec": accountRec
        }); 
        action.setCallback(this, function(response) {
                      
            if (response.getState() === "SUCCESS" ) {
                $A.get('e.force:refreshView').fire();
                var rows = component.get('v.acclst');
                var rowIndex = rows.indexOf(accountRec);
                rows.splice(rowIndex, 1);
                component.set('v.filteredData', rows);
                this.showToast("Success!","success","The record has been delete successfully.");
            }
            else{
                this.showToast("ERROR","error","Can't delete account due to case is linked",JSON.stringify(response.getError())); 
            }
        });
        $A.enqueueAction(action);
    },


    preparePagination: function (component, response) {
        let countTotalPage = Math.ceil(response.length/component.get("v.pageSize"));
        let totalPage = countTotalPage > 0 ? countTotalPage : 1;
       
        console.log(totalPage);  
        component.set("v.totalPages", totalPage);   
        
        component.set("v.currentPageNumber", 1); 
           
        this.setPageDataAsPerPagination(component);
    },      
 
    setPageDataAsPerPagination: function(component) {
        let data = [];
        let pageNumber = component.get("v.currentPageNumber");

      
        let pageSize = component.get("v.pageSize");
        let filteredData = component.get('v.filteredData');
        let x = (pageNumber - 1) * pageSize;
        for (; x < (pageNumber) * pageSize; x++){
            if (filteredData[x]) {
                data.push(filteredData[x]);
            }
        }
       
        component.set("v.tableData", data);
        this.generatePageList(component, pageNumber);
    },
   /* generatePageList : function(component, pageNumber){
        pageNumber = parseInt(pageNumber);
        console.log(pageNumber);
        var pageList = [];
       
        var totalPages = component.get("v.totalPages"); 
        
        component.set(totalPages,pageNumber); 

        if(totalPages < 1){
            
            if(totalPages <= 3){
                var counter = 2;
                for(; counter < (totalPages); counter++){
                    pageList.push(counter);
                }
                
            }else{
                if(pageNumber < 5){  
                    pageList.push(2, 3 , 4);
                }else{
                    if(pageNumber<(totalPages-1)){
                        pageList.push('...')
                        pageList.push(pageNumber-1,pageNumber, pageNumber+1);
                        pageList.push('...')
                    }else{
                        pageList.push('...')
                        pageList.push(totalPages-1);
                        }
                    }
                }
              console.log({pageList});   
         }
        component.set("v.pageList", pageList);
    
}, */
  generatePageList : function(component, pageNumber){
        pageNumber = parseInt(pageNumber);
        var pageList = [];

        var totalPages = component.get("v.totalPages");

        if(totalPages > 1){
            
            if(totalPages <= 3){
                var counter = 2;
                for(; counter < (totalPages); counter++){
                    pageList.push(counter);
                }
                
            }else{
                if(pageNumber < 5){  
                    pageList.push(2, 3 , 4);
                }else{
                    if(pageNumber<(totalPages-1)){
                        pageList.push('...')
                        pageList.push(pageNumber-1,pageNumber, pageNumber+1);
                        pageList.push('...')
                    }else{
                        pageList.push('...')
                        pageList.push(totalPages-1);
                        }
                    }
                }
                console.log({pageList});   
            }
        component.set("v.pageList", pageList);
        },

    showToast:function(title,type,message){
        var toastEvent = $A.get("e.force:showToast");
        if(toastEvent){
            toastEvent.setParams({"title": title,"type": type,"message": message}).fire();
        }
        else{
            alert(message);
        }
    },
    sortData : function(component,fieldName,sortDirection){
        var data = component.get("v.tableData");
        var key = function(a) { return a[fieldName]; }
        var reverse = sortDirection == 'asc' ? 1: -1;
 
        if(fieldName == 'Phone'){ 
            data.sort(function(a,b){
                var a = key(a) ? key(a) : '';
                var b = key(b) ? key(b) : '';
                return reverse * ((a>b) - (b>a));
            }); 
        }
        else{
            data.sort(function(a,b){ 
                var a = key(a) ? key(a).toLowerCase() : '';
                var b = key(b) ? key(b).toLowerCase() : '';
                return reverse * ((a>b) - (b>a));
            });    
        }
        component.set("v.tableData",data);
    }, 
 
  
    showSuccessToast: function(component,event,helper,type,message){
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "title": "Success!",
            "type": type,
            "message": message
        });
        toastEvent.fire();
    } 

})