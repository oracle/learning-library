package com.mike.CallingCircle;

public class CustomerCallingLineIdentifier extends Object {
    private CallingLineIdentifier callingLineIdentifier;
    private String callingCircleName;
    private String callingCircleRulesPLSQL;
    private String rowId;
    private String validFrom;
    private String validTo;
    private long callingCircleId;
    private long id;
    private long updates;
    private long updatesAllowed;

    public CustomerCallingLineIdentifier() {
    }

    public CallingLineIdentifier getCallingLineIdentifier() {
        return callingLineIdentifier;
    }

    public void setCallingLineIdentifier(CallingLineIdentifier newCallingLineIdentifier) {
        callingLineIdentifier = newCallingLineIdentifier;
    }

    public long getCallingCircleId() {
        return callingCircleId;
    }

    public void setCallingCircleId(long newCallingCircleId) {
        callingCircleId = newCallingCircleId;
    }

    public String getCallingCircleName() {
        return callingCircleName;
    }

    public void setCallingCircleName(String newCallingCircleName) {
        callingCircleName = newCallingCircleName;
    }

    public String getCallingCircleRulesPLSQL() {
        return callingCircleRulesPLSQL;
    }

    public void setCpPLSQL(String newCallingCircleRulesPLSQL) {
        callingCircleRulesPLSQL = newCallingCircleRulesPLSQL;
    }

    public long getId() {
        return id;
    }

    public void setId(long newId) {
        id = newId;
    }

    public String getRowId() {
        return rowId;
    }

    public void setRowId(String newRowId) {
        rowId = newRowId;
    }

    public long getUpdates() {
        return updates;
    }

    public void setUpdates(long newUpdates) {
        updates = newUpdates;
    }

    public long getUpdatesAllowed() {
        return updatesAllowed;
    }

    public void setUpdatesAllowed(long newUpdatesAllowed) {
        updatesAllowed = newUpdatesAllowed;
    }

    public String getValidFrom() {
        return validFrom;
    }

    public void setValidFrom(String newValidFrom) {
        validFrom = newValidFrom;
    }

    public String getValidTo() {
        return validTo;
    }

    public void setValidTo(String newValidTo) {
        validTo = newValidTo;
    }
}
