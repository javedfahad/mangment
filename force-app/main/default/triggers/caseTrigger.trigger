trigger caseTrigger on Case (before insert, before update) {

    if (Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate)) {
        // Call the handler method to calculate SLA Due Date
        caseTriggerHandler.calculateSLADueDate(Trigger.new);
    }

    if (Trigger.isAfter && (Trigger.isInsert || Trigger.isUpdate)) {
        // Call the handler method to send SLA violation notifications
        caseTriggerHandler.sendSLAViolationNotifications(Trigger.new);
    }
}


