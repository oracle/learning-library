package com.mike.CallingCircle;

public class CallingLineIdentifier {
    private String CountryText;
    private String CountryType;
    private String CountryValue;
    private String RegionText;
    private String callingLineIdentifier;
    private String regionType;
    private String regionValue;
    private long id;

    public CallingLineIdentifier() {
    }

    public String getCountryText() {
        return CountryText;
    }

    public void setCountryText(String newCountryText) {
        CountryText = newCountryText;
    }

    public String getCountryType() {
        return CountryType;
    }

    public void setCountryType(String newCountryType) {
        CountryType = newCountryType;
    }

    public String getCountryValue() {
        return CountryValue;
    }

    public void setCountryValue(String newCountryValue) {
        CountryValue = newCountryValue;
    }

    public String getRegionText() {
        return RegionText;
    }

    public void setRegionText(String newRegionText) {
        RegionText = newRegionText;
    }

    public String getCallingLineIdentifier() {
        return callingLineIdentifier;
    }

    public void setCallingLineIdentifier(String newCallingLineIdentifier) {
        callingLineIdentifier = newCallingLineIdentifier;
    }

    public long getId() {
        return id;
    }

    public void setId(long newId) {
        id = newId;
    }

    public String getRegionType() {
        return regionType;
    }

    public void setRegionType(String newRegionType) {
        regionType = newRegionType;
    }

    public String getRegionValue() {
        return regionValue;
    }

    public void setRegionValue(String newRegionValue) {
        regionValue = newRegionValue;
    }
}
