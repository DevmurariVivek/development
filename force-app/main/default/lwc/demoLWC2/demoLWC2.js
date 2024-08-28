import { LightningElement } from 'lwc';

// const datamap = new Map();

export default class DemoLWC2 extends LightningElement {

    hidebutton = false;
    showdata = false;
    datamapvalue=new datamap;

    name = "vivek";
    location = "ahmd";
    designation = "lead";
    level = "4";

    handleclick(event){
        console.log("event value:-",event);
        this.showdata = true;
        this.hidebutton = true;
        
        console.log(' 111111---');
        datamapvalue.Name.set("heello");
        // datamap.set(Name.set('gsdgsfg'));
        datamapvalue.set('Location' , 'Ahemdabad');
        datamapvalue.set('Designation' , 'Lead');
        datamapvalue.set('Level' , '3');

        console.log('iooioioioioioioi---' ,this.datamap.get(Name));
    }

}


class datamap{
    Name;
}