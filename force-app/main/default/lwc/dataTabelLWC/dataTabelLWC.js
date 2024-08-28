import { LightningElement } from 'lwc';

export default class dataTabelLWC extends LightningElement {

    columndata = [
        {label :'Account Id' , fieldName: 'Id'},
        {label :'Name' , fieldName: 'Name'},
        {label :'Email' , fieldName: 'Email', type:'email'}
    ];

    rowdata = [
        {
            Id : '1',
            Name : 'Row 1',
            Email : 'vivek.devmurari1214@gmail.com'
        },
        {
            Id : '2',
            Name : 'Row 2',
            Email : 'vivek.devmurari1214@gmail.com'
        },
        {
            Id : '3',
            Name : 'Row 3',
            Email : 'vivek.devmurari1214@gmail.com'
        }
    ];
}