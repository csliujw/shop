package org.shop.pojo;

/**
 * admin
 */
public class Admin {
    private String adminId;
    private String adminUsername;
    private String adminPassword;
    private int adminOrSuper;
    private String adminTel;

    public String getAdminId() {
        return adminId;
    }

    public void setAdminId(String adminId) {
        this.adminId = adminId;
    }

    public String getAdminUsername() {
        return adminUsername;
    }

    public void setAdminUsername(String adminUsername) {
        this.adminUsername = adminUsername;
    }

    public String getAdminPassword() {
        return adminPassword;
    }

    public void setAdminPassword(String adminPassword) {
        this.adminPassword = adminPassword;
    }

    public int getAdminOrSuper() {
        return adminOrSuper;
    }

    public void setAdminOrSuper(int adminOrSuper) {
        this.adminOrSuper = adminOrSuper;
    }

    public String getAdminTel() {
        return adminTel;
    }

    public void setAdminTel(String adminTel) {
        this.adminTel = adminTel;
    }

    @Override
    public String toString() {
        return "Admin{" +
                "adminId='" + adminId + '\'' +
                ", adminUsername='" + adminUsername + '\'' +
                ", adminPassword='" + adminPassword + '\'' +
                ", adminOrSuper='" + adminOrSuper + '\'' +
                ", adminTel='" + adminTel + '\'' +
                '}';
    }
}
