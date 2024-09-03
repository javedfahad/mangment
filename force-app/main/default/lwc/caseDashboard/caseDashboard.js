// import { LightningElement, track, wire } from 'lwc';
// import getCases from '@salesforce/apex/CaseDashboardController.getCases';

// const COLUMNS = [
//     { label: 'Case Number', fieldName: 'CaseNumber' },
//     { label: 'Subject', fieldName: 'Subject' },
//     { label: 'Priority', fieldName: 'Priority' },
//     { label: 'Status', fieldName: 'Status' },
//     { label: 'SLA Due Date', fieldName: 'SLA_Due_Date__c' },
//     { label: 'Survey Rating', fieldName: 'Survey_Rating__c' },
//     { label: 'Resolution Status', fieldName: 'Resolution_Status__c' },
//     {
//         type: 'button',
//         typeAttributes: {
//             label: 'View Details',
//             name: 'view_details',
//             title: 'View Details',
//             iconName: 'utility:preview',
//             variant: 'base'
//         }
//     }
// ];

// export default class CaseDashboard extends LightningElement {
//     @track cases = [];
//     @track priority = '';
//     @track status = '';
//     @track slaDueDate = '';
//     columns = COLUMNS;

//     priorityOptions = [
//         { label: 'High', value: 'High' },
//         { label: 'Medium', value: 'Medium' },
//         { label: 'Low', value: 'Low' }
//     ];

//     statusOptions = [
//         { label: 'New', value: 'New' },
//         { label: 'In Progress', value: 'In Progress' },
//         { label: 'Closed', value: 'Closed' }
//     ];

//     @wire(getCases, { priority: '$priority', status: '$status', slaDueDate: '$slaDueDate' })
//     wiredCases({ error, data }) {
//         if (data) {
//             this.cases = data;
//         } else if (error) {
//             console.error('Error fetching cases', error);
//         }
//     }

//     handlePriorityChange(event) {
//         this.priority = event.detail.value;
//     }

//     handleStatusChange(event) {
//         this.status = event.detail.value;
//     }

//     handleSlaDueDateChange(event) {
//         this.slaDueDate = event.detail.value;
//     }

//     handleRowAction(event) {
//         const actionName = event.detail.action.name;
//         const caseId = event.detail.row.Id;
//         if (actionName === 'view_details') {
//             // Dispatch a custom event with the selected case ID
//             this.dispatchEvent(new CustomEvent('caseview', { detail: { caseId } }));
//         }
//     }
// }


import { LightningElement, track, wire } from 'lwc';
import getCases from '@salesforce/apex/CaseDashboardController.getCases';

const COLUMNS = [
    { label: 'Case Number', fieldName: 'CaseNumber' },
    { label: 'Subject', fieldName: 'Subject' },
    { label: 'Priority', fieldName: 'Priority' },
    { label: 'Status', fieldName: 'Status' },
    { label: 'SLA Due Date', fieldName: 'SLA_Due_Date__c' },
    { label: 'Survey Rating', fieldName: 'Survey_Rating__c' },
    { label: 'Resolution Status', fieldName: 'Resolution_Status__c' },
    {
        type: 'button',
        typeAttributes: {
            label: 'View Details',
            name: 'view_details',
            title: 'View Details',
            iconName: 'utility:preview',
            variant: 'base'
        }
    }
];

export default class CaseDashboard extends LightningElement {
    @track cases = [];
    @track priority = '';
    @track status = '';
    @track slaDueDate = '';
    columns = COLUMNS;

    priorityOptions = [
        { label: 'High', value: 'High' },
        { label: 'Medium', value: 'Medium' },
        { label: 'Low', value: 'Low' }
    ];

    statusOptions = [
        { label: 'New', value: 'New' },
        { label: 'In Progress', value: 'In Progress' },
        { label: 'Closed', value: 'Closed' }
    ];

    @wire(getCases, { priority: '$priority', status: '$status', slaDueDate: '$slaDueDate' })
    wiredCases({ error, data }) {
        if (data) {
            this.cases = data;
        } else if (error) {
            console.error('Error fetching cases', error);
        }
    }

    handlePriorityChange(event) {
        this.priority = event.detail.value;
    }

    handleStatusChange(event) {
        this.status = event.detail.value;
    }

    handleSlaDueDateChange(event) {
        this.slaDueDate = event.detail.value;
    }

    handleRowAction(event) {
        const actionName = event.detail.action.name;
        const caseId = event.detail.row.Id;
        if (actionName === 'view_details') {
            // Dispatch a custom event with the selected case ID
            this.dispatchEvent(new CustomEvent('caseview', { detail: { caseId } }));
        }
    }
}
