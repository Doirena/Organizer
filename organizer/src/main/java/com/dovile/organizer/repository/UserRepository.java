package com.dovile.organizer.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.dovile.organizer.entities.User;

public interface UserRepository extends JpaRepository<User, Integer> {
	User findByUsername(String username);

}
