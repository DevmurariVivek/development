import { LightningElement } from 'lwc';

export default class LWCDatabinding extends LightningElement {

    //outputName = '';
    firstName = '';
    lastName = '';

    handleChange(event) {

        if(event.target.name == 'fname'){
            
            this.firstName = event.target.value;
        }else{
            this.lastName = event.target.value;
        }

        //this.outputName = this.firstName.toUpperCase() + this.lastName.toUpperCase();
    }
    //getter function to pass data from js to html's property 
    get outputName (){
        return  `${this.firstName} ${this.lastName}`.toUpperCase();
    }
}