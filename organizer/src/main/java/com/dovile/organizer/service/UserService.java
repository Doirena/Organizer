package com.dovile.organizer.service;

import com.dovile.organizer.entities.User;

public interface UserService {
    void save(User user);

    User findByUsername(String username);
}
