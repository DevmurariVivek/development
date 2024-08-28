// checkDuplicates.js
import { LightningElement, api, wire } from 'lwc'; // To Import the Lightning Element and API decorator
import { NavigationMixin } from 'lightning/navigation'; // This will be used to perform navigation to a particular record page
import checkForDuplicates from '@salesforce/apex/duplicatesFinder.checkForDuplicates'; // This is importing the Apex class and its method that will communicate with this LWC component

const columns = [
    // Defining Columns to be used for Datatable in HTML
    { label: 'Name', fieldName: 'recordLink', type: 'url', typeAttributes: {label: {fieldName: 'Name'} , target: '_blank'}},
    { label: 'Record ID', fieldName: 'Id', type: 'text' }
]; 

const dataToDisplay = new Map();

export default class potentialduplicates extends NavigationMixin(LightningElement) {
    @api ObjectAPIName;         // This will track the ObjectAPIName from XML file (Which user has configured)
    @api recordId;              // This will track current record's Id which the component is added
    duplicatesFound = false;    // Making the duplicatesFound flag false initially
    buttonClicked = false;      // Making the buttonClicked flag false initially, to display the button
    duplicatesData = [];        // this is the array of data that will be passed from this JS after configuring it to HTML file
    columns = columns;          // this will pass the configured column data from JS to HTML 
    isShowModal = false;
    onNextSreen = false;
    currentRecordName;
    currentRecordCreatedDate;
    currentRecordModifiedDate;
    selectedRecordName;
    selectedRecordCreatedDate;
    selectedRecordModifiedDate;

    connectedCallback(){
        // console.log(this.ObjectAPIName); 
    }

    get mappedFields (){
        console.log(Array.from(this.dataToDisplay, ([key, value]) => ({ key, value })));
        return Array.from(this.dataToDisplay, ([key, value]) => ({ key, value }));

    }
    
    
    handleCheckDuplicates() {

        console.log('Clicked Check Duplicates button');
        console.log('recordId---' +this.recordId);
        console.log('ObjectAPIName---' +this.ObjectAPIName);
        // Call the Apex method and pass the recordId
        checkForDuplicates({ recordId: this.recordId, ObjectTofetch: this.ObjectAPIName }) // This will pass the values of recordId and ObjectAPIName to apex controller as its parameters 
        .then(result => {  // .then is holds the response that is been returned from Apex controller

            console.log('result---' +result);
            let StringifiedRecord = JSON.stringify(result);
            console.log('StringifiedRecord---' +StringifiedRecord);
            console.log('parsed records ---' +JSON.parse(StringifiedRecord));

            if (result) {

                console.log('inside if cluse---');
                this.duplicatesFound = true;
                this.duplicatesData = result['matchedrecords'].map(record => {
                    var obj = Object.assign({}, record);
                    obj.recordLink = '/' + obj.Id;
    
                    return obj;
                }) 
                this.buttonClicked = true;

                dataToDisplay.set('1*2', result['currentrecord'][0].Name);
                dataToDisplay.set('3*2', result['currentrecord'][0].CreatedDate);
                dataToDisplay.set('4*2', result['currentrecord'][0].LastModifiedDate);
                // this.currentRecordName = result['currentrecord'][0].Name;
                // this.currentRecordCreatedDate = result['currentrecord'][0].CreatedDate;
                // this.currentRecordModifiedDate - result['currentrecord'][0].LastModifiedDate;
                Console.log('currentRecordName---' +currentRecordName);
            

            } else {
                console.log('inside else cluse---');
                this.duplicatesFound = false;
                this.buttonClicked = true;

            }
        })
        
        .catch(error => {

        console.log('error---' +error);
        // Handle any errors
        });
    }

    handleMerge() {
        console.log('Clicked Merge button');
        this.isShowModal = true;

        var selectedRecords =  this.template.querySelector("lightning-datatable").getSelectedRows();
        console.log('selectedRecords---' +selectedRecords);

        var selectedrows = JSON.stringify(selectedRecords);
        console.log('selectedrows---' +selectedrows);

    
        if (selectedRecords.length > 0) {
            dataToDisplay.set('1*3', selectedRecords[0].Name);
            dataToDisplay.set('3*3', selectedRecords[0].CreatedDate);
            dataToDisplay.set('4*3', selectedRecords[0].LastModifiedDate);
            // this.selectedRecordName = selectedRecords[0].Name;
            // this.selectedRecordCreatedDate = selectedRecords[0].CreatedDate;
            // this.selectedRecordModifiedDate = selectedRecords[0].LastModifiedDate;
            
        }
        console.log('selectedrowsName---' +selectedrowsName);
        
    }

    hideModalBox(){
        this.isShowModal = false;
    }

    onNextScreen(){
        // this.isShowModal = false;
        this.onNextSreen = true;
    }

    onBackScreen(){
        this.isShowModal = true;
    }
}