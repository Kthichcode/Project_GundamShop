/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dto;

/**
 *
 * @author ADMIN
 */
public class UserDTO {

    private String userID;
    private String userName;
    private String roleID;
    private String password;
    private String email;

    public UserDTO() {
    }

    public UserDTO(String userID, String userName, String roleID, String password, String email) {
        this.userID = userID;
        this.userName = userName;
        this.roleID = roleID;
        this.password = password;
        this.email = email;
    }

    public UserDTO(String userName, String password, String email) {
        this.userName = userName;
        this.password = password;
        this.email = email;
    }
    
    

    public String getUserID() {
        return userID;
    }

    public void setUserID(String userID) {
        this.userID = userID;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getRoleID() {
        return roleID;
    }

    public void setRoleID(String roleID) {
        this.roleID = roleID;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    @Override
    public String toString() {
        return "UserDTO{" + "userID=" + userID + ", userName=" + userName + ", roleID=" + roleID + ", password=" + password + ", email=" + email + '}';
    }
 
}

 


