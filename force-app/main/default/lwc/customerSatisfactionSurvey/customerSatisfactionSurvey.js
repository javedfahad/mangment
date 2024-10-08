import { LightningElement, track } from 'lwc';
import submitSurvey from '@salesforce/apex/CustomerSatisfactionApexController.submitSurvey';

export default class CustomerSatisfaction extends LightningElement {
    @track name = '';
    @track rating = '';
    @track comments = '';

    ratingOptions = [
        { label: '1 - Poor', value: '1' },
        { label: '2 - Fair', value: '2' },
        { label: '3 - Good', value: '3' },
        { label: '4 - Very Good', value: '4' },
        { label: '5 - Excellent', value: '5' }
    ];

    handleNameChange(event) {
        this.name = event.detail.value;
    }

    handleRatingChange(event) {
        this.rating = event.detail.value;
    }

    handleCommentsChange(event) {
        this.comments = event.detail.value;
    }

    handleSubmit() {
        submitSurvey({ name: this.name, rating: this.rating, comments: this.comments })
            .then(() => {
                // Handle successful submission
                this.name = '';
                this.rating = '';
                this.comments = '';
                // Show success message or redirect
            })
            .catch(error => {
                // Handle error
                console.error('Error:', error);
            });
    }
}
