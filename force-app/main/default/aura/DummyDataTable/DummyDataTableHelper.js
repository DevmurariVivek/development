({
    setupDataTable: function (component) {
        component.set('v.columns', [
            {label: 'Album Id', fieldName: 'albumId', type: 'text'},
            {label: 'Id', fieldName: 'id', type: 'text'},
            {label: 'Title', fieldName: 'title',  type: 'text', wrapText: true},
            {label: 'URL', fieldName: 'url',  type: 'url'},
            {label: 'Thumbnail URL', fieldName: 'thumbnailUrl',  type: 'url'}
        ]);
    },
 
    getData: function (component) {
        return this.callAction(component)
            .then(
                $A.getCallback(imageRecords => {
                    component.set('v.allData', imageRecords);
                    component.set('v.filteredData', imageRecords);
                    this.preparePagination(component, imageRecords);
                })
            )
            .catch(
                $A.getCallback(errors => {
                    if (errors && errors.length > 0) {
                        $A.get("e.force:showToast")
                            .setParams({
                                message: errors[0].message != null ? errors[0].message : errors[0],
                                type: "error"
                            })
                            .fire();
                    }
                })
            );
    },
 
    callAction: function (component) {
        component.set("v.isLoading", true);
        return new Promise(
            $A.getCallback((resolve, reject) => {
                const action = component.get("c.getImageRecords");
                action.setCallback(this, response => {
                    component.set("v.isLoading", false);
                    const state = response.getState();
                    if (state === "SUCCESS") {
                        return resolve(response.getReturnValue());
                    } else if (state === "ERROR") {
                        return reject(response.getError());
                    }
                    return null;
                });
                $A.enqueueAction(action);
            })
        );
    },
 
    preparePagination: function (component, imagesRecords) {
        let countTotalPage = Math.ceil(imagesRecords.length/component.get("v.pageSize"));
        let totalPage = countTotalPage > 0 ? countTotalPage : 1;
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
    },
 
    searchRecordsBySearchPhrase : function (component) {
        let searchPhrase = component.get("v.searchPhrase");
        if (!$A.util.isEmpty(searchPhrase)) {
            let allData = component.get("v.allData");
            let filteredData = allData.filter(record => record.title.includes(searchPhrase));
            component.set("v.filteredData", filteredData);
            this.preparePagination(component, filteredData);
        }
    },
})