import { LightningElement, wire } from 'lwc';
import getAccounts from '@salesforce/apex/lwcExample1Controller.getAccounts';

export default class LwcExample1 extends LightningElement {

    accountlist = [];
    showRecords = false;
    accName = '';

    // calling the apex method using imperetive call 
    buttonClicked(){
        console.log('Hola!! button was clicked');
    
        getAccounts({ accName: this.accName }) 
        .then(result => {
            console.log('Accounts retrieved: ', result);
            this.accountlist = result;
            this.showRecords = true;
        })
        .catch(error => {
            console.log('Error: ', error);
            this.accountlist = [];
            this.showRecords = false;
        });
    }

    handleInputChange(event) {
        this.accName = event.target.value;
        console.log('Account Name Entered: ', this.accName);
    }

    // calling the apex method using wire as a function
    // @wire (getAccounts , {accName : '$accName'}) 
    // accountdata({error,data}) { 
    //     if(data){
    //         this.accountlist = data;
    //         this.showRecords = true;
    //     }else if(error){
    //         this.accountlist = null;
    //         this.showRecords = true;
    //     }
    // }
}