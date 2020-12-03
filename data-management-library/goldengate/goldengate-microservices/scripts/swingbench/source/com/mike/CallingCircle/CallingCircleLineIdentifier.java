package com.mike.CallingCircle;

import com.mike.CallingCircle.*;


public class CallingCircleLineIdentifier {
    private CallingLineIdentifier callingLineIdentifier;
    private String rowId;
    private String validFrom;
    private String validTo;
    private long indexId;

    public CallingCircleLineIdentifier() {
    }

    public CallingLineIdentifier getCallingLineIdentifier() {
        return callingLineIdentifier;
    }

    public void setCallingLineIdentifier(CallingLineIdentifier newCallingLineIdentifier) {
        callingLineIdentifier = newCallingLineIdentifier;
    }

    public long getIndexId() {
        return indexId;
    }

    public void setIndexId(long newIndexId) {
        indexId = newIndexId;
    }

    public String getRowId() {
        return rowId;
    }

    public void setRowId(String newRowId) {
        rowId = newRowId;
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
