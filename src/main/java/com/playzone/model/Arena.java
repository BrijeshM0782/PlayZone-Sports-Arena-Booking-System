
package com.playzone.model;

public class Arena {

    private int arenaId;
    private String arenaName;
    private String sportType;
    private String location;
    private double pricePerHour;
    private String description;
    private boolean active = true;

    public Arena() {
    }

    public Arena(int arenaId, String arenaName, String sportType,
                 String location, double pricePerHour,
                 String description) {

        this.arenaId = arenaId;
        this.arenaName = arenaName;
        this.sportType = sportType;
        this.location = location;
        this.pricePerHour = pricePerHour;
        this.description = description;
    }

    public int getArenaId() {
        return arenaId;
    }

    public void setArenaId(int arenaId) {
        this.arenaId = arenaId;
    }

    public String getArenaName() {
        return arenaName;
    }

    public void setArenaName(String arenaName) {
        this.arenaName = arenaName;
    }

    public String getSportType() {
        return sportType;
    }

    public void setSportType(String sportType) {
        this.sportType = sportType;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public double getPricePerHour() {
        return pricePerHour;
    }

    public void setPricePerHour(double pricePerHour) {
        this.pricePerHour = pricePerHour;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public boolean isActive() {
        return active;
    }

    public void setActive(boolean active) {
        this.active = active;
    }
}
