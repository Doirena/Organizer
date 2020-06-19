package com.dovile.organizer.repository;


import org.springframework.data.jpa.repository.JpaRepository;

import com.dovile.organizer.entities.Role;

public interface RoleRepository extends JpaRepository<Role, Integer>{
}
