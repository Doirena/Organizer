package com.dovile.organizer.service;

public interface SecurityService {
    String findLoggedInUsername();

    void autologin(String username, String password);
}
