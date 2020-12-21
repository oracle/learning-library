package com.mike.CallingCircle;

import java.sql.Date;


public class CustomerAccount {
    private Date lastFailedLogin;
    private Date lastLogin;
    private String name;
    private String pin;
    private String rowID;
    private String validFrom;
    private String validTo;
    private long failedLogins;
    private long id;

    public CustomerAccount() {
    }

    public long getFailedLogins() {
        return failedLogins;
    }

    public void setFailedLogins(long newFailedLogins) {
        failedLogins = newFailedLogins;
    }

    public long getId() {
        return id;
    }

    public void setId(long newId) {
        id = newId;
    }

    public java.sql.Date getLastFailedLogin() {
        return lastFailedLogin;
    }

    public java.sql.Date getLastLogin() {
        return lastLogin;
    }

    public String getName() {
        return name;
    }

    public void setName(String newName) {
        name = newName;
    }

    public String getPin() {
        return pin;
    }

    public void setPin(String newPin) {
        pin = newPin;
    }

    public String getRowID() {
        return rowID;
    }

    public void setRowID(String newRowID) {
        rowID = newRowID;
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

    public void setLastFailedLogin(Date newLastFailedLogin) {
        lastFailedLogin = newLastFailedLogin;
    }

    public void setLastLogin(Date newLastLogin) {
        lastLogin = newLastLogin;
    }
}
